-- Contact form inbound submissions for cincostudio.com.
-- Check constraints provide the real validation layer; RLS (next migration)
-- restricts the anon role to INSERT-only.

create table public.contact_submissions (
  id           bigint generated always as identity primary key,
  created_at   timestamptz not null default now(),
  nombre       text        not null,
  correo       text        not null,
  asunto       text,
  mensaje      text        not null,
  source       text        default 'cinco-studio website',
  user_agent   text,
  constraint nombre_len  check (char_length(nombre)  between 1 and 200),
  constraint correo_len  check (char_length(correo)  between 3 and 320),
  constraint asunto_len  check (asunto is null or char_length(asunto) <= 200),
  constraint mensaje_len check (char_length(mensaje) between 1 and 5000),
  constraint correo_fmt  check (correo ~* '^[^@\s]+@[^@\s]+\.[^@\s]+$')
);

comment on table public.contact_submissions is 'Inbound contact form submissions from cincostudio.com';
