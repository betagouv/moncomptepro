//

describe("sign-in with magic link", () => {
  before(() => {
    cy.seed(__dirname);

    cy.mailslurp().then((mailslurp) =>
      mailslurp.inboxController.deleteAllInboxEmails({
        inboxId: "8e79c68c-9ce1-4dfe-8e58-fa3763d4cff7",
      }),
    );
  });

  after(() => {
    cy.exec(`docker compose --project-directory ${__dirname} stop`);
  });

  it("should reset password then sign-in", function () {
    // Visit the signup page
    cy.visit(`http://app.moncomptepro.localhost/users/start-sign-in`);

    // Sign in with the wrong password
    cy.get('[name="login"]').type(
      "8e79c68c-9ce1-4dfe-8e58-fa3763d4cff7@mailslurp.com",
    );
    cy.get('[type="submit"]').click();

    cy.get('[action="/users/sign-in"] [name="password"]').type(
      "wrong_password",
    );
    cy.get('[action="/users/sign-in"] [type="submit"]').click();

    cy.contains("mot de passe incorrect.");

    // start resetting password
    cy.get('a[href="/users/reset-password"]')
      .contains("Mot de passe oublié ?")
      .click();

    cy.contains("Réinitialiser mon mot de passe");

    cy.get('[action="/users/reset-password"] [type="submit"]').click();

    cy.contains("vous allez recevoir un lien de réinitialisation par e-mail.");

    cy.mailslurp()
      // use inbox id and a timeout of 30 seconds
      .then((mailslurp) =>
        mailslurp.waitForLatestEmail(
          "8e79c68c-9ce1-4dfe-8e58-fa3763d4cff7",
          60000,
          true,
        ),
      )
      // extract the connection link from the email subject
      .then((email) => {
        const matches =
          /.*<a href="([^"]+)" class="r13-r default-button".*/.exec(email.body);
        if (matches && matches.length > 0) {
          return matches[1];
        }
        throw new Error("Could not find connection link in received email");
      })
      .then((link) => {
        cy.visit(link);
      });

    cy.contains("Changer votre mot de passe");

    cy.get('[action="/users/change-password"] [name="password"]').type(
      "new_weak_password_with_decent_length",
    );
    cy.get('[action="/users/change-password"] [name="confirm_password"]').type(
      "new_weak_password_with_decent_length",
    );
    cy.get('[action="/users/change-password"] [type="submit"]').click();

    cy.contains("Votre mot de passe a été mis à jour.");

    cy.get('[action="/users/start-sign-in"] [type="submit"]').click();

    cy.get('[action="/users/sign-in"] [name="password"]').type(
      "new_weak_password_with_decent_length",
    );
    cy.get('[action="/users/sign-in"] [type="submit"]').click();

    cy.contains("Votre compte est créé !");
  });
});
