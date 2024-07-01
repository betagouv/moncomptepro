INSERT INTO users
  (id, email, email_verified, email_verified_at, encrypted_password, created_at, updated_at,
   given_name, family_name, phone_number, job)
VALUES
  (1, 'unused1@yopmail.com', true, CURRENT_TIMESTAMP,
   '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP,
   'Jean', 'Jean', '0123456789', 'Sbire');

INSERT INTO organizations
  (id, siret, verified_email_domains, authorized_email_domains, created_at, updated_at)
VALUES
  (1, '21340126800130', '{}', '{}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO users_organizations
  (user_id, organization_id, is_external, verification_type, authentication_by_peers_type, has_been_greeted)
VALUES
  (1, 1, false, 'verified_email_domain', 'all_members_notified', true);

INSERT INTO oidc_clients
  (client_name, client_id, client_secret, redirect_uris,
   post_logout_redirect_uris, scope, client_uri, client_description,
   userinfo_signed_response_alg, id_token_signed_response_alg,
   authorization_signed_response_alg, introspection_signed_response_alg)
VALUES
  ('AgentConnect',
   'agentconnect_client_id',
   'agentconnect_client_secret',
   ARRAY [
     'http://localhost:4001/login-callback'
     ],
   ARRAY []::varchar[],
   'openid uid given_name usual_name email phone siret',
   'http://localhost:4001/',
   'Dispositif d’identification des agents de la fonction publique.',
   'ES256', 'ES256', 'ES256', 'ES256');

INSERT INTO authenticators
  (credential_id, credential_public_key, counter, credential_device_type, credential_backed_up,
   transports, user_id, display_name, created_at, last_used_at, usage_count, user_verified)
VALUES
  ('Bdf73ipOxFEpTjCr4FqGYnLsWAKU/s6eLh2a32GihKo=',
   '\xa401010327200621582015a9f4727d84c47413e94c4b5109aee81a0ec9d1e610ff5d522eb9f8e2af927a',
--    '\x3059301306072a8648ce3d020106082a8648ce3d0301070342000495886e1804854510af5d8cb4943c0caa1ae25eef46226258e9175eb461783e000f67da1363dab497ea492d7fd5ffd855f5d34158d02c89999dce353dcd1b1dcd',
--    '\xa50102032620012158203644bd38776918bb7d83059369ddbb634bd207df223153674c20994f91ca97bf2258203d6bd21d1da555db3eb6590a34e003642c9602670203d451b2adb9302ab1325a',
   0, 'singleDevice', false, ARRAY ['internal'], 1, null, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, true);
