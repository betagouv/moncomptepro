INSERT INTO users
  (id, email, email_verified, email_verified_at, encrypted_password, created_at, updated_at, given_name, family_name,
   phone_number, job)
VALUES
  (1, 'unused1@yopmail.com', true, CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'Jean', '0123456789', 'Sbire');


INSERT INTO organizations
  (id, siret, verified_email_domains, authorized_email_domains, created_at, updated_at)
VALUES
  (1, '21340126800130', '{}', '{}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (2, '21920023500014', '{}', '{}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO users_organizations
  (user_id, organization_id, is_external, verification_type, authentication_by_peers_type, has_been_greeted)
VALUES
  (1, 1, false, 'verified_email_domain', 'all_members_notified', true),
  (1, 2, false, 'verified_email_domain', 'all_members_notified', true);

INSERT INTO oidc_clients
  (client_name, client_id, client_secret, redirect_uris,
   post_logout_redirect_uris, scope, client_uri, client_description,
   userinfo_signed_response_alg, id_token_signed_response_alg,
   authorization_signed_response_alg, introspection_signed_response_alg)
VALUES
  ('Oidc Test Client',
   'legacy_client_id',
   'legacy_client_secret',
   ARRAY [
     'http://moncomptepro-legacy-client.localhost/login-callback'
     ],
   ARRAY []::varchar[],
   'openid email profile phone organizations',
   'http://moncomptepro-legacy-client.localhost/',
   'MonComptePro test client. More info: https://github.com/betagouv/moncomptepro-test-client.',
   null, null, null, null),
  ('Oidc Test Client',
   'standard_client_id',
   'standard_client_secret',
   ARRAY [
     'http://moncomptepro-standard-client.localhost/login-callback'
     ],
   ARRAY []::varchar[],
   'openid email profile organization',
   'http://moncomptepro-standard-client.localhost/',
   'MonComptePro test client. More info: https://github.com/betagouv/moncomptepro-test-client.',
   null, null, null, null);
