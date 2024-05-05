//

describe(
  "join organizations",
  { baseUrl: "http://app.moncomptepro.localhost" },
  () => {
    before(() => {
      cy.seed(__dirname);
      cy.mailslurp().then((mailslurp) =>
        mailslurp.inboxController.deleteAllInboxEmails({
          inboxId: "435f6a4d-df7d-4840-be7b-bc4851b64e91",
        }),
      );
    });
    after(() => {
      cy.exec(`docker compose --project-directory ${__dirname} stop`);
    });

    it("join collectivité territoriale with official contact domain", function () {
      cy.login(
        "76450610-4dcc-4664-b9ab-1cea869b62b1@mailslurp.com",
        "password123",
      );

      cy.visit(`/users/join-organization`);
      cy.get('[name="siret"]').type("21740056300011");
      cy.get('[type="submit"]').click();

      cy.contains("Votre compte est créé");
    });
  },
);
