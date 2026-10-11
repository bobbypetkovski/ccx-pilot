-- CCX pilot proposal: Supabase setup
-- Run in the Supabase SQL editor AFTER creating the two users.
-- Works in a new project or in an existing one (e.g. the Conciergia project):
-- access is limited to the two emails below, so other users in the same
-- project can't read this proposal.

create table if not exists pilot_state (
  id          text primary key,
  doc         jsonb not null,
  updated_at  timestamptz not null default now()
);

alter publication supabase_realtime add table pilot_state;

alter table pilot_state enable row level security;

-- Replace the second email with the client's login email (same as ACCOUNTS in index.html).
create policy "two accounts read" on pilot_state
  for select to authenticated
  using ((auth.jwt() ->> 'email') in ('bobbypetkovski@gmail.com', 'client@consumercentrix.com'));

create policy "two accounts write" on pilot_state
  for all to authenticated
  using ((auth.jwt() ->> 'email') in ('bobbypetkovski@gmail.com', 'client@consumercentrix.com'))
  with check ((auth.jwt() ->> 'email') in ('bobbypetkovski@gmail.com', 'client@consumercentrix.com'));

-- Check: sign out in the app and reload. You should see the login screen,
-- and the network tab should show no proposal data.
