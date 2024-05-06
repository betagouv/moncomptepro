interface Organization {
  id: number;
  siret: string;
  email_domains: {
    domain: string;
    type:
      | "verified"
      | "official_contact"
      | "authorized"
      | "external"
      | "trackdechet_postal_mail";
    suggest: boolean;
    verified_at: Date;
  }[];
  created_at: Date;
  updated_at: Date;
  cached_libelle: string | null;
  cached_nom_complet: string | null;
  cached_enseigne: string | null;
  cached_tranche_effectifs: TrancheEffectifs;
  cached_tranche_effectifs_unite_legale: string | null;
  cached_libelle_tranche_effectif: string | null;
  cached_etat_administratif: string | null;
  cached_est_active: string | null;
  cached_statut_diffusion: string | null;
  cached_est_diffusible: string | null;
  cached_adresse: string | null;
  cached_code_postal: string | null;
  cached_code_officiel_geographique: string | null;
  cached_activite_principale: string | null;
  cached_libelle_activite_principale: string | null;
  cached_categorie_juridique: string | null;
  cached_libelle_categorie_juridique: string | null;
  organization_info_fetched_at: Date | null;
}
