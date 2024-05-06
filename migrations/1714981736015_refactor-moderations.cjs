exports.shorthands = undefined;

exports.up = async (pgm) => {
  await pgm.db.query(`
    CREATE TABLE email_domains
    (
      id              SERIAL PRIMARY KEY,
      organization_id INTEGER REFERENCES organizations (id) ON DELETE CASCADE,
      domain          VARCHAR(255),
      type            VARCHAR(255),
      suggest         BOOLEAN DEFAULT true,
      verified_at     TIMESTAMP WITH TIME ZONE
    );
  `);

  await pgm.db.query(`
    INSERT INTO email_domains
      (organization_id, domain, type)
    SELECT id, unnest(verified_email_domains), 'verified'
    FROM organizations;
  `);

  await pgm.db.query(`
    INSERT INTO email_domains
      (organization_id, domain, type)
    SELECT id, unnest(authorized_email_domains), 'authorized'
    FROM organizations;
  `);

  await pgm.db.query(`
    INSERT INTO email_domains
      (organization_id, domain, type)
    SELECT id, unnest(external_authorized_email_domains), 'external'
    FROM organizations;
  `);

  await pgm.db.query(`
    INSERT INTO email_domains
      (organization_id, domain, type)
    SELECT id, unnest(trackdechets_email_domains), 'trackdechet_postal_mail'
    FROM organizations;
  `);

  await pgm.db.query(`
    ALTER TABLE organizations
      DROP COLUMN verified_email_domains,
      DROP COLUMN authorized_email_domains,
      DROP COLUMN external_authorized_email_domains,
      DROP COLUMN trackdechets_email_domains;
  `);
};

exports.down = async (pgm) => {
  await pgm.db.query(`
    ALTER TABLE organizations
      ADD COLUMN verified_email_domains            varchar[] DEFAULT '{}'::varchar[] NOT NULL,
      ADD COLUMN authorized_email_domains          varchar[] DEFAULT '{}'::varchar[] NOT NULL,
      ADD COLUMN external_authorized_email_domains varchar[] DEFAULT '{}'::varchar[] NOT NULL,
      ADD COLUMN trackdechets_email_domains        varchar[] DEFAULT '{}'::varchar[] NOT NULL;
  `);

  await pgm.db.query(`
    UPDATE organizations o
    SET verified_email_domains = ARRAY(
      SELECT domain
      FROM email_domains
      WHERE o.id = organization_id
        AND type = 'verified')
    FROM email_domains ed
    WHERE o.id = ed.organization_id;
  `);

  await pgm.db.query(`
    UPDATE organizations o
    SET authorized_email_domains = ARRAY(
      SELECT domain
      FROM email_domains
      WHERE o.id = organization_id
        AND type = 'authorized')
    FROM email_domains ed
    WHERE o.id = ed.organization_id;
  `);

  await pgm.db.query(`
    UPDATE organizations o
    SET external_authorized_email_domains = ARRAY(
      SELECT domain
      FROM email_domains
      WHERE o.id = organization_id
        AND type = 'external')
    FROM email_domains ed
    WHERE o.id = ed.organization_id;
  `);

  await pgm.db.query(`
    UPDATE organizations o
    SET trackdechets_email_domains = ARRAY(
      SELECT domain
      FROM email_domains
      WHERE o.id = organization_id
        AND type = 'trackdechet_postal_mail')
    FROM email_domains ed
    WHERE o.id = ed.organization_id;
  `);

  await pgm.db.query(`DROP TABLE email_domains;`);
};
