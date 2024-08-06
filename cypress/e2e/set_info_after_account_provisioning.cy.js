//

import { getVerificationCodeFromEmail } from "../support/get-from-email.js";

before(() => {
  cy.seed();
});

describe("set info after account provisioning", () => {
  before(() => {
    cy.mailslurp().then((mailslurp) =>
      mailslurp.inboxController.deleteAllInboxEmails({
        inboxId: "ea2f1539-9675-4384-ab28-4dcecd0bd411",
      }),
    );
  });

  it("should show InclusionConnect welcome page on first visit", function () {
    // Visit the signup page
    cy.visit(`/users/start-sign-in`);

    // Sign in with the wrong password
    cy.get('[name="login"]').type(
      "ea2f1539-9675-4384-ab28-4dcecd0bd411@mailslurp.com",
    );
    cy.get('[type="submit"]').click();

    cy.contains("C’est votre première connexion avec ProConnect");

    cy.get('[type="submit"]').contains("Continuer").click();

    cy.contains(
      "Pour des raisons de sécurité, nous vous invitons à définir un nouveau mot de passe",
    );
    cy.get('[name="password"]').type(
      "This super secret password is hidden well!",
    );
    cy.get('[action="/users/sign-up"]  [type="submit"]').click();

    cy.contains(
      "Pour vérifier que vous avez bien accès à votre email, nous utilisons un code de confirmation.",
    );
    cy.mailslurp()
      .then((mailslurp) =>
        mailslurp.waitForLatestEmail(
          "ea2f1539-9675-4384-ab28-4dcecd0bd411",
          60000,
          true,
        ),
      )
      .then(getVerificationCodeFromEmail)
      .then((code) => {
        cy.get('[name="verify_email_token"]').type(code);
        cy.get('[type="submit"]').click();
      });

    cy.contains(
      "Nous avons pré-rempli ces informations. Vous pouvez toujours les mettre à jour.",
    );

    cy.get('[name="job"]').type("Petit chef");
    cy.get('[type="submit"]').click();

    cy.contains("Votre compte MonComptePro est à jour.");
    cy.get('[type="submit"]').click();
  });

  it("it should not show InclusionConnect welcome page on second visit", function () {
    // Visit the signup page
    cy.visit(`/users/start-sign-in`);

    // Sign in with the wrong password
    cy.get('[name="login"]').type(
      "ea2f1539-9675-4384-ab28-4dcecd0bd411@mailslurp.com",
    );
    cy.get('[type="submit"]').click();

    cy.contains("Accéder au compte");
  });
});
