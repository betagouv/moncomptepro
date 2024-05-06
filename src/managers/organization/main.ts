import { isEmpty, some } from "lodash-es";
import { NotFoundError } from "../../config/errors";
import {
  findById as findOrganizationById,
  findByUserId,
  findPendingByUserId,
  getUsers,
} from "../../repositories/organization/getters";
import {
  addVerifiedDomain,
  deleteUserOrganization,
  updateUserOrganizationLink,
} from "../../repositories/organization/setters";
import { setSelectedOrganizationId } from "../../repositories/redis/selected-organization";
import { getEmailDomain } from "../../services/uses-a-free-email-provider";

export const getOrganizationsByUserId = findByUserId;
export const getOrganizationById = findOrganizationById;
export const getUserOrganizations = async ({
  user_id,
}: {
  user_id: number;
}): Promise<{
  userOrganizations: Organization[];
  pendingUserOrganizations: Organization[];
}> => {
  const userOrganizations = await findByUserId(user_id);
  const pendingUserOrganizations = await findPendingByUserId(user_id);

  return { userOrganizations, pendingUserOrganizations };
};
export const quitOrganization = async ({
  user_id,
  organization_id,
}: {
  user_id: number;
  organization_id: number;
}) => {
  const hasBeenRemoved = await deleteUserOrganization({
    user_id,
    organization_id,
  });

  if (!hasBeenRemoved) {
    throw new NotFoundError();
  }

  return true;
};
export const markDomainAsVerified = async ({
  organization_id,
  domain,
  verification_type,
}: {
  organization_id: number;
  domain: string;
  verification_type: EmailDomains["type"];
}) => {
  const organization = await findOrganizationById(organization_id);
  if (isEmpty(organization)) {
    throw new NotFoundError();
  }

  const { siret, email_domains } = organization;

  if (!some(email_domains, { domain, type: verification_type })) {
    // TODO we should do an upsert here and update the verification date
    await addVerifiedDomain({ siret, domain });
  }

  const usersInOrganization = await getUsers(organization_id);

  await Promise.all(
    usersInOrganization.map(
      ({ id, email, verification_type: current_verification_type }) => {
        const userDomain = getEmailDomain(email);
        if (userDomain === domain && isEmpty(current_verification_type)) {
          return updateUserOrganizationLink(organization_id, id, {
            verification_type: "domain",
          });
        }

        return null;
      },
    ),
  );
};

export const selectOrganization = async ({
  user_id,
  organization_id,
}: {
  user_id: number;
  organization_id: number;
}) => {
  const userOrganizations = await getOrganizationsByUserId(user_id);
  const organization = userOrganizations.find(
    ({ id }) => id === organization_id,
  );

  if (isEmpty(organization)) {
    throw new NotFoundError();
  }

  await setSelectedOrganizationId(user_id, organization_id);
};
