//

import {
  getMagicLinkFromEmail,
  getVerificationCodeFromEmail,
} from "../support/get-from-email.js";

//

before(() => {
  cy.seed();
});

describe("sign-in with magic link", () => {
  before(() => {
    cy.mailslurp().then((mailslurp) =>
      mailslurp.inboxController.deleteAllInboxEmails({
        inboxId: "66ac0a4c-bd2d-490e-a277-1e7c2520100d",
      }),
    );
  });

  it("should sign-up with magic link", function () {
    cy.visit(`/users/start-sign-in`);

    cy.get('[name="login"]').type(
      "66ac0a4c-bd2d-490e-a277-1e7c2520100d@mailslurp.com",
    );
    cy.get('[type="submit"]').click();

    cy.get('[action="/users/send-magic-link"]  [type="submit"]')
      .contains("Envoyer le lien")
      .click();

    cy.contains("Votre lien vous attend à l’adresse...");

    cy.mailslurp()
      // use inbox id and a timeout of 30 seconds
      .then((mailslurp) =>
        mailslurp.waitForLatestEmail(
          "66ac0a4c-bd2d-490e-a277-1e7c2520100d",
          60000,
          true,
        ),
      )
      // extract the connection link from the email subject
      .then(getMagicLinkFromEmail)
      .then((link) => {
        cy.visit(link);
      });

    cy.contains("Renseigner son identité");
  });

  it("should sign-in with magic link without setting password", function () {
    cy.visit(`/users/start-sign-in`);

    cy.get('[name="login"]').type(
      "66ac0a4c-bd2d-490e-a277-1e7c2520100d@mailslurp.com",
    );
    cy.get('[type="submit"]').click();

    cy.contains(
      "Pour des raisons de sécurité, nous vous invitons à définir un nouveau mot de passe",
    );

    cy.get('[action="/users/send-magic-link"]  [type="submit"]')
      .contains("Envoyer le lien")
      .click();

    cy.contains("Votre lien vous attend à l’adresse...");

    cy.mailslurp()
      // use inbox id and a timeout of 30 seconds
      .then((mailslurp) =>
        mailslurp.waitForLatestEmail(
          "66ac0a4c-bd2d-490e-a277-1e7c2520100d",
          60000,
          true,
        ),
      )
      // extract the connection link from the email subject
      .then(getMagicLinkFromEmail)
      .then((link) => {
        cy.visit(link);
      });

    cy.contains("Renseigner son identité");
  });

  it("should set a password", function () {
    cy.visit(`/users/start-sign-in`);

    cy.get('[name="login"]').type(
      "66ac0a4c-bd2d-490e-a277-1e7c2520100d@mailslurp.com",
    );
    cy.get('[type="submit"]').click();

    cy.get('[name="password"]').type(
      "This super secret password is hidden well!",
    );
    cy.get('[action="/users/sign-up"]  [type="submit"]').click();

    cy.mailslurp()
      .then((mailslurp) =>
        mailslurp.waitForLatestEmail(
          "66ac0a4c-bd2d-490e-a277-1e7c2520100d",
          60000,
          true,
        ),
      )
      .then(getVerificationCodeFromEmail)
      .then((code) => {
        cy.get('[name="verify_email_token"]').type(code);
        cy.get('[type="submit"]').click();
      });

    cy.contains("Renseigner son identité");
  });

  it("should sign-in with magic link without set password prompt", function () {
    cy.visit(`/users/start-sign-in`);

    cy.get('[name="login"]').type(
      "66ac0a4c-bd2d-490e-a277-1e7c2520100d@mailslurp.com",
    );
    cy.get('[type="submit"]').click();

    cy.contains(
      "Pour des raisons de sécurité, nous vous invitons à définir un nouveau mot de passe",
    ).should("not.exist");

    cy.get('[action="/users/send-magic-link"]  [type="submit"]')
      .contains("Recevoir un lien d’identification")
      .click();

    cy.contains("Votre lien vous attend à l’adresse...");

    cy.mailslurp()
      // use inbox id and a timeout of 30 seconds
      .then((mailslurp) =>
        mailslurp.waitForLatestEmail(
          "66ac0a4c-bd2d-490e-a277-1e7c2520100d",
          60000,
          true,
        ),
      )
      // extract the connection link from the email subject
      .then(getMagicLinkFromEmail)
      .then((link) => {
        cy.visit(link);
      });

    cy.contains("Renseigner son identité");
  });
});
