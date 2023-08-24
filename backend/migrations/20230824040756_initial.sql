-- add migration script here

create table accounts (
  id uuid primary key,
  name varchar(150) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  account_type varchar(50) default null,
  industry varchar(50) default null,
  annual_revenue varchar(100) default null,
  phone_fax varchar(100) default null,
  billing_address_street varchar(150) default null,
  billing_address_city varchar(100) default null,
  billing_address_state varchar(100) default null,
  billing_address_postalcode varchar(20) default null,
  billing_address_country varchar(255) default null,
  rating varchar(100) default null,
  phone_office varchar(100) default null,
  phone_alternate varchar(100) default null,
  website varchar(255) default null,
  ownership varchar(100) default null,
  employees varchar(10) default null,
  ticker_symbol varchar(10) default null,
  shipping_address_street varchar(150) default null,
  shipping_address_city varchar(100) default null,
  shipping_address_state varchar(100) default null,
  shipping_address_postalcode varchar(20) default null,
  shipping_address_country varchar(255) default null,
  parent_id uuid default null,
  sic_code varchar(10) default null,
  campaign_id uuid default null
);

create index idx_accnt_id_del on accounts(id,deleted);
create index idx_accnt_name_del on accounts (name,deleted);
create index idx_accnt_assigned_del on accounts(deleted,assigned_user_id);
create index idx_accnt_parent_id on accounts(parent_id);

create table accounts_audit (
  id uuid primary key,
  parent_id uuid not null,
  date_created timestamptz default null,
  created_by uuid default null,
  field_name varchar(100) default null,
  data_type varchar(100) default null,
  before_value_string varchar(255) default null,
  after_value_string varchar(255) default null,
  before_value_text text default null,
  after_value_text text default null
);

create index idx_accounts_parent_id on accounts_audit(parent_id);

create table accounts_bugs (
  id uuid primary key,
  account_id uuid default null,
  bug_id uuid default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_acc_bug_acc on accounts_bugs(account_id);
create index idx_acc_bug_bug on accounts_bugs(bug_id);
create index idx_account_bug on accounts_bugs(account_id,bug_id);

create table accounts_cases (
  id uuid primary key,
  account_id uuid default null,
  case_id uuid default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_acc_case_acc on accounts_cases(account_id);
create index idx_acc_acc_case on accounts_cases(case_id);

create table accounts_contacts (
  id uuid primary key,
  contact_id uuid default null,
  account_id uuid default null,
  date_modified timestamptz default null,
  deleted boolean default null
);

create index idx_account_contact on accounts_contacts(account_id,contact_id);
create index idx_contid_del_accid on accounts_contacts(contact_id,deleted,account_id);

create table accounts_cstm (
  id_c uuid primary key,
  jjwg_maps_lng_c float default 0.00000000,
  jjwg_maps_lat_c float default 0.00000000,
  jjwg_maps_geocode_status_c varchar(255) default null,
  jjwg_maps_address_c varchar(255) default null
);

create table accounts_opportunities (
  id uuid primary key,
  opportunity_id uuid default null,
  account_id uuid default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_account_opportunity  on accounts_opportunities(account_id,opportunity_id);
create index idx_oppid_del_accid on accounts_opportunities(opportunity_id,deleted,account_id);

create table acl_actions (
  id uuid primary key,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  name varchar(150) default null,
  category varchar(100) default null,
  acltype varchar(100) default null,
  aclaccess smallint default null,
  deleted boolean default false
);

create index idx_aclaction_id_del on acl_actions(id,deleted);
create index idx_category_name on acl_actions(category,name);

create table acl_roles (
  id uuid primary key,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  name varchar(150) default null,
  description text default null,
  deleted boolean default false
);

create index idx_aclrole_id_del on acl_roles(id,deleted);

create table acl_roles_actions (
  id uuid primary key,
  role_id uuid default null,
  action_id uuid default null,
  access_override smallint default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_acl_role_id on acl_roles_actions(role_id);
create index idx_acl_action_id on acl_roles_actions(action_id);
create index idx_aclrole_action on acl_roles_actions(role_id,action_id);

create table acl_roles_users (
  id uuid primary key,
  role_id uuid default null,
  user_id uuid default null,
  date_modified timestamptz default null,
  deleted boolean default false
);


create index idx_aclrole_id on acl_roles_users(role_id);
create index idx_acluser_id on acl_roles_users(user_id);
create index idx_aclrole_user on acl_roles_users(role_id,user_id);

create table address_book (
  assigned_user_id uuid not null,
  bean varchar(50) default null,
  bean_id uuid not null
);

create index ab_user_bean_idx on address_book(assigned_user_id,bean);

CREATE TABLE alerts (
  id uuid primary key,
  name varchar(255) DEFAULT NULL,
  date_entered timestamptz DEFAULT NULL,
  date_modified timestamptz DEFAULT NULL,
  modified_user_id uuid DEFAULT NULL,
  created_by uuid DEFAULT NULL,
  description text DEFAULT NULL,
  deleted boolean DEFAULT false,
  assigned_user_id uuid DEFAULT NULL,
  is_read boolean DEFAULT NULL,
  target_module varchar(255) DEFAULT NULL,
  type varchar(255) DEFAULT NULL,
  url_redirect varchar(255) DEFAULT NULL,
  reminder_id uuid DEFAULT NULL,
  snooze timestamptz DEFAULT NULL,
  date_start timestamptz DEFAULT NULL
);

CREATE TABLE am_projecttemplates (
  id uuid primary key,
  name varchar(255) DEFAULT NULL,
  date_entered timestamptz DEFAULT NULL,
  date_modified timestamptz DEFAULT NULL,
  modified_user_id uuid DEFAULT NULL,
  created_by uuid DEFAULT NULL,
  description text DEFAULT NULL,
  deleted boolean DEFAULT false,
  assigned_user_id uuid DEFAULT NULL,
  status varchar(100) DEFAULT 'Draft',
  priority varchar(100) DEFAULT 'High',
  override_business_hours boolean DEFAULT false
);

CREATE TABLE am_projecttemplates_audit (
  id uuid primary key,
  parent_id uuid NOT NULL,
  date_created timestamptz DEFAULT NULL,
  created_by uuid DEFAULT NULL,
  field_name varchar(100) DEFAULT NULL,
  data_type varchar(100) DEFAULT NULL,
  before_value_string varchar(255) DEFAULT NULL,
  after_value_string varchar(255) DEFAULT NULL,
  before_value_text text DEFAULT NULL,
  after_value_text text DEFAULT NULL
);

create index idx_am_projecttemplates_parent_id on am_projecttemplates_audit(parent_id);

CREATE TABLE am_projecttemplates_contacts_1_c (
  id uuid primary key,
  date_modified timestamptz DEFAULT NULL,
  deleted boolean DEFAULT false,
  am_projecttemplates_ida uuid DEFAULT NULL,
  contacts_idb uuid DEFAULT NULL
);

create index am_projecttemplates_contacts_1_alt on am_projecttemplates_contacts_1_c(am_projecttemplates_ida,contacts_idb);