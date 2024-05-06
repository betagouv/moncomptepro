interface Moderation {
  id: number;
  user_id: number | null;
  organization_id: number;
  ticket_id: number | null;
  type: "organization_join_block" | "non_verified_domain";
  created_at: Date;
  moderated_at: Date | null;
  moderated_by: string | null;
  moderation_output:
    | "domain_verified"
    | "domain_removed"
    | "no_verification_means_available"
    | string;
}
