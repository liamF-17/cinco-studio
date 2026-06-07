-- Lock down contact_submissions: anyone (anon role) can INSERT a new row,
-- but no one without service-role credentials can read, update, or delete.
-- The absence of SELECT/UPDATE/DELETE policies is intentional — with RLS
-- enabled, missing policies = denied.

alter table public.contact_submissions enable row level security;

create policy "Anyone can insert contact submissions"
  on public.contact_submissions
  for insert
  to anon, authenticated
  with check (true);
