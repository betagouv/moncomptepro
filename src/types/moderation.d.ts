interface Moderation {
  id: number;
  user_id: number;
  organization_id: number;
  ticket_id: number | null;
  type: "organization_join_block" | "non_verified_domain";
  created_at: Date;
  moderated_at: Date | null;
  comment: string | null;
  moderated_by: string | null;
}
