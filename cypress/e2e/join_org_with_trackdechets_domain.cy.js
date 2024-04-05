//

describe("join organizations", () => {
  before(() => {
    cy.seed(__filename.split("/").at(-1).replace(".cy.js", ""));
    return cy.mailslurp().then((mailslurp) =>
      mailslurp.inboxController.deleteAllInboxEmails({
        inboxId: "0c5b976c-b6b0-406e-a7ed-08ddae8d2d81",
      }),
    );
  });
  beforeEach(() => {
    cy.login(
      "0c5b976c-b6b0-406e-a7ed-08ddae8d2d81@mailslurp.com",
      "password123",
    );
  });

  it("join suggested organisation", function () {
    // Visit the signup page
    cy.visit(`/`);

    // The user gets this suggestion because it as mailslurp.com as trackdechets domain
    cy.get(".fr-grid-row .fr-col-12:first-child .fr-tile__link").contains(
      "Bnp paribas",
    );

    // Click on the suggested organization
    cy.get(".fr-grid-row .fr-col-12:first-child .fr-tile__link").click();

    // Check redirection to welcome page
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
                  value: "Votre compte MonComptePro a bien été créé",
                },
              ],
            },
            1,
            "0c5b976c-b6b0-406e-a7ed-08ddae8d2d81",
            60000,
            true,
          )
          .then(([{ id }]) => mailslurp.getEmail(id)),
      )
      // assert reception of confirmation email
      .then((email) => {
        expect(email.body).to.include("Votre compte MonComptePro est créé !");
      });
  });
});
