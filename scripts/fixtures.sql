-- This script:
-- - override data at specified id without deleting database
-- - is idempotent.

INSERT INTO users
  (id, email, email_verified, email_verified_at, encrypted_password, created_at, updated_at, given_name, family_name,
   phone_number, job)
VALUES
  (1,
   'user@yopmail.com', -- keep these emails synchronised with the corresponding emails in signup-back/test/fixtures/users.yml
   'true',
   CURRENT_TIMESTAMP,
   '$2a$10$5oxACsw3NngPAXALyB2G3u/C0Ej0CFUyPJhPtyyHP737Xn3lW1Mv.', -- password is 'user@yopmail.com'
   CURRENT_TIMESTAMP,
   CURRENT_TIMESTAMP,
   'Jean',
   'User',
   '0123456789',
   'International knowledge practice leader'),
  (2,
   'api-particulier@yopmail.com',
   'true',
   CURRENT_TIMESTAMP,
   '$2a$10$lciw8zIj7f46yqINJUkWUe1ZeZQRwLym/v7bO9Vza6w0Jtxzd6u5m', -- password is 'api-particulier@yopmail.com'
   CURRENT_TIMESTAMP,
   CURRENT_TIMESTAMP,
   'Jean',
   'Particulier',
   '0123456789',
   'Key operation squad leader'),
  (3,
   'franceconnect@yopmail.com',
   'true',
   CURRENT_TIMESTAMP,
   '$2a$10$dHC3xdeOc8BuXwmF/nD7R.8TWAj2tU/hyybXr3VzIxrBg9Lynt5WK', -- password is 'franceconnect@yopmail.com'
   CURRENT_TIMESTAMP,
   CURRENT_TIMESTAMP,
   'Jean',
   'FranceConnect',
   '0123456789',
   'Executive talent developer'),
  (4,
   'api-entreprise@yopmail.com',
   'true',
   CURRENT_TIMESTAMP,
   '$2a$10$K92VjN/bxsU3PEdK.McpIe7VO7XC.ESse4Lk2BPLmR4QwkcHKLt7K', -- password is 'api-entreprise@yopmail.com'
   CURRENT_TIMESTAMP,
   CURRENT_TIMESTAMP,
   'Jean',
   'API Entreprise',
   '0123456789',
   'Chief account entrepreneur'),
  (5,
   'api-impot-particulier@yopmail.com',
   'true',
   CURRENT_TIMESTAMP,
   '$2a$10$24hdVRIbS6swY.zQy6wNXeeOCPOj.efXsBWfvGSqyvXaMsFC.fltq', -- password is 'api-impot-particulier@yopmail.com'
   CURRENT_TIMESTAMP,
   CURRENT_TIMESTAMP,
   'Jean',
   'API Impôt particulier',
   '0123456789',
   'International career development developer'),
  (6,
   'datapass@yopmail.com',
   'true',
   CURRENT_TIMESTAMP,
   '$2a$10$P/M19MBC3b/k64X2QX4tQeMnvYUIkGPKhSx7CP9g02xoiA.ZRFg9C', -- password is 'datapass@yopmail.com'
   CURRENT_TIMESTAMP,
   CURRENT_TIMESTAMP,
   'Jean',
   'Administrateur',
   '0123456789',
   'Senior costumer experience squad leader'),
  (7,
   'editeur@yopmail.com',
   'true',
   CURRENT_TIMESTAMP,
   '$2a$10$L6m/QdGQI4.DuS46Dv7q0OK0V5vfwgHi7ClkrNSUIYn5q5o4K3uDm', -- password is 'editeur@yopmail.com'
   CURRENT_TIMESTAMP,
   CURRENT_TIMESTAMP,
   'Jean',
   'Éditeur',
   '0123456789',
   'Président des affaires, gère beaucoup de business'),
  -- password for the following user is 'password123'
  (10, 'user10@yopmail.com', 'true', CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'User10', '0123456789', 'Sbire'),
  (11, 'user11@yopmail.com', 'true', CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'User11', '0123456789', 'Sbire'),
  (12, 'user12@yopmail.com', 'true', CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'User12', '0123456789', 'Sbire'),
  (13, 'user13@yopmail.com', 'true', CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'User13', '0123456789', 'Sbire'),
  (14, 'user14@yopmail.com', 'true', CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'User14', '0123456789', 'Sbire'),
  (15, 'user15@yopmail.com', 'true', CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'User15', '0123456789', 'Sbire'),
  (16, 'user16@yopmail.com', 'true', CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'User16', '0123456789', 'Sbire'),
  (17, 'user17@yopmail.com', 'true', CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'User17', '0123456789', 'Sbire'),
  (18, 'user18@yopmail.com', 'true', CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'User18', '0123456789', 'Sbire'),
  (19, 'user19@yopmail.com', 'true', CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'User19', '0123456789', 'Sbire'),
  (20, 'wanajoin@beta.gouv.fr', 'true', CURRENT_TIMESTAMP, '$2a$10$kzY3LINL6..50Fy9shWCcuNlRfYq0ft5lS.KCcJ5PzrhlWfKK4NIO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Jean', 'Wanajoin', '0123456789', 'Sbire')
ON CONFLICT (id)
  DO UPDATE
  SET (email, email_verified, email_verified_at, encrypted_password, created_at, updated_at, given_name, family_name,
       phone_number, job)
    = (EXCLUDED.email, EXCLUDED.email_verified, EXCLUDED.email_verified_at, EXCLUDED.encrypted_password,
       EXCLUDED.created_at,
       EXCLUDED.updated_at, EXCLUDED.given_name, EXCLUDED.family_name, EXCLUDED.phone_number, EXCLUDED.job);

SELECT setval(
    'users_id_seq',
    GREATEST(
        (SELECT MAX(id) FROM users),
        (SELECT last_value FROM users_id_seq)
      )
  );

INSERT INTO organizations
  (id, siret, verified_email_domains, authorized_email_domains, created_at, updated_at)
VALUES
  (1, '21920023500014', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (2, '13002526500013', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (3, '21130055300016', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (4, '21690123100011', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (5, '21310555400017', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (6, '21330063500017', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (7, '21060088800015', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (8, '21440109300015', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (9, '21510421700017', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (10, '21340172201787', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (11, '21670482500019', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (12, '21350238800019', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (13, '21760351300011', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (14, '21830137200015', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (15, '21590350100017', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (16, '21420218600018', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (17, '21250056500016', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (18, '20006340200016', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (19, '21380185500015', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (20, '21740056300011', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (21, '21800019800018', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (22, '21370261600011', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (23, '21300189400012', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (24, '21450234600015', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (25, '21720181300011', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (26, '20006541500016', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (27, '21680224900013', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (28, '21490007800012', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (29, '20005684400018', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (30, '21930048000015', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (31, '21570463600012', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (32, '20005686900015', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (33, '21100374400011', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (34, '21590599300014', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (35, '21290019500018', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (36, '21660136900012', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (37, '21930001900011', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (38, '21950018800012', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (39, '21930066200018', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (40, '21950127700897', '{}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (41, '21590512600011', '{"moncourrier.fr.nf"}', '{"moncourrier.fr.nf"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (42, '81403721400016', '{"yeswehack.ninja"}', '{"yeswehack.ninja"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (43, '11006801200050', '{"beta.gouv.fr"}', '{"beta.gouv.fr"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (44, '54205118000066', '{"yopmail.com"}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (45, '31723624800017', '{"yopmail.com"}', '{"yopmail.com"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
ON CONFLICT (id)
  DO UPDATE
  SET (siret, verified_email_domains, authorized_email_domains, created_at, updated_at)
    = (EXCLUDED.siret, EXCLUDED.verified_email_domains, EXCLUDED.authorized_email_domains, EXCLUDED.created_at, EXCLUDED.updated_at);

SELECT setval(
    'organizations_id_seq',
    GREATEST(
        (SELECT MAX(id) FROM organizations),
        (SELECT last_value FROM organizations_id_seq)
      )
  );

INSERT INTO users_organizations
  (user_id, organization_id, verification_type, authentication_by_peers_type, has_been_greeted)
VALUES
  (1, 1, 'verified_email_domain', 'all_members_notified', true),
  (2, 2, 'verified_email_domain', 'all_members_notified', true),
  (3, 2, 'verified_email_domain', 'all_members_notified', true),
  (4, 2, 'verified_email_domain', 'all_members_notified', true),
  (5, 2, 'verified_email_domain', 'all_members_notified', true),
  (6, 2, 'verified_email_domain', 'all_members_notified', true),
  (7, 3, 'verified_email_domain', 'all_members_notified', true),
  (7, 4, 'verified_email_domain', 'all_members_notified', true),
  (7, 5, 'verified_email_domain', 'all_members_notified', true),
  (7, 6, 'verified_email_domain', 'all_members_notified', true),
  (7, 7, 'verified_email_domain', 'all_members_notified', true),
  (7, 8, 'verified_email_domain', 'all_members_notified', true),
  (7, 9, 'verified_email_domain', 'all_members_notified', true),
  (7, 10, 'verified_email_domain', 'all_members_notified', true),
  (7, 11, 'verified_email_domain', 'all_members_notified', true),
  (7, 12, 'verified_email_domain', 'all_members_notified', true),
  (7, 13, 'verified_email_domain', 'all_members_notified', true),
  (7, 14, 'verified_email_domain', 'all_members_notified', true),
  (7, 15, 'verified_email_domain', 'all_members_notified', true),
  (7, 16, 'verified_email_domain', 'all_members_notified', true),
  (7, 17, 'verified_email_domain', 'all_members_notified', true),
  (7, 18, 'verified_email_domain', 'all_members_notified', true),
  (7, 19, 'verified_email_domain', 'all_members_notified', true),
  (7, 20, 'verified_email_domain', 'all_members_notified', true),
  (7, 21, 'verified_email_domain', 'all_members_notified', true),
  (7, 22, 'verified_email_domain', 'all_members_notified', true),
  (7, 23, 'verified_email_domain', 'all_members_notified', true),
  (7, 24, 'verified_email_domain', 'all_members_notified', true),
  (7, 25, 'verified_email_domain', 'all_members_notified', true),
  (7, 26, 'verified_email_domain', 'all_members_notified', true),
  (7, 27, 'verified_email_domain', 'all_members_notified', true),
  (7, 28, 'verified_email_domain', 'all_members_notified', true),
  (7, 29, 'verified_email_domain', 'all_members_notified', true),
  (7, 30, 'verified_email_domain', 'all_members_notified', true),
  (7, 31, 'verified_email_domain', 'all_members_notified', true),
  (7, 32, 'verified_email_domain', 'all_members_notified', true),
  (7, 33, 'verified_email_domain', 'all_members_notified', true),
  (7, 34, 'verified_email_domain', 'all_members_notified', true),
  (7, 35, 'verified_email_domain', 'all_members_notified', true),
  (7, 36, 'verified_email_domain', 'all_members_notified', true),
  (7, 37, 'verified_email_domain', 'all_members_notified', true),
  (7, 38, 'verified_email_domain', 'all_members_notified', true),
  (7, 39, 'verified_email_domain', 'all_members_notified', true),
  (7, 40, 'verified_email_domain', 'all_members_notified', true),
  (7, 41, 'verified_email_domain', 'all_members_notified', true),
  (10, 2, 'verified_email_domain', 'all_members_notified', true),
  (11, 2, 'verified_email_domain', 'all_members_notified', true),
  (12, 2, 'verified_email_domain', 'all_members_notified', true),
  (13, 2, 'verified_email_domain', 'all_members_notified', true),
  (14, 2, 'verified_email_domain', 'all_members_notified', true),
  (15, 2, 'verified_email_domain', 'all_members_notified', true),
  (16, 2, 'verified_email_domain', 'all_members_notified', true),
  (17, 2, 'verified_email_domain', 'all_members_notified', true),
  (18, 2, 'verified_email_domain', 'all_members_notified', true),
  (19, 2, 'verified_email_domain', 'all_members_notified', true)
ON CONFLICT (user_id, organization_id)
  DO UPDATE
  SET (verification_type, authentication_by_peers_type, has_been_greeted)
    = (EXCLUDED.verification_type, EXCLUDED.authentication_by_peers_type, EXCLUDED.has_been_greeted);

INSERT INTO oidc_clients
  (id, client_name, client_id, client_secret, redirect_uris,
   post_logout_redirect_uris, scope, client_uri, client_description,
   userinfo_signed_response_alg, id_token_signed_response_alg,
   authorization_signed_response_alg, introspection_signed_response_alg)
VALUES
  (1,
   'DataPass',
   'nCDCeAfS0qpxr2kzps7nUClRGUZ1CgnzNQ2JqIZKDPUHrQoqzAuVI7I0dh41dHJHyrkvHzvjUFwoooB71VbkmGykjAba2UcxJBhJL4RUO3niaqyWV7zma8KsS4CGsbIa',
   'Q8alcDUf9NwwfkPx4s3GPgac0FsZ6ZdZMIFvnbqabGuZ8JwwqyJy46MgOGuUgw43Hnzjzfzzt7B64937oCmtmmxqvY9ftQyXIhMxRzNn73UspWHKv9wv2HqtTD82LTxV',
   ARRAY [
     'https://back.datapass-development.api.gouv.fr/users/auth/api_gouv/callback',
     'https://back.sandbox.datapass.api.gouv.fr/users/auth/api_gouv/callback',
     'https://back.sandbox1.datapass.api.gouv.fr/users/auth/api_gouv/callback',
     'https://back.sandbox2.datapass.api.gouv.fr/users/auth/api_gouv/callback',
     'https://back.staging.datapass.api.gouv.fr/users/auth/api_gouv/callback',
     'https://back.staging1.datapass.api.gouv.fr/users/auth/api_gouv/callback',
     'https://back.staging2.datapass.api.gouv.fr/users/auth/api_gouv/callback',
     'http://localhost:3000/users/auth/api_gouv/callback',
     'http://localhost:3001/users/auth/api_gouv/callback',
     'http://localhost:3000/auth/mon_compte_pro/callback',
     'http://api-entreprise.localtest.me:3000/auth/mon_compte_pro/callback',
     'https://sandbox.datapass.api.gouv.fr/auth/mon_compte_pro/callback',
     'https://staging.datapass.api.gouv.fr/auth/mon_compte_pro/callback',
     'https://sandbox.v2.datapass.api.gouv.fr/auth/mon_compte_pro/callback',
     'https://sandbox1.v2.datapass.api.gouv.fr/auth/mon_compte_pro/callback',
     'https://sandbox2.v2.datapass.api.gouv.fr/auth/mon_compte_pro/callback',
     'https://sandbox.api-entreprise.v2.datapass.api.gouv.fr/auth/mon_compte_pro/callback',
     'https://sandbox1.api-entreprise.v2.datapass.api.gouv.fr/auth/mon_compte_pro/callback',
     'https://sandbox2.api-entreprise..v2.datapass.api.gouv.fr/auth/mon_compte_pro/callback',
     'https://staging.v2.datapass.api.gouv.fr/auth/mon_compte_pro/callback',
     'https://staging1.v2.datapass.api.gouv.fr/auth/mon_compte_pro/callback',
     'https://staging2.v2.datapass.api.gouv.fr/auth/mon_compte_pro/callback',
     'https://staging.api-entreprise.v2.datapass.api.gouv.fr/auth/mon_compte_pro/callback',
     'https://staging1.api-entreprise.v2.datapass.api.gouv.fr/auth/mon_compte_pro/callback',
     'https://staging2.api-entreprise..v2.datapass.api.gouv.fr/auth/mon_compte_pro/callback'
     ],
   ARRAY [
     'http://localhost:3000',
     'http://localhost:3001',
     'http://api-entreprise.localtest.me:3000',
     'https://datapass-development.api.gouv.fr',
     'https://sandbox.datapass.api.gouv.fr',
     'https://sandbox1.datapass.api.gouv.fr',
     'https://sandbox2.datapass.api.gouv.fr',
     'https://staging.datapass.api.gouv.fr',
     'https://staging1.datapass.api.gouv.fr',
     'https://staging2.datapass.api.gouv.fr',
     'https://sandbox.api-entreprise.v2.datapass.api.gouv.fr',
     'https://sandbox1.api-entreprise.v2.datapass.api.gouv.fr',
     'https://sandbox2.api-entreprise.v2.datapass.api.gouv.fr',
     'https://sandbox.v2.datapass.api.gouv.fr',
     'https://sandbox1.v2.datapass.api.gouv.fr',
     'https://sandbox2.v2.datapass.api.gouv.fr',
     'https://staging.api-entreprise.v2.datapass.api.gouv.fr',
     'https://staging1.api-entreprise.v2.datapass.api.gouv.fr',
     'https://staging2.api-entreprise.v2.datapass.api.gouv.fr',
     'https://staging.v2.datapass.api.gouv.fr',
     'https://staging1.v2.datapass.api.gouv.fr',
     'https://staging2.v2.datapass.api.gouv.fr'
     ],
   'openid email profile phone organization organizations',
   'https://datapass-development.api.gouv.fr',
   'Centralisez vos demandes d’habilitations juridiques pour accéder aux données et services en accès restreint.',
   null, null, null, null),
  (2,
   'API Particulier',
   '844e3bff46ebdac9beb18c6cf793dedfdb1776262911b3d927d24871f03e46b38756b5d015d1a693057328d8673408cccf48ef7c5a6e94fa5d101042663fb5b1',
   'oauth_api_gouv_client_secret_particulier',
   ARRAY [
     'http://particulier.api.localtest.me:3000/auth/api_gouv_particulier/callback',
     'http://particulier.api.localtest.me:5000/auth/api_gouv_particulier/callback',
     'https://sandbox.particulier.api.gouv.fr/auth/api_gouv_particulier/callback',
     'https://sandbox1.particulier.api.gouv.fr/auth/api_gouv_particulier/callback',
     'https://sandbox2.particulier.api.gouv.fr/auth/api_gouv_particulier/callback',
     'https://staging.particulier.api.gouv.fr/auth/api_gouv_particulier/callback',
     'https://staging1.particulier.api.gouv.fr/auth/api_gouv_particulier/callback',
     'https://staging2.particulier.api.gouv.fr/auth/api_gouv_particulier/callback'
     ],
   ARRAY [
     'http://particulier.api.localtest.me:3000/compte/apres-deconnexion',
     'http://particulier.api.localtest.me:5000/compte/apres-deconnexion',
     'https://sandbox.particulier.api.gouv.fr/compte/apres-deconnexion',
     'https://sandbox1.particulier.api.gouv.fr/compte/apres-deconnexion',
     'https://sandbox2.particulier.api.gouv.fr/compte/apres-deconnexion',
     'https://staging.particulier.api.gouv.fr/compte/apres-deconnexion',
     'https://staging1.particulier.api.gouv.fr/compte/apres-deconnexion',
     'https://staging2.particulier.api.gouv.fr/compte/apres-deconnexion'
     ],
   'openid email profile',
   'http://particulier.api.localtest.me',
   'Bouquet de données proposé pour simplifier les démarches administratives.',
   null, null, null, null),
  (3,
   'API Entreprise',
   '4442bfd8caac8e19ff202d33060edcd248592662d5a8098e28b706ba906fe9e0db95ad336c38248f42896db272990b8dfc969d8b8857101dabf9b2ffe7ec49b9',
   'oauth_api_gouv_client_secret_entreprise',
   ARRAY [
     'http://entreprise.api.localtest.me:3000/auth/api_gouv_entreprise/callback',
     'http://entreprise.api.localtest.me:5000/auth/api_gouv_entreprise/callback',
     'https://sandbox.entreprise.api.gouv.fr/auth/api_gouv_entreprise/callback',
     'https://sandbox1.entreprise.api.gouv.fr/auth/api_gouv_entreprise/callback',
     'https://sandbox2.entreprise.api.gouv.fr/auth/api_gouv_entreprise/callback',
     'https://staging.entreprise.api.gouv.fr/auth/api_gouv_entreprise/callback',
     'https://staging1.entreprise.api.gouv.fr/auth/api_gouv_entreprise/callback',
     'https://staging2.entreprise.api.gouv.fr/auth/api_gouv_entreprise/callback'
     ],
   ARRAY [
     'http://entreprise.api.localtest.me:3000/compte/apres-deconnexion',
     'http://entreprise.api.localtest.me:5000/compte/apres-deconnexion',
     'https://sandbox.entreprise.api.gouv.fr/compte/apres-deconnexion',
     'https://sandbox1.entreprise.api.gouv.fr/compte/apres-deconnexion',
     'https://sandbox2.entreprise.api.gouv.fr/compte/apres-deconnexion',
     'https://staging.entreprise.api.gouv.fr/compte/apres-deconnexion',
     'https://staging1.entreprise.api.gouv.fr/compte/apres-deconnexion',
     'https://staging2.entreprise.api.gouv.fr/compte/apres-deconnexion'
     ],
   'openid email profile',
   'http://entreprise.api.localtest.me',
   'Permet aux entités administratives d’accéder aux données et aux documents administratifs des entreprises et des associations, afin de simplifier leurs démarches.',
   null, null, null, null),
  (4,
   'Grist - ANCT',
   '333ba6a6fd9303ab727159eeed704bcbc2549e56cd294fdf58621f01b1856898d18c6b20dd2cec21d4dc06746453331328a1b2c1abe365a92bb2a2f3b9d68c69',
   '031da300506ac31fac6feaf88575b94b886eae7a68c64327ee03e0fa635ae9ae28572e4de53bb435b3fce4f8ac8484334d71de48f3c9abed3709c730173e0fe0',
   ARRAY [
     'https://grist.dev.incubateur.anct.gouv.fr/_oauth',
     'https://grist.dev.incubateur.anct.gouv.fr/oauth2/callback',
     'http://localhost:8484/_oauth',
     'http://localhost:8484/oauth2/callback'
     ],
   ARRAY [
     'https://grist.dev.incubateur.anct.gouv.fr',
     'https://grist.dev.incubateur.anct.gouv.fr/o/docs/signed-out',
     'http://localhost:8484',
     'http://localhost:8484/o/docs/signed-out'
     ],
   'openid email organization profile',
   'https://grist.dev.incubateur.anct.gouv.fr',
   'Saisir et manipuler collaborativement les données.',
   null, null, null, null),
  (5,
   'Annuaire des Entreprises',
   '233ba6a6fd9303ab727159eeed704bcbc2549e56cd294fdf58621f01b1856898d18c6b20dd2cec21d4dc06746453331328a1b2c1abe365a92bb2a2f3b9d68c69',
   '031da300506ac31fac6feaf88575b94b886eae7a68c64327ee03e0fa635ae9ae28572e4de53bb435b3fce4f8ac8484334d71de48f3c9abed3709c730173e0fe0',
   ARRAY [
     'http://localhost:3000/api/auth/mon-compte-pro/callback',
     'https://test.annuaire-entreprises.data.gouv.fr/api/auth/mon-compte-pro/callback'
     ],
   ARRAY [
     'http://localhost:3000/api/auth/mon-compte-pro/logout-callback',
     'https://test.annuaire-entreprises.data.gouv.fr/api/auth/mon-compte-pro/logout-callback'
     ],
   'openid email profile organization',
   'http://localhost:3000/connexion/agent-public',
   'Accédez à l’espace agent public sur l’Annuaire des Entreprises.',
   null, null, null, null),
  (6,
   'Département de l’Aveyron – Authentification',
   'RWh9+Hyv1SGrUdt8+nKey8K6RbPn9GkXqitpTHKRKChSmfICA5fl9YIhKrUtkPtlfPl4oNhfsg56B4DH+/jsoaHwFjC+UKbWKwxgzjPWuzh4AG2er173fVq/U2TGxaXU',
   'lmB72ac+JKZPUmg3+vlo9dPMkCRnFRyz+NE+lslJFX07V4JObFZ0H/vXnXB5Jzu1s96KLU5FmirsfqsKLeVukHBO6Vmy6dfcwKfjMGgWTBD6ik01KUcFq2f3bx5nO6yj',
   ARRAY [
     'https://keycloak.lab.aveyron.fr/realms/MCP/broker/oidc/endpoint',
     'https://keycloak.lab.aveyron.fr/realms/MCP/broker/moncomptepro/endpoint',
     'https://keycloak.lab.aveyron.fr/realms/MCP/broker/moncomptepro-staging/endpoint'
     ],
   ARRAY [
     'https://keycloak.lab.aveyron.fr'
     ],
   'openid email profile organization organizations',
   'https://keycloak.lab.aveyron.fr',
   'Authentification des partenaires du Département de l’Aveyron.',
   null, null, null, null),
  (7,
   'Tous à Bord',
   'nCDCeAfS0qpxr2kzps7fDQSD323DRanzNQ2JqIZKDPUHrQoqzAuVI7I0dh41dHJHyrkvHzvjUFwoooB71VbkmGykjAba2UcxJBhJL4RUO3niaqyWV7zma8KsS4CGsbIa',
   'Q8alcDUf9NwwfkPx4s3GPgac0FsZ6ZdZMIFvnbqabGuZFL4SqyJy46MgOGuUgw43Hnzjzfzzt7B64937oCmtmmxqvY9ftQyXIhMxRzNn73UspWHKv9wv2HqtTD82LTxV',
   ARRAY [
     'http://127.0.0.1:8000/oidc/callback/',
     'http://localhost:8000/oidc/callback/',
     'https://tous-a-bord.beta.gouv.fr/oidc/callback/',
     'https://tous-a-bord-staging.beta.gouv.fr/oidc/callback/'
     ],
   ARRAY [
     'http://127.0.0.1:8000/oidc/logout',
     'http://localhost:8000/oidc/logout',
     'https://tous-a-bord.beta.gouv.fr/oidc/logout',
     'https://tous-a-bord-staging.beta.gouv.fr/oidc/logout'
     ],
   'openid email',
   'https://tous-a-bord.gouv.fr',
   'Vérifie l’éligibilité de bénéficiaires d’aides au transport',
   null, null, null, null),
  (8,
   'BaseProjectSIDDEE',
   'test_baseproject_SIDDEE',
   'test_baseproject_SIDDEEh#%!tbt#ux5)xr)e7z37%l(zu13w0cj0#2sxnx&6*wx$+zvl9n',
   ARRAY [
     'http://10.59.128.114:8001/oidc/callback/',
     'http://10.59.128.114:8001/auth/cb/',
     'http://10.59.128.114:8001/oidc/auth/cb/'
     ],
   ARRAY [
     'http://10.59.128.114:8001/'
     ],
   'openid email',
   'http://10.59.128.114:8001/',
   'Dépôt de demandes auprès du service IDDEE de la DREAL HdF',
   null, null, null, null),
  (9,
   'Annuaire des collectivités',
   'tdi1iyp2stw4w1ipl9hgye9qvfm9tbgi4cxu574rkwufkocux620r4c09tpm3apsav1rg7ex5j79w2vfsnrl1v4ewlkxrm45wtt9g8x3arsco1u86xeh9j4enus14vsi',
   'pqnu9wbs0h5pkbqeni2bx55mnvgxzta3d9wmu2h6yyxmf7303b5eapi4o4plue10bcj9n1iyoilbz07b2iokr4dcw3jsqitb7lc88n9cuxn9p9v0cqstfxgu82d392vn',
   ARRAY [
     'http://127.0.0.1:1337/api/oidc/callback/',
     'http://localhost:1337/api/oidc/callback/',
     'https://api.annuaire-des-collectivites.dev.incubateur.anct.gouv.fr/api/oidc/callback/'
     ],
   ARRAY [
     'http://127.0.0.1:1337/api/oidc/logout',
     'http://localhost:1337/api/oidc/logout',
     'https://api.annuaire-des-collectivites.dev.incubateur.anct.gouv.fr/api/oidc/logout'
     ],
   'openid email profile organization organizations',
   'https://annuaire-des-collectivites.dev.incubateur.anct.gouv.fr/',
   'Accès à l’interface d’administration de l’annuaire pour les agents des communes',
   null, null, null, null),
  (10,
   'data.gouv.fr',
   '277aa530830cac03a81a5670ec13d8677291658aa0b3138c733697c9915f4a2593d5faa968143f29e893aafb8a1ffba9593c52d46db13a27cf4d3fc3485ada90',
   'e25aa11f53f13a58e8c1fe022ddc0e07e240ec0c603f78535bf5ffd470c387be2e2edc348d6923fd718b989da08a40f241543d8c1e01bbaf88ad0ec84ed9140f',
   ARRAY [
     'http://dev.local:7000/fr/mcp/auth',
     'https://dev.data.gouv.fr/fr/mcp/auth',
     'https://demo.data.gouv.fr/fr/mcp/auth'
     ],
   ARRAY [
     'http://dev.local:7000/',
     'https://dev.data.gouv.fr/'
     ],
   'openid email profile',
   'https://dev.data.gouv.fr/',
   'Plateforme ouverte des données publiques françaises.',
   null, null, null, null),
  (11,
   'Oidc Test Client',
   'test-id',
   'test-secret',
   ARRAY [
     'http://localhost:9009/auth/callback'
     ],
   ARRAY [
     'http://localhost:9009/'
   ],
   'openid email profile phone organization organizations',
   'http://localhost:9009/',
   'MonComptePro test client. More info: https://github.com/betagouv/moncomptepro-test-client.',
   null, null, null, null),
  (12,
   'Ma Cantine test',
   '7j0HTA411LSa1n4lO54gv6uMEWCey4RYwjnSQyUWcMQ7QM6SACLs8A1UTu4G0K831j4AqaZ3ZOHO98Agn5DGgjHx3J2n5F1YYEFZDmchqSv9ww1LLwXRMLJ7grT5Hl2D',
   'Jp0E7zVcoM7q1K74t372pU3aRk6uO5thM56A05mQHTXXVqCiDoTU9Bjru46DGvg4p4z3fwvQC5aXzgh7To14QskO35c92nw363tSEQHHlhfOVG16n7ZqSJ2FOattrYnD',
   ARRAY [
     'http://127.0.0.1:8000/signin-oidc',
     'https://ma-cantine-staging.cleverapps.io/signin-oidc',
     'https://ma-cantine-demo.cleverapps.io/signin-oidc'
     ],
   ARRAY [
     'http://127.0.0.1:8000/signout-callback-oidc',
     'https://ma-cantine-staging.cleverapps.io/signout-callback-oidc',
     'https://ma-cantine-demo.cleverapps.io/signout-callback-oidc'
     ],
   'openid email profile phone organization organizations',
   'https://ma-cantine-staging.cleverapps.io/',
   'Mieux manger de la crèche à l’EHPAD.',
   null, null, null, null),
  (13,
   'Egapro',
   'df292260603d69893ee7f732ac407cb014f658027616cb443401d411e53497790fedc72902ee9f9c4201c05cba9c0bbb97460e1f88351f68bff49df7c2b8ac39',
   '341b0d730ea54254d3a9a323f3adf3f431b3fe30c02bd2c62b32ccd8f6b2e9bb197eed03a2ff5e5e2be69d88ea1c60d6571cff37c488966f2f3c634c746ce2c2',
   ARRAY [
     'http://localhost:3000/api/auth/callback/moncomptepro',
     'http://localhost:3000/apiv2/auth/callback/moncomptepro',
     'http://localhost/api/auth/callback/moncomptepro',
     'http://localhost/apiv2/auth/callback/moncomptepro',
     'https://egapro-preprod.dev.fabrique.social.gouv.fr/api/auth/callback/moncomptepro',
     'https://egapro-preprod.dev.fabrique.social.gouv.fr/apiv2/auth/callback/moncomptepro',
     'https://egapro-master.dev.fabrique.social.gouv.fr/api/auth/callback/moncomptepro',
     'https://egapro-master.dev.fabrique.social.gouv.fr/apiv2/auth/callback/moncomptepro',
     'https://egapro-persist-migration-fronts-15ita1p5.dev.fabrique.social.gouv.fr/api/auth/callback/moncomptepro',
     'https://egapro-persist-migration-fronts-15ita1p5.dev.fabrique.social.gouv.fr/apiv2/auth/callback/moncomptepro',
     'http://localhost:4500/oauth/callback',
     'https://egapro-charon.ovh.fabrique.social.gouv.fr/oauth/callback'
     ],
   ARRAY [
     'http://localhost:3000',
     'http://localhost',
     'https://egapro-preprod.dev.fabrique.social.gouv.fr',
     'https://egapro-master.dev.fabrique.social.gouv.fr',
     'https://egapro-persist-migration-fronts-15ita1p5.dev.fabrique.social.gouv.fr',
     'http://localhost:4500',
     'https://egapro-charon.ovh.fabrique.social.gouv.fr'
     ],
   'openid email profile phone organization organizations',
   'https://egapro-preprod.dev.fabrique.social.gouv.fr/',
   'Egapro permet aux entreprises de mesurer, en toute transparence, les écarts de rémunération entre les sexes et de mettre en évidence leurs points de progression.',
   null, null, null, null),
  (14,
   'uMap - ANCT',
   'aiP2peephay1Ebu0VaZeNohqueeshaisee3wim5ageev8Chu3ohLiekeitataehoh3yohp8xuijeizamah9toS1aeW1cheif8obiubi6Phi3ahj0aeZ2ajaeko1uvon0',
   'eeXiet0WiengeiWuyuRailee6nie3ohdiefe5hoo6rai2ohx5iphie3seexeighai5shoo3foo5Ahwae8zaixiog1Shei4eer2beez3okoop0Cohwei7Chahkaih5ahx',
   ARRAY [
     'https://umap.dev.incubateur.anct.gouv.fr/complete/moncomptepro/',
     'http://localhost:8020/complete/moncomptepro/'
     ],
   ARRAY [
     'https://umap.dev.incubateur.anct.gouv.fr',
     'http://localhost:8020'
     ],
   'openid email profile organization',
   'https://umap.dev.incubateur.anct.gouv.fr',
   'Créer des cartes en ligne facilement.',
   null, null, null, null),
  (15,
   'AgentConnect',
   '36112b36ddcbe735b406c69e59f87fc5a96eed87923e42777f76f705c3a55e1e7a98a38a6e500640d4ce366124dc0a537cfaa967b6ef51fa99b2ca8edb8bff66',
   '85be6a293bfe2fa6ced0b246b83893a062635e577848bbbbb268da8ca0cc5844c2f5f2cbc8888891b4ac2b21a7599e47344c651a66d04f8cc34a454a5d0f1693',
   ARRAY [
     'https://fca.integ01.dev-agentconnect.fr/api/v2/oidc-callback'
     ],
   ARRAY [
     'https://fca.integ01.dev-agentconnect.fr/api/v2/client/logout-callback'
     ],
   'openid uid given_name usual_name email phone siret is_service_public',
   'https://agentconnect.gouv.fr/',
   'Dispositif d’identification des agents de la fonction publique.',
   'ES256', 'ES256', 'ES256', 'ES256'),
  (16,
   'Stack Inclusion Numérique',
   'b6f7ff663b92f83002e1f6e55806dff017a2d39eae0bc04a39e44ff9d057cb1da0ac61c0c3b359e615133c6dc7beff455b15901965513d91c4eaeb39cfb7c3f3',
   '65e0e118a568fc955bff3812bac89cee081a93bcb4d296038d6507830451233dc184f0b6833f4e56d53073f318777a26e92fd2730513439214fbec4f9e7b0035',
   ARRAY [
     'http://localhost:3000/api/auth/callback/moncomptepro'
     ],
   ARRAY [
     'http://localhost:3000'
     ],
   'openid email profile organization',
   'http://localhost:3000',
   'Permettre une mise en ligne facile, rapide et respectant les critères de qualité de l’Incubateur des Territoires.',
   null, null, null, null),
  (17,
   'MiCoSIDDEE',
   'test_mico_SIDDEE',
   'test_mico_SIDDEEh#%!tbt#ux5)xr)e7z37%l(zu13w0cj0#2sxnx&6*wx$+zvl9n',
   ARRAY [
     'http://127.0.0.1:8080/oidc/callback/',
     'http://127.0.0.1:8080/auth/cb/',
     'http://127.0.0.1:8080/oidc/auth/cb/',
     'http://localhost:8080/oidc/callback/',
     'http://localhost:8080/auth/cb/',
     'http://localhost:8080/oidc/auth/cb/',
     'http://10.59.128.114:8004/oidc/callback/',
     'http://10.59.128.114:8004/auth/cb/',
     'http://10.59.128.114:8004/oidc/auth/cb/',
     'http://preprod.eaux-et-polluants.e2.rie.gouv.fr/oidc/callback/',
     'https://preprod.eaux-et-polluants.e2.rie.gouv.fr/oidc/callback/'
     ],
   ARRAY [
     'http://localhost:8080/',
     'http://127.0.0.1:8080/',
     'http://10.59.128.114:8004/',
     'http://preprod.eaux-et-polluants.e2.rie.gouv.fr/',
     'https://preprod.eaux-et-polluants.e2.rie.gouv.fr/'
     ],
   'openid email profile organizations',
   'http://preprod.eaux-et-polluants.e2.rie.gouv.fr/',
   'Développement d’une application pour le futur pôle à compétence nationale du SIDDEE à la DREAL HdF',
   null, null, null, null),
  (18,
   'Tactick',
   'test_Tactick',
   'test_Tactickh#%!tbt#ux5)xr)e7z37%l(zu13w0cj0#2sxnx&6*wx$+zvl9n',
   ARRAY [
     'http://preprod.tactick.e2.rie.gouv.fr/oidc/callback/',
     'http://preprod.tactick.e2.rie.gouv.fr/auth/cb/',
     'http://preprod.tactick.e2.rie.gouv.fr/oidc/auth/cb/',
     'https://preprod.tactick.e2.rie.gouv.fr/oidc/callback/',
     'https://preprod.tactick.e2.rie.gouv.fr/auth/cb/',
     'https://preprod.tactick.e2.rie.gouv.fr/oidc/auth/cb/',
     'http://tactick-preprod-ihm-docker-rie.drealhdf-pre1.eco4.sihc.fr/oidc/callback/',
     'http://tactick-preprod-ihm-docker-rie.drealhdf-pre1.eco4.sihc.fr/auth/cb/',
     'http://tactick-preprod-ihm-docker-rie.drealhdf-pre1.eco4.sihc.fr/oidc/auth/cb/',
     'https://tactick-preprod-ihm-docker-rie.drealhdf-pre1.eco4.sihc.fr/oidc/callback/',
     'https://tactick-preprod-ihm-docker-rie.drealhdf-pre1.eco4.sihc.fr/auth/cb/',
     'https://tactick-preprod-ihm-docker-rie.drealhdf-pre1.eco4.sihc.fr/oidc/auth/cb/'
     ],
   ARRAY [
     'https://preprod.tactick.e2.rie.gouv.fr/',
     'http://preprod.tactick.e2.rie.gouv.fr/',
     'http://tactick-preprod-ihm-docker-rie.drealhdf-pre1.eco4.sihc.fr/',
     'https://tactick-preprod-ihm-docker-rie.drealhdf-pre1.eco4.sihc.fr/'
     ],
   'openid email',
   'https://preprod.tactick.e2.rie.gouv.fr/',
   'Développement d’une application de dépôt de demandes à destination du SIDDEE de la DREAL HdF',
   null, null, null, null),
  (19,
   'Outline - Opérateur',
   '3f9a230c90e72cf85aabd081d35e1567aedc6dac4d3be97b9514b2823c89544751a9901c78af22c2d0e5a4b75e35b893cdeb305cb217ae22984b47f610b4e14b',
   '8495eb74887ac74eaf4f21e5c3b80831adcc142c56655bed7ca2ec5c60930d675b8c2c777e6ad0a51bb9ce70d4de32d534c377087f2842c5a8d128a41358fa63',
   ARRAY [
     'https://outline-operateur-staging.osc-fr1.scalingo.io/auth/oidc.callback'
     ],
   ARRAY [
     'https://outline-operateur-staging.osc-fr1.scalingo.io/'
     ],
   'openid profile email',
   'https://outline-operateur-staging.osc-fr1.scalingo.io/',
   'La base de connaissances de votre équipe.',
   null, null, null, null),
  (20,
   'France Numerique Ensemble',
   '1e6a98e5eb16c65db76c9261f792b19f71157ac427605121eb301c00798ecafbda1ff5cb20bdda0fcc7e6792197e580212d649fb4700b98725f8918d2938fbbd',
   'e5431cbc7ad6936614ac5a5715d17f3ce5aeb8d3034561a9d425e1091c216239f0ee6f571d415d9c23d81d98b41fc0feaf1644dff96127f198b3193ecd72c875',
   ARRAY [
     'http://localhost:3000/api/auth/callback/moncomptepro',
     'https://dev.inclusion-numerique.anct.gouv.fr/api/auth/callback/moncomptepro'
     ],
   ARRAY []::varchar[],
   'openid email profile organization',
   'https://dev.inclusion-numerique.anct.gouv.fr',
   'Œuvrer Ensemble pour un Numérique Inclusif.',
   null, null, null, null),
  (21,
   'SSO - Opérateur',
   '08ac16e3052bc26cdb32ea3e6eeebc1ce315b818bcd73d6109f9c0af6371d76d0d2b35935ee197b992a4ae3531a91bd7198ecd1cdde0ffa086b1f8f2f002580c',
   '8468c62546a58ec00cb9fef48d7baeb5a0ec5da5b3fab42fde0c77b9ef39abc4abb7a42fc1f439ba9e4758c291852b64828d2cb9869236e3f0ceca335cd76b4f',
   ARRAY [
     'http://127.0.0.1:8000/oidc/callback/',
     'https://sso-operateur-staging.osc-fr1.scalingo.io/oidc/callback/'
     ],
   ARRAY [
     'http://127.0.0.1:8000/',
     'https://sso-operateur-staging.osc-fr1.scalingo.io/'
     ],
   'openid profile email',
   'https://sso-operateur-staging.osc-fr1.scalingo.io/',
   'Sso de la suite numérique.',
   null, null, null, null),
  (22,
   'Espace Partenaire',
   '21fe1930f3865c3fa693fd32bf5959302fed7c60cb7acf57093164e17e294d4d02116fd8a389037703c567b7dab99e218f40d61f1bc08d7882c6adabe07a3d9e',
   '92966278ff6bb30d2e74ff10d9e38ee1ab36c5b9ae901996d9ef4c97fb582d36a6bacefad29008423c79a0e42a83a865bd6a80691e17d815db63a0f21aa37230',
   ARRAY [
     'http://localhost:3000/api/auth/callback/moncomptepro'
     ],
   ARRAY []::varchar[],
   'openid email',
   'http://localhost:3000',
   'Gestion des clients OpenId pour MonComptePro.',
   null, null, null, null),
  (23,
   'MonComptePro Test Client',
   'client_id',
   'client_secret',
   ARRAY [
     'https://test.moncomptepro.beta.gouv.fr/login-callback',
     'http://localhost:3000/login-callback',
     'http://localhost:3001/login-callback'
     ],
   ARRAY [
     'https://test.moncomptepro.beta.gouv.fr/',
     'http://localhost:3000/',
     'http://localhost:3001/'
     ],
   'openid email profile organization',
   'https://test.moncomptepro.beta.gouv.fr/',
   'MonComptePro test client. More info: https://github.com/betagouv/moncomptepro-test-client.',
   null, null, null, null),
  (24,
   'Espace sur Demande - ANCT',
   'g9NDuOf8PAikAc4hWZzt2e3dbVxBxvZxkcZL4bHk85cfmqHot70VwhJtv9EzR7yD7MJ9LEpGAbCQdYZHO6BDd9Wn6Bx8SIwBZvaOmNmeVcU49aCZEvXjD718XeV3ihq1',
   'bAOwASqfT7RQjmURcklebBrTY79xmFY9lmkAWrBW50sdcFCYVyyKizJ7wYIlJs8dayWXJcHjNS6waBDxNy1Lb7erGPlm7ocEfnGwjK7wnhshr5DXVSVmbh5K9BhvK6gN',
   ARRAY [
     'https://espace-demande.dev.incubateur.anct.gouv.fr/complete/moncomptepro/',
     'http://localhost:3001/dev/complete/moncomptepro/',
     'http://localhost:3000/complete/moncomptepro/'
     ],
   ARRAY [
     'https://espace-demande.dev.incubateur.anct.gouv.fr',
     'http://localhost:3001'
     ],
   'openid email profile organization',
   'https://espace-demande.dev.incubateur.anct.gouv.fr',
   'Louer des espaces publics',
   null, null, null, null),
  (25,
   'Outil d’évaluation budgétaire pour Strasbourg',
   '6db31fa4f8994f207930d4af19a38f728490868ab3a16abebb86f255fda53a39a3b33cf46fdc7221efb1c531dea0ffd1e6c220f76a4a92bd87fd4092feabe5ac',
   '65d45564c315eade7066c8d0f5292fe15e5658eb7dcfaad336b8da965b58e664f39e42f834773100bdf351e2bc2ef77a2a4d3b186e3134d7c2e6f952c5edbaf7',
   ARRAY [
     'http://127.0.0.1:8000/auth'
     ],
   ARRAY [
     'http://127.0.0.1:8000/'
     ],
   'openid email profile organization',
   'https://plugin.palya.eu/',
   'Outil d’évaluation budgétaire pour Strasbourg',
   null, null, null, null),
  (26,
    'Catalogue d’indicateurs ANCT',
    'f9fcf78152c2512b35df273a906d3392809b0c15bd032a07c38ddeceb37e40bd',
    '4fe4f6fd38d9573137278fc4ba3ce898eeeb70c877e5d86a8f0cd7685e8082fe',
    ARRAY [
      'http://localhost:3000/api/auth/callback/mon-compte-pro',
      'https://catalogue-indicateurs.donnees.dev.incubateur.anct.gouv.fr/api/auth/callback/mon-compte-pro'
    ],
    ARRAY [
      'http://localhost:3000',
      'https://catalogue-indicateurs.donnees.dev.incubateur.anct.gouv.fr'
    ],
    'openid email profile organization organizations',
    'https://catalogue-indicateurs.donnees.dev.incubateur.anct.gouv.fr',
    'Consultez les indicateurs clés de l’ANCT.',
    null, null, null, null),
  (27,
    'Pad numérique',
    '82a04a41b604c877ea47fd793c095191b5e4d504bbe90ba37cd3525bf9a32c55',
    '358f6e21cb963c8baa891c3961110c6cb232aa7919dea7d9ce392ebb3b5eebc1',
    ARRAY [
      'http://localhost:3000/auth/oauth2/callback',
      'https://dinum-pad-dev.osc-fr1.scalingo.io/auth/oauth2/callback'
    ],
    ARRAY [
      'http://localhost:3000/',
      'https://dinum-pad-dev.osc-fr1.scalingo.io/'
    ],
    'openid email profile organization',
    'https://dinum-pad-dev.osc-fr1.scalingo.io/',
    'Prise de notes simple et efficace, seul ou à plusieurs',
    null, null, null, null),
  (28,
    'ANSSI Lab Outline',
    'ct2okyedpoyl59rpvuod4q0fc8fr1fyg0gj5bid3tamw7mtzs7m7swc65mc7w0o1',
    '6z18xdo9nf66z30eaufqat7lwfp3l13hmr476ewp1jfc47tnfm72rjstcfnsugvb',
    ARRAY [
      'https://lab-anssi-docs.cleverapps.io/auth/oidc.callback'
    ],
    ARRAY [
      'https://lab-anssi-docs.cleverapps.io/'
    ],
    'openid email profile organization',
    'https://lab-anssi-docs.cleverapps.io/',
    'Gestion documentaire du Lab de l’ANSSI',
    null, null, null, null),
  (29,
    'ASTREA',
    '2gvsfa9cdpx1n799kfqln7lz7bj6czacjdppaq151fud8ufrklmwnl7s9cj67nls',
    '0xeuz4budrvdfia7hq9vrgmog0mj03zgoe8puvuzhowkyw95ra4g6xolvyef8rzk',
    ARRAY [
      'https://mai-web-b2-astrea-qlf01.apps.ocp-genmob.mtrl.fr.ssg/redirect_uri',
      'https://mai-web-b2-astrea-qlf02.apps.ocp-genmob.mtrl.fr.ssg/redirect_uri',
      'https://mai-web-b2-astrea-qlf03.apps.ocp-genmob.mtrl.fr.ssg/redirect_uri',
      'https://mai-web-b2-astrea-qlf04.apps.ocp-genmob.mtrl.fr.ssg/redirect_uri',
      'https://mai-web-b2-astrea-qlf01.apps.ocp4.on-prem.innershift.ssghosting.net/redirect_uri',
      'https://mai-web-b2-astrea-qlf02.apps.ocp4.on-prem.innershift.ssghosting.net/redirect_uri',
      'https://mai-web-b2-astrea-qlf03.apps.ocp4.on-prem.innershift.ssghosting.net/redirect_uri',
      'https://mai-web-b2-astrea-qlf04.apps.ocp4.on-prem.innershift.ssghosting.net/redirect_uri'
    ],
    ARRAY [
      'https://mai-web-b2-astrea-qlf01.apps.ocp-genmob.mtrl.fr.ssg',
      'https://mai-web-b2-astrea-qlf02.apps.ocp-genmob.mtrl.fr.ssg',
      'https://mai-web-b2-astrea-qlf03.apps.ocp-genmob.mtrl.fr.ssg',
      'https://mai-web-b2-astrea-qlf04.apps.ocp-genmob.mtrl.fr.ssg',
      'https://mai-web-b2-astrea-qlf01.apps.ocp4.on-prem.innershift.ssghosting.net',
      'https://mai-web-b2-astrea-qlf02.apps.ocp4.on-prem.innershift.ssghosting.net',
      'https://mai-web-b2-astrea-qlf03.apps.ocp4.on-prem.innershift.ssghosting.net',
      'https://mai-web-b2-astrea-qlf04.apps.ocp4.on-prem.innershift.ssghosting.net'
    ],
    'openid email profile organization',
    'https://mai-web-b2-astrea-qlf01.apps.ocp-genmob.mtrl.fr.ssg',
    'Le Casier Judiciaire National lance la nouvelle application B2+ pour permettre la délivrance des bulletins n°2.',
    null, null, null, null),
  (30,
   'Grist - DINUM - Preprod',
   '343ba6a6fd9303ab727159eeed704bcbc2549e56cd294fdf58621f01b1856898d18c6b20dd2cea21d4dc06746453331328a1b2c1abe365a92bb2a2f3b9d68c68',
   '022da300506ac31fbc6feaf88575b94b886eae7a68c64327ee03e0fa135ae9ae28572e4de53bb435b3fce4f8ac8484334d71de48f3c9abed3709c730173e0bc9',
   ARRAY [
     'https://grist-preprod.beta.numerique.gouv.fr/_oauth',
     'https://grist-preprod.beta.numerique.gouv.fr/oauth2/callback'
     ],
   ARRAY [
     'https://grist-preprod.beta.numerique.gouv.fr/',
     'https://grist-preprod.beta.numerique.gouv.fr/o/docs/signed-out'
     ],
   'openid email organization profile',
   'https://grist-preprod.beta.numerique.gouv.fr/',
   'Saisir et manipuler collaborativement les données.',
   null, null, null, null),
  (31,
   'Plus Fraiche Ma Ville',
   'wkhtaqgkwkyprtgnujji668aibmlrzc98y9src51z2d7wsqtu25kp2qxgroawclfmkcnbvw9n3moukvsin20pe6kyerg2wgcxu45bsacdweoiqgefsajchv2pia3r1co',
   't0gtm3x1totp1wqj2z9vsehnfox0ncitx39hhjleminzfam1nb4ys32mr9ewuviz80r0teyt79f4roze8dsrewapk5s8k8iuw313o7cbfma9fmcjikkn21e2ilezo9jo',
   ARRAY [
     'http://localhost:3000/api/auth/callback',
     'https://staging.plusfraichemaville.fr/api/auth/callback'
     ],
   ARRAY [
     'http://localhost:3000/espace-projet',
     'http://staging.plusfraichemaville.fr/espace-projet'
     ],
   'openid email organization profile',
   'https://plusfraichemaville.fr',
   'Site de l’ADEME pour accompagner les collectivités dans la lutte contre les îlots de chaleur urbains.',
   null, null, null, null),
  (32,
   'JusticeAmiable',
   'CSonHvakFfveeeJmTiZBO3IlCuSs8wGRytIZnQ04JcakK3ZwvYjw7TSkx8i6fEnVQnrD6z1j1RhjeM5sdsyXjZRhD5XXmtPAhAGnhA1QM4mV5bKG4M1KVDad6VW0qQCp',
   '4lr4Wj8ZoPXa89Wrfe70QgFP1bdPB3vBgpazrgNfGiHcdicALI6WoyTUKdWMEsO4o3dRAT48JRJs6N6UZGfXuYbxYkkaybJ1RkXk12b7SDt7igjnnfsBYZAxg0q3EBuH',
   ARRAY [
    'http://localhost:5200/fc-login-callback',
    'https://localhost:5201/fc-login-callback',
    'https://app-minju-amiable-frontend-dev.azurewebsites.net/fc-login-callback',
    'https://app-minju-amiable-frontend-test.azurewebsites.net/fc-login-callback'
     ],
   ARRAY [
    'http://localhost:5200/fc-logout-callback',
    'https://localhost:5201/fc-logout-callback',
    'https://app-minju-amiable-frontend-dev.azurewebsites.net/fc-logout-callback',
    'https://app-minju-amiable-frontend-test.azurewebsites.net/fc-logout-callback'
     ],
   'openid email organization profile',
   'https://app-minju-amiable-frontend-dev.azurewebsites.net/',
   'Une plateforme accessible depuis justice.fr qui permet un parcours guidé de l’amiable de l’information des justiciables à la tentative de conciliation ou de médiation',
   null, null, null, null),
  (33,
   'aides-jeunes-accompagnement',
   'bluSy6KBAl0lMu3I5yD2sYeF90KaOZQEyvYBQNCMq5ohZ40VrMtx23dOPNYDj6Sej0wUE7qGni8g8QtNKstB3sxWbJSWBpfOqnl03AK7bqI0BlNWmw9Vdepy6GFXeVPL',
   'dB7BjWZaekMgzvJ70vpoTK276VOvyZQzkyGayEMtJZfP2DH7nYZU5lzsKjWaoVjLGNG1RATfXyqoStzLBumkwO8SyZIOJZMdR5OVKmkiSLpijjyv0W7s2QVNwafzyCWs',
   ARRAY [
      'https://mes-aides.1jeune1solution.beta.gouv.fr/api/auth/redirect',
      'https://preprod.mes-aides.incubateur.net/api/auth/redirect',
      'http://localhost:8080/api/auth/redirect'
     ],
   ARRAY [
      'https://mes-aides.1jeune1solution.beta.gouv.fr/accompagnement',
      'https://preprod.mes-aides.incubateur.net/accompagnement',
      'http://localhost:8080/accompagnement'
     ],
   'openid email organization profile',
   'https://mes-aides.1jeune1solution.beta.gouv.fr',
   'Outil d’accompagnement pour le simulateur de l’équipe Aides Jeunes porté par 1jeune1solution',
   null, null, null, null),
  (34,
   'CNOUS-liste',
   'DVIeqUPWW8csMZR2NvGrLEZX69o8bYFWmkfbxmWFpAaexp1hc4X8ZZLwuBKCEQ78ZdS96qpvKV6MkhB9kUIXwBevzIYoEPAsDkvt2QD3npnRBAKyyeWA0lDoNSGUV0zR',
   'vJQLgsAhl8SmSLHxy7PvF5IsecyTxkG0FBbXX6uY8pVDzINZP2opXrMygmLJBJHItcA4t7Q3MiJzX1tvlJfcGEZe0C6BtmO5aRKXnH53rLOXkcjR5YBU0XUZmvR9vIEv',
   ARRAY [
      'https://acces-int.nuonet.fr/cnous-int/login/callback',
      'https://acces-pp.nuonet.fr/cnous-pp/login/callback',
      'https://acces.lescrous.fr/cnous/login/callback'
     ],
   ARRAY [
      'https://acces-int.nuonet.fr/cnous-int/logout',
      'https://acces-pp.nuonet.fr/cnous-pp/logout',
      'https://acces.lescrous.fr/cnous/logout'
     ],
   'openid email organization profile',
   'https://foo.bar',
   'L’application doit permettre a des établissements de l’enseignement secondaire et supérieur, publics et privés, d’envoyer au cnous des listes d’étudiants pouvant bénéficier de la LOI n° 2023-265 du 13 avril 2023 visant à favoriser l’accès de tous les étudiants à une offre de restauration à tarif modéré.',
   null, null, null, null)
ON CONFLICT (id)
  DO UPDATE
  SET (client_name, client_id, client_secret, redirect_uris, post_logout_redirect_uris, scope, client_uri,
       client_description, userinfo_signed_response_alg, id_token_signed_response_alg,
       authorization_signed_response_alg, introspection_signed_response_alg)
    = (EXCLUDED.client_name, EXCLUDED.client_id, EXCLUDED.client_secret, EXCLUDED.redirect_uris,
       EXCLUDED.post_logout_redirect_uris, EXCLUDED.scope, EXCLUDED.client_uri, EXCLUDED.client_description,
       EXCLUDED.userinfo_signed_response_alg, EXCLUDED.id_token_signed_response_alg,
       EXCLUDED.authorization_signed_response_alg, EXCLUDED.introspection_signed_response_alg);

SELECT setval(
    'oidc_clients_id_seq',
    GREATEST(
        (SELECT MAX(id) FROM oidc_clients),
        (SELECT last_value FROM oidc_clients_id_seq)
      )
  );
