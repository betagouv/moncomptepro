INSERT INTO users
  (id, email, email_verified, email_verified_at, encrypted_password, created_at, updated_at, given_name, family_name,
   phone_number, job)
VALUES
  (1, 'c6c64542-5601-43e0-b320-b20da72f6edc@mailslurp.com', true, CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'Nouveau', '0123456789', 'Sbire'),
  (2, '34c5063f-81c0-4d09-9d0b-a7502f844cdf@mailslurp.com', true, CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'User1', '0123456789', 'Sbire'),
  (3, '761a72f6-d051-4df5-a733-62e207c4989b@mailslurp.com', true, CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'User2', '0123456789', 'Sbire'),
  (4, 'be040966-0142-421b-8041-5a3543a79a8a@mailslurp.com', true, CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'User3', '0123456789', 'Sbire'),
  (5, '487ef426-6135-42c9-b805-9161d3474974@mailslurp.com', true, CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'User4', '0123456789', 'Sbire'),
  (6, '4fd3acbc-8711-4487-9313-c52dee8afcbb@mailslurp.com', true, CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'User5', '0123456789', 'Sbire'),
  (7, '04972db5-2c62-460e-8a88-848317acfe34@mailslurp.com', true, CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'External', '0123456789', 'Sbire'),
  (8, '869c78e6-196d-4e95-9662-44d25f801b06@mailslurp.com', true, CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'NotAuthenticated1', '0123456789', 'Sbire');

INSERT INTO organizations
  (id, siret, verified_email_domains, authorized_email_domains, created_at, updated_at)
VALUES
  -- COMMUNE DE CLAMART - Mairie
  (1, '21920023500014', '{"mailslurp.com"}', '{"mailslurp.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  -- COMMUNE DE CLAMART - Service assainissement
  (2, '21920023500394', '{"mailslurp.com"}', '{"mailslurp.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (3, '45334017600024', '{"randomain.fr"}', '{"randomain.fr"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO users_organizations
  (user_id, organization_id, is_external, verification_type, authentication_by_peers_type, has_been_greeted)
VALUES
  (2, 1, false, 'verified_email_domain', 'all_members_notified', true),
  (7, 1, true, 'verified_email_domain', 'all_members_notified', true),
  (8, 1, false, 'verified_email_domain', null, false),
  (2, 2, false, 'verified_email_domain', 'all_members_notified', true),
  (3, 1, false, 'verified_email_domain', 'all_members_notified', true),
  (4, 1, false, 'verified_email_domain', 'all_members_notified', true),
  (5, 1, false, 'verified_email_domain', 'all_members_notified', true),
  (6, 1, false, 'verified_email_domain', 'all_members_notified', true);
