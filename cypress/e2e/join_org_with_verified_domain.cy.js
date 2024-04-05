//

describe("join organizations", () => {
  before(() => {
    cy.seed(__filename.split("/").at(-1).replace(".cy.js", ""));
    return cy
      .mailslurp()
      .then((mailslurp) =>
        mailslurp.inboxController.deleteAllInboxEmails({
          inboxId: "c6c64542-5601-43e0-b320-b20da72f6edc",
        }),
      )
      .then((mailslurp) =>
        mailslurp.inboxController.deleteAllInboxEmails({
          inboxId: "34c5063f-81c0-4d09-9d0b-a7502f844cdf",
        }),
      )
      .then((mailslurp) =>
        mailslurp.inboxController.deleteAllInboxEmails({
          inboxId: "04972db5-2c62-460e-8a88-848317acfe34",
        }),
      )
      .then((mailslurp) =>
        mailslurp.inboxController.deleteAllInboxEmails({
          inboxId: "869c78e6-196d-4e95-9662-44d25f801b06",
        }),
      );
  });
  beforeEach(() => {
    cy.login(
      "c6c64542-5601-43e0-b320-b20da72f6edc@mailslurp.com",
      "password123",
    );
  });

  it("join suggested organisation", function () {
    // Visit the signup page
    cy.visit(`/`);

    // The user gets this suggestion because it as mailslurp.com as verified domain
    cy.get(".fr-grid-row .fr-col-12:first-child .fr-tile__link").contains(
      "Commune de clamart - Mairie",
    );

    // The user gets this suggestion because last because it has fewer members
    cy.get(".fr-grid-row .fr-col-12:last-child .fr-tile__link").contains(
      "Commune de clamart - Service assainissement",
    );

    // Click on the suggested organization
    cy.get(".fr-grid-row .fr-col-12:first-child .fr-tile__link").click();

    // Click on "Je ne connais aucune des personnes proposées"
    cy.get('[href="/users/no-sponsor-found/1"]').click();

    // Click on the confirmation button
    cy.get('[type="submit"]').contains("Personne ne peut me parrainer").click();

    // Click on "continue" on the welcome page
    cy.get('[type="submit"]').click();

    // Check redirection to home page
    cy.contains("Votre compte est créé");

    cy.mailslurp()
      .then((mailslurp) =>
        mailslurp
          .waitForMatchingEmails(
            // match option does not seem to be used here
            {
              matches: [
                {
                  field: "SUBJECT",
                  should: "EQUAL",
                  value: "Votre organisation sur MonComptePro",
                },
              ],
            },
            1,
            "c6c64542-5601-43e0-b320-b20da72f6edc",
            60000,
            true,
          )
          .then(([{ id }]) => mailslurp.getEmail(id)),
      )
      // assert reception of confirmation email
      .then((email) => {
        expect(email.body).to.include("Jean USER1");
        expect(email.body).to.include("Jean EXTERNAL (externe)");
        expect(email.body).to.not.include("Jean NOTAUTHENTICATED1");
      });

    cy.mailslurp()
      .then((mailslurp) =>
        mailslurp.waitForLatestEmail(
          "34c5063f-81c0-4d09-9d0b-a7502f844cdf",
          60000,
          true,
        ),
      )
      // assert reception of notification email
      .then((email) => {
        expect(email.body).to.match(
          /.*Jean Nouveau.*\(c6c64542-5601-43e0-b320-b20da72f6edc@mailslurp\.com\) a rejoint votre organisation.*Commune de clamart - Mairie.*sur .*MonComptePro/,
        );
      });

    // external users should not be warned for newcomers
    cy.mailslurp().then((mailslurp) =>
      mailslurp
        // note that this method may return empty emails arrays before receiving one.
        .getEmails("04972db5-2c62-460e-8a88-848317acfe34")
        .then((emails) => {
          expect(emails).to.be.empty;
        }),
    );

    // non-authenticated users should not be warned for newcomers
    cy.mailslurp().then((mailslurp) =>
      mailslurp
        // note that this method may return empty emails arrays before receiving one.
        .getEmails("869c78e6-196d-4e95-9662-44d25f801b06")
        .then((emails) => {
          expect(emails).to.be.empty;
        }),
    );
  });

  it("join another organisation", function () {
    // Visit the join organization page
    cy.visit(`/users/join-organization`);
    cy.get('[name="siret"]').type("13002526500013");
    cy.get('[type="submit"]').click();

    // Check redirection to moderation block page
    cy.contains(
      "Notre équipe étudie votre demande de rattachement à l’organisation Direction interministerielle du numerique (DINUM) avec l’adresse email c6c64542-5601-43e0-b320-b20da72f6edc@mailslurp.com",
    );

    // Try to change org
    cy.get('a[href^="/help"]')
      .contains("J’ai fait une erreur dans ma demande")
      .click();
    cy.get('[action^="/users/cancel-moderation-and-redirect-to-join-org/"]')
      .contains(
        "Annuler la demande en cours et sélectionner une organisation différente",
      )
      .click();

    cy.get('[name="siret"]').type("13002526500013");
    cy.get('[type="submit"]').click();
    cy.contains("Notre équipe étudie votre demande");

    // Try to change email
    cy.get('a[href^="/help"]')
      .contains("J’ai fait une erreur dans ma demande")
      .click();
    cy.get('[action^="/users/cancel-moderation-and-redirect-to-sign-in/"]')
      .contains(
        "Annuler la demande en cours et utiliser une autre adresse email",
      )
      .click();
    cy.contains("S’inscrire ou se connecter");
  });
});
