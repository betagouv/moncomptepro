//

describe("join organizations", () => {
  before(() => {
    cy.seed(__filename.split("/").at(-1).replace(".cy.js", ""));
    cy.mailslurp().then((mailslurp) =>
      mailslurp.inboxController.deleteAllInboxEmails({
        inboxId: "26ccc0fa-0dc3-4f12-9335-7bb00282920c",
      }),
    );
    cy.mailslurp().then((mailslurp) =>
      mailslurp.inboxController.deleteAllInboxEmails({
        inboxId: "c348a2c3-bf54-4f15-bb12-a2d7047c832f",
      }),
    );
  });

  it("join collectivité territoriale with code send to official contact email", function () {
    cy.login(
      "c348a2c3-bf54-4f15-bb12-a2d7047c832f@mailslurp.com",
      "password123",
    );

    cy.visit(`/users/join-organization`);
    cy.get('[name="siret"]').type("21340126800130");
    cy.get('[type="submit"]').click();

    // Check that the website is waiting for the user to verify their email
    cy.contains(
      "nous avons envoyé un code secret à l’adresse email de votre mairie",
    );
    cy.get("#email-badge-lowercase").contains(
      "26ccc0fa-0dc3-4f12-9335-7bb00282920c@mailslurp.com",
    );

    // Verify the email with the code received by email
    cy.mailslurp()
      // use inbox id and a timeout of 30 seconds
      .then((mailslurp) =>
        mailslurp.waitForLatestEmail(
          "26ccc0fa-0dc3-4f12-9335-7bb00282920c",
          60000,
          true,
        ),
      )
      // extract the verification code from the email subject
      .then((email) => {
        const matches =
          /.*<span style="color: #000091; font-size: 18px;">([a-z]{2,25}-[a-z]{2,25})<\/span>.*/.exec(
            email.body,
          );
        if (matches && matches.length > 0) {
          return matches[1];
        }
        throw new Error("Could not find verification code in received email");
      })
      // fill out the verification form and submit
      .then((code) => {
        cy.get('[name="official_contact_email_verification_token"]').type(code);
        cy.get('[type="submit"]').click();
      });

    // Click on "Je ne connais aucune des personnes proposées"
    cy.get('[href="/users/no-sponsor-found/1"]').click();

    // Click on the confirmation button
    cy.get('[type="submit"]').contains("Personne ne peut me parrainer").click();

    cy.contains("Votre compte est créé");

    cy.mailslurp()
      .then((mailslurp) =>
        mailslurp.waitForLatestEmail(
          "26ccc0fa-0dc3-4f12-9335-7bb00282920c",
          60000,
          true,
        ),
      )
      // assert reception of notification email
      .then((email) => {
        expect(email.body).to.match(
          /.*Jean Nouveau.*\(c348a2c3-bf54-4f15-bb12-a2d7047c832f@mailslurp\.com\) a rejoint votre organisation.*Commune de lamalou-les-bains - Mairie.*sur .*MonComptePro/,
        );
      });
  });
});
