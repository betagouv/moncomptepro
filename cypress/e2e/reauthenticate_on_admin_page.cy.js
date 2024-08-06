//

import { generateToken } from "@sunknudsen/totp";

//

const login = (cy) => {
  cy.get('[name="login"]').type("unused1@yopmail.com");
  cy.get('[type="submit"]').click();

  cy.get('[name="password"]').type("password123");
  cy.get('[action="/users/sign-in"]  [type="submit"]')
    .contains("S’identifier")
    .click();
};

const tfaAuth = (cy) => {
  const totp = generateToken("din5ncvbluqpx7xfzqcybmibmtjocnsf", Date.now());
  cy.get("[name=totpToken]").type(totp);
  cy.get(
    '[action="/users/2fa-sign-in-with-authenticator-app"] [type="submit"]',
  ).click();
};

before(() => {
  cy.seed();
});

describe("force recent connexion + 2FA on admin pages", () => {
  it("should be redirected after long connexion", function () {
    cy.visit("/");

    login(cy);

    cy.contains("Votre compte est créé");

    cy.visit("/connection-and-account");

    cy.contains("merci de valider votre deuxième étape de connexion");

    tfaAuth(cy);

    cy.contains("Connexion et compte");

    // Wait for connexion to last
    cy.wait(5 * 1000);

    cy.get(
      '[action="/delete-authenticator-app-configuration"]  [type="submit"]',
    )
      .contains("Supprimer l’application d’authentification")
      .click();

    cy.contains("merci de vous identifier à nouveau");

    login(cy);
    tfaAuth(cy);

    cy.contains("Connexion et compte");
  });
});
