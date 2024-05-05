INSERT INTO users
  (id, email, email_verified, email_verified_at, encrypted_password, created_at, updated_at, given_name, family_name,
   phone_number, job)
VALUES
  (1, '26ccc0fa-0dc3-4f12-9335-7bb00282920c@mailslurp.com', true, CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'Officiel', '0123456789', 'Sbire'),
  (2, 'c348a2c3-bf54-4f15-bb12-a2d7047c832f@mailslurp.com', true, CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'Nouveau', '0123456789', 'Sbire');


INSERT INTO organizations
  (id, siret, verified_email_domains, authorized_email_domains, created_at, updated_at)
VALUES
  (1, '21340126800130', '{}', '{}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO users_organizations
  (user_id, organization_id, is_external, verification_type, authentication_by_peers_type, has_been_greeted)
VALUES
  (1, 1, false, 'verified_email_domain', 'all_members_notified', true);
