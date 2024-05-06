import * as Sentry from "@sentry/node";
import { isEmpty, some } from "lodash-es";
import { MAX_SUGGESTED_ORGANIZATIONS } from "../../config/env";
import {
  InseeConnectionError,
  InseeNotActiveError,
  InvalidSiretError,
  NotFoundError,
  UnableToAutoJoinOrganizationError,
  UserAlreadyAskedToJoinOrganizationError,
  UserInOrganizationAlreadyError,
  UserMustConfirmToJoinOrganizationError,
  UserNotFoundError,
} from "../../config/errors";
import { getAnnuaireEducationNationaleContactEmail } from "../../connectors/api-annuaire-education-nationale";
import { getAnnuaireServicePublicContactEmail } from "../../connectors/api-annuaire-service-public";
import { getOrganizationInfo } from "../../connectors/api-sirene";
import { sendZammadMail } from "../../connectors/send-zammad-mail";
import {
  createModeration,
  findPendingModeration,
} from "../../repositories/moderation";
import {
  findById,
  findByUserId,
  findByVerifiedEmailDomain,
} from "../../repositories/organization/getters";
import {
  addAuthorizedDomain,
  linkUserToOrganization,
  upsert,
} from "../../repositories/organization/setters";
import { findById as findUserById } from "../../repositories/user";
import { logger } from "../../services/log";
import {
  hasLessThanFiftyEmployees,
  isCommune,
  isEducationNationaleDomain,
  isEntrepriseUnipersonnelle,
  isEtablissementScolaireDuPremierEtSecondDegre,
} from "../../services/organization";
import { isEmailValid } from "../../services/security";
import {
  getEmailDomain,
  isAFreeEmailProvider,
  usesAFreeEmailProvider,
} from "../../services/uses-a-free-email-provider";
import { markDomainAsVerified } from "./main";

export const doSuggestOrganizations = async ({
  user_id,
  email,
}: {
  user_id: number;
  email: string;
}): Promise<boolean> => {
  if (usesAFreeEmailProvider(email)) {
    return false;
  }

  const domain = getEmailDomain(email);
  const organizationsSuggestions = await findByVerifiedEmailDomain(domain);
  const userOrganizations = await findByUserId(user_id);

  return (
    isEmpty(userOrganizations) &&
    !isEmpty(organizationsSuggestions) &&
    organizationsSuggestions.length <= MAX_SUGGESTED_ORGANIZATIONS
  );
};
export const getOrganizationSuggestions = async ({
  user_id,
  email,
}: {
  user_id: number;
  email: string;
}): Promise<Organization[]> => {
  if (usesAFreeEmailProvider(email)) {
    return [];
  }

  const domain = getEmailDomain(email);

  if (isEducationNationaleDomain(domain)) {
    return [];
  }

  const organizationsSuggestions = await findByVerifiedEmailDomain(domain);

  if (organizationsSuggestions.length > MAX_SUGGESTED_ORGANIZATIONS) {
    return [];
  }

  const userOrganizations = await findByUserId(user_id);
  const userOrganizationsIds = userOrganizations.map(({ id }) => id);

  return organizationsSuggestions.filter(
    ({ id }) => !userOrganizationsIds.includes(id),
  );
};
export const joinOrganization = async ({
  siret,
  user_id,
  confirmed = false,
}: {
  siret: string;
  user_id: number;
  confirmed: boolean;
}): Promise<UserOrganizationLink> => {
  // Update organizationInfo
  let organizationInfo: OrganizationInfo;
  try {
    organizationInfo = await getOrganizationInfo(siret);
  } catch (error) {
    if (error instanceof InseeConnectionError) {
      throw error;
    }

    throw new InvalidSiretError();
  }
  let organization = await upsert({
    siret,
    organizationInfo,
  });

  // Ensure the organization is active
  if (!organization.cached_est_active) {
    throw new InseeNotActiveError();
  }

  // Ensure user_id is valid
  const user = await findUserById(user_id);
  if (isEmpty(user)) {
    throw new UserNotFoundError();
  }

  const usersOrganizations = await findByUserId(user_id);
  if (some(usersOrganizations, ["id", organization.id])) {
    throw new UserInOrganizationAlreadyError();
  }

  const pendingModeration = await findPendingModeration({
    user_id,
    organization_id: organization.id,
    type: "organization_join_block",
  });
  if (!isEmpty(pendingModeration)) {
    const { id: moderation_id } = pendingModeration;
    throw new UserAlreadyAskedToJoinOrganizationError(moderation_id);
  }

  const { id: organization_id, cached_libelle, email_domains } = organization;
  const { email } = user;
  const domain = getEmailDomain(email);

  if (isEntrepriseUnipersonnelle(organization)) {
    if (!usesAFreeEmailProvider(email)) {
      await addAuthorizedDomain({ siret, domain });
    }

    return await linkUserToOrganization({
      organization_id,
      user_id,
      verification_type: "no_verification_means_for_unipersonnel_org",
    });
  }

  if (
    isAFreeEmailProvider(email) &&
    !hasLessThanFiftyEmployees(organization) &&
    !confirmed
  ) {
    throw new UserMustConfirmToJoinOrganizationError(organization_id);
  }

  if (
    isCommune(organization) &&
    !isEtablissementScolaireDuPremierEtSecondDegre(organization)
  ) {
    let contactEmail;
    try {
      contactEmail = await getAnnuaireServicePublicContactEmail(
        organization.cached_code_officiel_geographique,
        organization.cached_code_postal,
      );
    } catch (err) {
      logger.error(err);
      Sentry.captureException(err);
    }

    if (isEmailValid(contactEmail)) {
      const contactDomain = getEmailDomain(contactEmail);

      if (!isAFreeEmailProvider(contactDomain)) {
        await markDomainAsVerified({
          organization_id,
          domain: contactDomain,
          verification_type: "official_contact",
        });
      }

      if (contactEmail === email) {
        return await linkUserToOrganization({
          organization_id,
          user_id,
          verification_type: "official_contact_email",
        });
      }

      if (!isAFreeEmailProvider(contactDomain) && contactDomain === domain) {
        return await linkUserToOrganization({
          organization_id,
          user_id,
          verification_type: "official_contact_domain",
        });
      }

      if (
        (isAFreeEmailProvider(contactDomain) ||
          hasLessThanFiftyEmployees(organization)) &&
        isAFreeEmailProvider(domain)
      ) {
        return await linkUserToOrganization({
          organization_id,
          user_id,
          verification_type: null,
          needs_official_contact_email_verification: true,
        });
      }
    }
  }

  if (isEtablissementScolaireDuPremierEtSecondDegre(organization)) {
    let contactEmail;
    try {
      contactEmail = await getAnnuaireEducationNationaleContactEmail(siret);
    } catch (err) {
      logger.error(err);
      Sentry.captureException(err);
    }

    if (contactEmail === email) {
      return await linkUserToOrganization({
        organization_id,
        user_id,
        verification_type: "official_contact_email",
      });
    }

    if (isEmailValid(contactEmail)) {
      return await linkUserToOrganization({
        organization_id,
        user_id,
        verification_type: null,
        needs_official_contact_email_verification: true,
      });
    }
  }

  if (verified_email_domains.includes(domain)) {
    return await linkUserToOrganization({
      organization_id,
      user_id,
      verification_type: "verified_email_domain",
    });
  }

  if (external_authorized_email_domains.includes(domain)) {
    return await linkUserToOrganization({
      organization_id,
      user_id,
      is_external: true,
      verification_type: "verified_email_domain",
    });
  }

  if (trackdechets_email_domains.includes(domain)) {
    return await linkUserToOrganization({
      organization_id,
      user_id,
      verification_type: "trackdechets_email_domain",
    });
  }

  if (authorized_email_domains.includes(domain)) {
    await createModeration({
      user_id,
      organization_id,
      type: "non_verified_domain",
      ticket_id: null,
    });
    return await linkUserToOrganization({
      organization_id,
      user_id,
      verification_type: "null",
    });
  }

  const ticket = await sendZammadMail({
    to: email,
    subject: `[MonComptePro] Demande pour rejoindre ${cached_libelle || siret}`,
    template: "unable-to-auto-join-organization",
    params: {
      libelle: cached_libelle || siret,
    },
  });

  const { id: moderation_id } = await createModeration({
    user_id,
    organization_id,
    type: "organization_join_block",
    ticket_id: ticket.id,
  });

  throw new UnableToAutoJoinOrganizationError(moderation_id);
};
export const forceJoinOrganization = async ({
  organization_id,
  user_id,
  is_external = false,
}: {
  organization_id: number;
  user_id: number;
  is_external?: boolean;
}) => {
  const user = await findUserById(user_id);
  const organization = await findById(organization_id);
  if (isEmpty(user) || isEmpty(organization)) {
    throw new NotFoundError();
  }
  const { email } = user;
  const {
    verified_email_domains,
    external_authorized_email_domains,
    trackdechets_email_domains,
  } = organization;

  const domain = getEmailDomain(email);

  let verification_type: BaseUserOrganizationLink["verification_type"];
  if (
    verified_email_domains.includes(domain) ||
    external_authorized_email_domains.includes(domain)
  ) {
    verification_type = "verified_email_domain";
  } else if (trackdechets_email_domains.includes(domain)) {
    verification_type = "trackdechets_email_domain";
  } else {
    verification_type = null;
  }

  return await linkUserToOrganization({
    organization_id,
    user_id,
    is_external,
    verification_type,
  });
};
