create extension if not exists "pgcrypto";

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  currency text not null default 'INR',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.accounts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  type text not null check (type in ('cash', 'bank', 'credit_card', 'wallet', 'loan', 'investment', 'other')),
  currency text not null default 'INR',
  opening_balance numeric(14, 2) not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.transaction_categories (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  name text not null,
  kind text not null check (kind in ('income', 'expense')),
  icon text,
  color text,
  created_at timestamptz not null default now()
);

create table if not exists public.transactions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  account_id uuid references public.accounts(id) on delete set null,
  category_id uuid references public.transaction_categories(id) on delete set null,
  amount numeric(14, 2) not null check (amount > 0),
  type text not null check (type in ('expense', 'income', 'transfer')),
  description text not null,
  transaction_date date not null default current_date,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists transactions_user_date_idx on public.transactions(user_id, transaction_date desc);
create index if not exists transactions_user_type_idx on public.transactions(user_id, type);
create index if not exists accounts_user_idx on public.accounts(user_id);

alter table public.profiles enable row level security;
alter table public.accounts enable row level security;
alter table public.transaction_categories enable row level security;
alter table public.transactions enable row level security;

create policy "Users manage their profile" on public.profiles for all using (auth.uid() = id) with check (auth.uid() = id);
create policy "Users manage their accounts" on public.accounts for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "Users read their categories" on public.transaction_categories for select using (user_id is null or auth.uid() = user_id);
create policy "Users manage their categories" on public.transaction_categories for insert with check (auth.uid() = user_id);
create policy "Users update their categories" on public.transaction_categories for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "Users delete their categories" on public.transaction_categories for delete using (auth.uid() = user_id);
create policy "Users manage their transactions" on public.transactions for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id) values (new.id);
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();