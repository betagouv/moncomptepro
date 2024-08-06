//

before(() => {
  cy.seed();
});

describe("should suggest valid email address", () => {
  it("should sign-in", function () {
    cy.visit(`http://localhost:4001`);
    cy.get("button.moncomptepro-button").click();

    cy.get('[name="login"]').should("have.value", "unused1@yopmail.com");
    cy.contains("Adresse email invalide.");

    cy.get('[name="login"]').type("{selectall}{del}unused2@yopmail.com");
    cy.get('[action="/users/start-sign-in"]  [type="submit"]').click();

    cy.get('[name="login"]').should("have.value", "unused2@yopmail.com");
    cy.contains("Adresse email invalide.");

    cy.get("#did-you-mean-link").click();
    cy.get('[action="/users/start-sign-in"]  [type="submit"]').click();

    cy.contains("Choisir votre mot de passe");
  });
});
