// Passkey crypto elements where generated with Webauthn Chrome dev tools.
// We create a virtual authenticator with these tools.
// We used it on a local instance of MonComptePro.
// We exported the private key from the dev tools.
// We exported the record of the authenticator from MonComptePro local database.

describe("sign-in with webauthn on untrusted browser", () => {
  before(async () => {
    await Cypress.automation("remote:debugger:protocol", {
      command: "WebAuthn.enable",
    });
  });

  it("should sign-in with webauthn", function () {
    Cypress.automation("remote:debugger:protocol", {
      command: "WebAuthn.addVirtualAuthenticator",
      params: {
        options: {
          protocol: "ctap2",
          transport: "internal",
          hasResidentKey: true,
          hasUserVerification: true,
          isUserVerified: true,
        },
      },
    }).then(({ authenticatorId }) => {
      Cypress.automation("remote:debugger:protocol", {
        command: "WebAuthn.addCredential",
        params: {
          authenticatorId,
          credential: {
            credentialId: "Bdf73ipOxFEpTjCr4FqGYnLsWAKU/s6eLh2a32GihKo=",
            isResidentCredential: true,
            userHandle: "MQ==", // unused1@yopmail.com
            rpId: "localhost",
            privateKey:
              "MC4CAQAwBQYDK2VwBCIEIC5SpNCKBGOjrii3D7Ao5tsyPCiNdUHdZt78j6z2xQlR",
            signCount: 0,
          },
        },
      });
    });

    cy.visit(`http://localhost:4001`);
    cy.get("button.moncomptepro-button").click();
    cy.get('[href="/users/sign-in-with-passkey"]')
      .contains("Se connecter avec une clé d’accès")
      .click();

    cy.contains("Se connecter avec une clé d’accèss");

    cy.get("#webauthn-btn-begin-authentication").contains("Continuer").click();
    // This error is thrown here:
    // The 'publickey-credentials-get' feature is not enabled in this document.
    // See https://github.com/cypress-io/cypress/issues/6991#issuecomment-2168311131

    cy.contains('"amr": [\n    "pop",\n    "mfa"\n  ],');
  });
});

// TODO test the amr result in the following cases
// TODO login with webauthn and userVerified=true
// TODO unable to login with webauthn and userVerified=false
// TODO login with password + webauthn and userVerified=false
// TODO login with password + webauthn and userVerified=true
// TODO a second factor should not trigger email verification for untrusted browser reason
