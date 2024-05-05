INSERT INTO users
  (id, email, email_verified, email_verified_at, encrypted_password, created_at, updated_at, given_name, family_name,
   phone_number, job)
VALUES
  (1, '0c5b976c-b6b0-406e-a7ed-08ddae8d2d81@mailslurp.com', true, CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'Nouveau', '0123456789', 'Sbire');

INSERT INTO organizations
  (id, siret, trackdechets_email_domains, created_at, updated_at)
VALUES
  (1, '66204244933106', '{"mailslurp.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (2, '66204244914742', '{"mailslurp.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (3, '66204244905476', '{"mailslurp.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
--   (4, '66204244923982', '{"mailslurp.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
--   (5, '66204244917307', '{"mailslurp.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
--   (6, '66204244908819', '{"mailslurp.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
--   (7, '66204244908579', '{"mailslurp.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
