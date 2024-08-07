//

before(() => {
  cy.seed();
});

describe("delete account", () => {
  before(() => {
    cy.mailslurp().then((mailslurp) =>
      mailslurp.inboxController.deleteAllInboxEmails({
        inboxId: "4cec922b-ecbe-4a46-8511-fc9478c1efd0",
      }),
    );
  });

  it("should delete account", function () {
    // Visit the signup page
    cy.visit(`/users/start-sign-in`);

    cy.get('[name="login"]').type(
      "4cec922b-ecbe-4a46-8511-fc9478c1efd0@mailslurp.com",
    );
    cy.get('[type="submit"]').click();

    cy.get('[name="password"]').type("password123");
    cy.get('[action="/users/sign-in"]  [type="submit"]')
      .contains("S’identifier")
      .click();

    cy.contains("Connexion et compte").click();

    cy.contains("Suppression");

    cy.contains("Supprimer mon compte").click();

    cy.contains("Votre compte a bien été supprimé.");

    cy.mailslurp()
      // use inbox id and a timeout of 30 seconds
      .then((mailslurp) =>
        mailslurp.waitForLatestEmail(
          "4cec922b-ecbe-4a46-8511-fc9478c1efd0",
          60000,
          true,
        ),
      )
      // check subject of deletion email
      .then((email) => {
        expect(email.subject).to.include("Suppression de compte");
      });
  });
});
