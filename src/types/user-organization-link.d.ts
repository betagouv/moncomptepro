interface BaseUserOrganizationLink {
  is_external: boolean;
  verification_type:
    | "domain"
    | "verified_contact_email"
    | "code_sent_to_official_contact_email"
    | "official_contact_email"
    | "in_liste_dirigeants_rna"
    | "no_verification_means_for_unipersonnel_org"
    | "no_verification_means_available"
    | null;
  verified_at: Date;
  authentication_by_peers_type:
    | "all_members_notified"
    | "sponsored_by_member"
    | "is_the_only_active_member"
    | "deactivated_by_whitelist"
    | null;
  has_been_greeted: boolean;
  sponsor_id: number | null;
  needs_official_contact_email_verification: boolean;
  official_contact_email_verification_token: string | null;
  official_contact_email_verification_sent_at: Date | null;
}

interface UserOrganizationLink extends BaseUserOrganizationLink {
  user_id: number;
  organization_id: number;
  created_at: Date;
  updated_at: Date;
}
