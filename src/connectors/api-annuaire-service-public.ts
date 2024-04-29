import axios, { AxiosError, AxiosResponse } from "axios";
import { isEmpty, isString } from "lodash-es";
import {
  DO_NOT_USE_ANNUAIRE_EMAILS,
  HTTP_CLIENT_TIMEOUT,
  TEST_CONTACT_EMAIL,
} from "../config/env";
import {
  ApiAnnuaireConnectionError,
  ApiAnnuaireInvalidEmailError,
  ApiAnnuaireNotFoundError,
  ApiAnnuaireTooManyResultsError,
} from "../config/errors";
import { logger } from "../services/log";
import { isEmailValid } from "../services/security";

// more info at https://etablissements-publics.api.gouv.fr/v3/definitions.yaml
// the API used is more up to date than the official one: https://etablissements-publics.api.gouv.fr/v3/definitions.yaml
type ApiAnnuaireServicePublicReponse = {
  type: "FeatureCollection";
  features: {
    type: "Feature";
    geometry: {
      type: "Point";
      coordinates: [number, number];
    };
    properties: {
      // ex: "4b3bd44a-f249-4a3c-8c54-b3479c3a2f92"
      id: string;
      // ex: "74056"
      codeInsee: string;
      // ex: "mairie
      pivotLocal: string;
      // ex: "Mairie - Chamonix-Mont-Blanc"
      nom: string;
      adresses: {
        type: "Adresse";
        // ex: ["38 place de l'Église"]
        lignes: string[];
        // ex: '74402'
        codePostal: string;
        // ex: 'Chamonix Cedex'
        commune: string;
      }[];
      // ex: 'sg@chamonix.fr'
      email?: string;
      // ex: '04 50 53 11 13'
      telephone: string;
      // ex: 'http://www.chamonix-mont-blanc.fr'
      url: string;
      zonage: {
        // ex: ['74056 Chamonix-Mont-Blanc']
        communes: string[];
      };
    };
  }[];
};

export const getAnnuaireServicePublicContactEmail = async (
  codeOfficielGeographique: string | null,
  codePostal: string | null,
): Promise<string> => {
  if (isEmpty(codeOfficielGeographique)) {
    throw new ApiAnnuaireNotFoundError();
  }

  let features: ApiAnnuaireServicePublicReponse["features"] = [];
  try {
    const { data }: AxiosResponse<ApiAnnuaireServicePublicReponse> =
      await axios({
        method: "get",
        url: `https://etablissements-publics.api.gouv.fr/v3/communes/${codeOfficielGeographique}/mairie`,
        headers: {
          accept: "application/json",
        },
        timeout: HTTP_CLIENT_TIMEOUT,
      });

    features = data.features;
  } catch (e) {
    if (
      e instanceof AxiosError &&
      (e.code === "ECONNABORTED" ||
        e.code === "ERR_BAD_RESPONSE" ||
        e.code === "EAI_AGAIN")
    ) {
      throw new ApiAnnuaireConnectionError();
    }

    throw e;
  }

  let feature: ApiAnnuaireServicePublicReponse["features"][0] | undefined;

  if (features.length === 1) {
    feature = features[0];
  }

  if (features.length > 1) {
    if (isEmpty(codePostal)) {
      // without postal code we cannot choose a mairie
      throw new ApiAnnuaireTooManyResultsError();
    }

    // Take the first match
    feature = features.find(
      ({
        properties: {
          adresses: [{ codePostal: codePostalMairie }],
        },
      }) => codePostalMairie === codePostal,
    );
  }

  if (isEmpty(feature)) {
    throw new ApiAnnuaireNotFoundError();
  }

  const {
    properties: { email },
  } = feature;

  if (!isString(email)) {
    throw new ApiAnnuaireInvalidEmailError();
  }

  const formattedEmail = email.toLowerCase().trim();

  if (!isEmailValid(formattedEmail)) {
    throw new ApiAnnuaireInvalidEmailError();
  }

  if (DO_NOT_USE_ANNUAIRE_EMAILS) {
    logger.info(
      `Test email address ${TEST_CONTACT_EMAIL} was used instead of the real one ${formattedEmail}.`,
    );
    return TEST_CONTACT_EMAIL;
  }

  return formattedEmail;
};
