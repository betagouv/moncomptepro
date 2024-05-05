//

describe(
  "sign-in with email verification renewal",
  { baseUrl: "http://app.moncomptepro.localhost" },
  () => {
    before(() => {
      cy.seed(__dirname);
      cy.mailslurp().then((mailslurp) =>
        mailslurp.inboxController.deleteAllInboxEmails({
          inboxId: "bad1b70d-e5cb-436c-9ff3-f83d4af5d198",
        }),
      );
    });

    after(() => {
      cy.exec(`docker compose --project-directory ${__dirname} stop`);
    });

    it("should sign-in with email verification needed", function () {
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

      // Verify the email with the code received by email
      cy.mailslurp()
        // use inbox id and a timeout of 30 seconds
        .then((mailslurp) =>
          mailslurp.waitForLatestEmail(
            "bad1b70d-e5cb-436c-9ff3-f83d4af5d198",
            60000,
            true,
          ),
        )
        // extract the verification code from the email subject
        .then((email) => {
          const matches =
            /.*<span style="color: #000091; font-size: 18px;"><strong>(\s*(?:\d\s*){10})<\/strong><\/span>.*/.exec(
              email.body,
            );
          if (matches && matches.length > 0) {
            return matches[1];
          }
          throw new Error("Could not find verification code in received email");
        })
        // fill out the verification form and submit
        .then((code) => {
          cy.get('[name="verify_email_token"]').type(code);
          cy.get('[type="submit"]').click();
        });

      cy.contains("Votre compte est créé");
    });
  },
);
