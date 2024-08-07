//

before(() => {
  cy.seed();
});

describe("join organizations", () => {
  beforeEach(() => {
    cy.login("unused@fake.gouv.fr", "password123");
  });

  it("join suggested organisation", function () {
    // Visit the signup page
    cy.visit(`/`);
    cy.get(".fr-grid-row .fr-col-12:first-child .fr-tile__link").contains(
      "DINUM",
    );
    // Click on the suggested organization
    cy.get(".fr-grid-row .fr-col-12:first-child .fr-tile__link").click();

    // Check redirection to welcome page
    cy.contains("Votre compte est créé");
  });
});
