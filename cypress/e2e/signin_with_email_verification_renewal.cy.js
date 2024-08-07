//

import { getVerificationCodeFromEmail } from "../support/get-from-email.js";

before(() => {
  cy.seed();
});

describe("sign-in with email verification renewal", () => {
  before(() => {
    cy.mailslurp().then((mailslurp) =>
      mailslurp.inboxController.deleteAllInboxEmails({
        inboxId: "bad1b70d-e5cb-436c-9ff3-f83d4af5d198",
      }),
    );
  });

  it("should sign-in with email verification needed", () => {
    // Visit the signup page
    cy.visit(`/users/start-sign-in`);

    cy.get('[name="login"]').type(
      "bad1b70d-e5cb-436c-9ff3-f83d4af5d198@mailslurp.com",
    );
    cy.get('[type="submit"]').click();

    cy.get('[name="password"]').type("password123");
    cy.get('[action="/users/sign-in"]  [type="submit"]')
      .contains("S’identifier")
      .click();

    cy.contains(
      "pour garantir la sécurité de votre compte, votre adresse email doit être vérifiée régulièrement.",
    );

    cy.mailslurp()
      .then((mailslurp) =>
        mailslurp.waitForLatestEmail(
          "bad1b70d-e5cb-436c-9ff3-f83d4af5d198",
          60000,
          true,
        ),
      )
      .then(getVerificationCodeFromEmail)
      // fill out the verification form and submit
      .then((code) => {
        cy.get('[name="verify_email_token"]').type(code);
        cy.get('[type="submit"]').click();
      });

    cy.contains("Votre compte est créé");
  });

  it("should not show renewal notification for account creation", () => {
    cy.visit(`/users/start-sign-in`);

    cy.get('[name="login"]').type("unused1@yopmail.com");
    cy.get('[type="submit"]').click();

    cy.get('[name="password"]').type(
      "somerandomandlongpasswordthatshouldcontentmcpsecuritypolicy",
    );
    cy.get('[action="/users/sign-up"]  [type="submit"]')
      .contains("Valider")
      .click();

    cy.contains(
      "pour garantir la sécurité de votre compte, votre adresse email doit être vérifiée régulièrement.",
    ).should("not.exist");
  });
});
