# Supabase

This folder is the source of truth for the Cinco Studio database schema. Once the
Supabase GitHub integration is connected, any new file in `migrations/` (named
`<YYYYMMDDHHMMSS>_<slug>.sql`) gets applied automatically on push to `main`.

## Linked project

- **Name:** liamF-17's Project
- **Ref:** `joodiswcheojiniewktk`
- **Region:** `us-east-1`
- **Dashboard:** https://supabase.com/dashboard/project/joodiswcheojiniewktk

## What's in here

- `migrations/` — every schema change, version-numbered. Already-applied versions
  are skipped by Supabase on push; only new ones run.
- `config.toml` — Supabase CLI config. Only matters for local dev (`supabase start`).

## How to add a new migration

1. **Via the MCP / dashboard / CLI**, apply the SQL to the remote DB and note the
   version it gets recorded as (check `supabase_migrations.schema_migrations` or
   `supabase migration list`).
2. Create a file `migrations/<that-version>_<short-slug>.sql` with the same SQL.
3. Commit and push. The integration sees the version is already applied remotely
   and just records the file. Future deploys to other branches will run it.

Alternative (CLI-only flow):

```
supabase migration new <slug>            # creates the file with a fresh timestamp
# edit the file
supabase db push                          # apply to remote
git add supabase/migrations && git commit -m "..."
```

## Anon vs service role

- `anon` / browser key (used by `index.html`): **INSERT only** on `contact_submissions`.
- `service_role` (used by the MCP, dashboard, CLI): full access.
- Never paste a service-role key into client-side code.
