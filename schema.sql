-- Pega esto entero en Supabase > SQL Editor > New query > Run.

create table if not exists public.en_cards (
  id          bigint generated always as identity primary key,
  user_id     uuid not null default auth.uid() references auth.users(id) on delete cascade,
  front       text not null,
  back        text not null,
  example     text default '',
  tag         text default '',
  due         date not null default current_date,
  interval    int  not null default 0,
  ease        real not null default 2.5,
  reps        int  not null default 0,
  lapses      int  not null default 0,
  state       text not null default 'new',
  created_at  timestamptz not null default now()
);

create index if not exists en_cards_user_due_idx on public.en_cards (user_id, due);

alter table public.en_cards enable row level security;

drop policy if exists "own en_cards" on public.en_cards;
create policy "own en_cards" on public.en_cards
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- Log de repasos, para ver progreso
create table if not exists public.en_reviews (
  id         bigint generated always as identity primary key,
  user_id    uuid not null default auth.uid() references auth.users(id) on delete cascade,
  card_id    bigint references public.en_cards(id) on delete cascade,
  grade      int not null,
  was_new    boolean not null default false,
  reviewed_at timestamptz not null default now()
);

create index if not exists en_reviews_user_time_idx on public.en_reviews (user_id, reviewed_at);

alter table public.en_reviews enable row level security;

drop policy if exists "own en_reviews" on public.en_reviews;
create policy "own en_reviews" on public.en_reviews
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
