INSERT INTO users
  (id, email, email_verified, email_verified_at, encrypted_password, created_at, updated_at, given_name, family_name,
   phone_number, job)
VALUES
  (1, 'bad1b70d-e5cb-436c-9ff3-f83d4af5d198@mailslurp.com', true, NOW() - INTERVAL '3 MONTHS 1 HOUR', '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'Jean1', '0123456789', 'Sbire');


INSERT INTO organizations
  (id, siret, verified_email_domains, authorized_email_domains, created_at, updated_at)
VALUES
  (1, '21340126800130', '{}', '{}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO users_organizations
  (user_id, organization_id, is_external, verification_type, authentication_by_peers_type, has_been_greeted)
VALUES
  (1, 1, false, 'verified_email_domain', 'all_members_notified', true);
