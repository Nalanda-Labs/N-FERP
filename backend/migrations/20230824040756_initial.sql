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

create index idx_accnt_id_del on accounts(id, deleted);
create index idx_accnt_name_del on accounts (name, deleted);
create index idx_accnt_assigned_del on accounts(deleted, assigned_user_id);
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
create index idx_account_bug on accounts_bugs(account_id, bug_id);

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

create index idx_account_contact on accounts_contacts(account_id, contact_id);
create index idx_contid_del_accid on accounts_contacts(contact_id, deleted, account_id);

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

create index idx_account_opportunity on accounts_opportunities(account_id, opportunity_id);
create index idx_oppid_del_accid on accounts_opportunities(opportunity_id, deleted, account_id);

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

create index idx_aclaction_id_del on acl_actions(id, deleted);
create index idx_category_name on acl_actions(category, name);

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

create index idx_aclrole_id_del on acl_roles(id, deleted);

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
create index idx_aclrole_action on acl_roles_actions(role_id, action_id);

create table acl_roles_users (
  id uuid primary key,
  role_id uuid default null,
  user_id uuid default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_aclrole_id on acl_roles_users(role_id);
create index idx_acluser_id on acl_roles_users(user_id);
create index idx_aclrole_user on acl_roles_users(role_id, user_id);

create table address_book (
  assigned_user_id uuid not null,
  bean varchar(50) default null,
  bean_id uuid not null
);

create index ab_user_bean_idx on address_book(assigned_user_id, bean);

create table alerts (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  is_read boolean default null,
  target_module varchar(255) default null,
  type varchar(255) default null,
  url_redirect varchar(255) default null,
  reminder_id uuid default null,
  snooze timestamptz default null,
  date_start timestamptz default null
);

create table am_projecttemplates (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  status varchar(100) default 'draft',
  priority varchar(100) default 'high',
  override_business_hours boolean default false
);

create table am_projecttemplates_audit (
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

create index idx_am_projecttemplates_parent_id on am_projecttemplates_audit(parent_id);

create table am_projecttemplates_contacts_1_c (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  am_projecttemplates_ida uuid default null,
  contacts_idb uuid default null
);

create index am_projecttemplates_contacts_1_alt on am_projecttemplates_contacts_1_c(am_projecttemplates_ida, contacts_idb);

create table am_projecttemplates_project_1_c (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  am_projecttemplates_project_1am_projecttemplates_ida uuid default null,
  am_projecttemplates_project_1project_idb uuid default null
);

create index am_projecttemplates_project_1_ida1 on am_projecttemplates_project_1_c(
  am_projecttemplates_project_1am_projecttemplates_ida
);
create index am_projecttemplates_project_1_alt on am_projecttemplates_project_1_c(am_projecttemplates_project_1project_idb);

create table am_projecttemplates_users_1_c (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  am_projecttemplates_ida uuid default null,
  users_idb uuid default null
);

create index am_projecttemplates_users_1_alt on am_projecttemplates_users_1_c(am_projecttemplates_ida, users_idb);

create table am_tasktemplates (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  status varchar(100) default 'not started',
  priority varchar(100) default 'high',
  percent_complete int default 0,
  predecessors int default null,
  milestone_flag boolean default false,
  relationship_type varchar(100) default 'fs',
  task_number int default null,
  order_number int default null,
  estimated_effort int default null,
  utilization varchar(100) default '0',
  duration int default null
);

create table am_tasktemplates_am_projecttemplates_c (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  am_tasktemplates_am_projecttemplatesam_projecttemplates_ida uuid default null,
  am_tasktemplates_am_projecttemplatesam_tasktemplates_idb uuid default null
);

create index am_tasktemplates_am_projecttemplates_ida1 on am_tasktemplates_am_projecttemplates_c(
  am_tasktemplates_am_projecttemplatesam_projecttemplates_ida
);
create index am_tasktemplates_am_projecttemplates_alt on am_tasktemplates_am_projecttemplates_c(
  am_tasktemplates_am_projecttemplatesam_tasktemplates_idb
);

create table am_tasktemplates_audit (
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

create index idx_am_tasktemplates_parent_id on am_projecttemplates_audit(parent_id);

create table aobh_businesshours (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  opening_hours varchar(100) default '1',
  closing_hours varchar(100) default '1',
  open_status boolean default null,
  day varchar(100) default 'monday'
);

create table aok_knowledge_base_categories (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null
);

create table aok_knowledge_base_categories_audit (
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

create index idx_aok_knowledge_base_categories_parent_id on aok_knowledge_base_categories_audit(parent_id);

create table aok_knowledgebase (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  status varchar(100) default 'draft',
  revision varchar(255) default null,
  additional_info text default null,
  user_id_c uuid default null,
  user_id1_c uuid default null
);

create table aok_knowledgebase_audit (
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

create index idx_aok_knowledgebase_parent_id on aok_knowledgebase_audit(parent_id);

create table aok_knowledgebase_categories (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  aok_knowledgebase_id uuid default null,
  aok_knowledge_base_categories_id uuid default null
);

create index aok_knowledgebase_categories_alt on aok_knowledgebase_categories(aok_knowledgebase_id,aok_knowledge_base_categories_id);

create table aop_case_events (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  case_id uuid default null
);

create table aop_case_events_audit (
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

create index idx_aop_case_events_parent_id on aop_case_events_audit(parent_id);

create table aop_case_updates (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  case_id uuid default null,
  contact_id uuid default null,
  internal boolean default null
);

create table aop_case_updates_audit (
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

create index idx_aop_case_updates_parent_id on aop_case_updates_audit(parent_id);

create table aor_charts (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  aor_report_id uuid default null,
  type varchar(100) default null,
  x_field int default null,
  y_field int default null
);

create table aor_conditions (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  aor_report_id uuid default null,
  condition_order int default null,
  logic_op varchar(255) default null,
  parenthesis varchar(255) default null,
  module_path text default null,
  field varchar(100) default null,
  operator varchar(100) default null,
  value_type varchar(100) default null,
  value varchar(255) default null,
  parameter boolean default null
);

create index aor_conditions_index_report_id on aor_conditions(aor_report_id);

create table aor_fields (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  aor_report_id uuid default null,
  field_order int default null,
  module_path text default null,
  field varchar(100) default null,
  display boolean default null,
  link boolean default null,
  label varchar(255) default null,
  field_function varchar(100) default null,
  sort_by varchar(100) default null,
  format varchar(100) default null,
  total varchar(100) default null,
  sort_order varchar(100) default null,
  group_by boolean default null,
  group_order varchar(100) default null,
  group_display int default null
);

create index aor_fields_index_report_id on aor_fields(aor_report_id);

create table aor_reports (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  report_module varchar(100) default null,
  graphs_per_row int default 2
);

create table aor_reports_audit (
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

create index idx_aor_reports_parent_id on aor_reports_audit(parent_id);

create table aor_scheduled_reports (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  schedule varchar(100) default null,
  last_run timestamptz default null,
  status varchar(100) default null,
  email_recipients text default null,
  aor_report_id uuid default null
);

create table aos_contracts (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  reference_code varchar(255) default null,
  start_date date default null,
  end_date date default null,
  total_contract_value decimal(26,6) default null,
  total_contract_value_usdollar decimal(26,6) default null,
  currency_id uuid default null,
  status varchar(100) default 'not started',
  customer_signed_date date default null,
  company_signed_date date default null,
  renewal_reminder_date timestamptz default null,
  contract_type varchar(100) default 'type',
  contract_account_id uuid default null,
  opportunity_id uuid default null,
  contact_id uuid default null,
  call_id uuid default null,
  total_amt decimal(26,6) default null,
  total_amt_usdollar decimal(26,6) default null,
  subtotal_amount decimal(26,6) default null,
  subtotal_amount_usdollar decimal(26,6) default null,
  discount_amount decimal(26,6) default null,
  discount_amount_usdollar decimal(26,6) default null,
  tax_amount decimal(26,6) default null,
  tax_amount_usdollar decimal(26,6) default null,
  shipping_amount decimal(26,6) default null,
  shipping_amount_usdollar decimal(26,6) default null,
  shipping_tax varchar(100) default null,
  shipping_tax_amt decimal(26,6) default null,
  shipping_tax_amt_usdollar decimal(26,6) default null,
  total_amount decimal(26,6) default null,
  total_amount_usdollar decimal(26,6) default null
);

create table aos_contracts_audit (
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

create index idx_aos_contracts_parent_id on aos_contracts_audit(parent_id);

create table aos_contracts_documents (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  aos_contracts_id uuid default null,
  documents_id uuid default null,
  document_revision_id uuid default null
);

create index aos_contracts_documents_alt on aos_contracts_documents(aos_contracts_id,documents_id);

create table aos_invoices (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  billing_account_id uuid default null,
  billing_contact_id uuid default null,
  billing_address_street varchar(150) default null,
  billing_address_city varchar(100) default null,
  billing_address_state varchar(100) default null,
  billing_address_postalcode varchar(20) default null,
  billing_address_country varchar(255) default null,
  shipping_address_street varchar(150) default null,
  shipping_address_city varchar(100) default null,
  shipping_address_state varchar(100) default null,
  shipping_address_postalcode varchar(20) default null,
  shipping_address_country varchar(255) default null,
  number int not null,
  total_amt decimal(26,6) default null,
  total_amt_usdollar decimal(26,6) default null,
  subtotal_amount decimal(26,6) default null,
  subtotal_amount_usdollar decimal(26,6) default null,
  discount_amount decimal(26,6) default null,
  discount_amount_usdollar decimal(26,6) default null,
  tax_amount decimal(26,6) default null,
  tax_amount_usdollar decimal(26,6) default null,
  shipping_amount decimal(26,6) default null,
  shipping_amount_usdollar decimal(26,6) default null,
  shipping_tax varchar(100) default null,
  shipping_tax_amt decimal(26,6) default null,
  shipping_tax_amt_usdollar decimal(26,6) default null,
  total_amount decimal(26,6) default null,
  total_amount_usdollar decimal(26,6) default null,
  currency_id uuid default null,
  quote_number int default null,
  quote_date date default null,
  invoice_date date default null,
  due_date date default null,
  status varchar(100) default null,
  template_ddown_c text default null,
  subtotal_tax_amount decimal(26,6) default null,
  subtotal_tax_amount_usdollar decimal(26,6) default null
);

create table aos_invoices_audit (
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

create index idx_aos_invoices_parent_id on aos_invoices_audit(parent_id);

create table aos_line_item_groups (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  total_amt decimal(26,6) default null,
  total_amt_usdollar decimal(26,6) default null,
  discount_amount decimal(26,6) default null,
  discount_amount_usdollar decimal(26,6) default null,
  subtotal_amount decimal(26,6) default null,
  subtotal_amount_usdollar decimal(26,6) default null,
  tax_amount decimal(26,6) default null,
  tax_amount_usdollar decimal(26,6) default null,
  subtotal_tax_amount decimal(26,6) default null,
  subtotal_tax_amount_usdollar decimal(26,6) default null,
  total_amount decimal(26,6) default null,
  total_amount_usdollar decimal(26,6) default null,
  parent_type varchar(100) default null,
  parent_id uuid default null,
  number int default null,
  currency_id uuid default null
);

create table aos_line_item_groups_audit (
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

create index idx_aos_line_item_groups_parent_id on aos_line_item_groups_audit(parent_id);

create table aos_pdf_templates (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  active boolean default true,
  type varchar(100) default null,
  pdfheader text default null,
  pdffooter text default null,
  margin_left int default 15,
  margin_right int default 15,
  margin_top int default 16,
  margin_bottom int default 16,
  margin_header int default 9,
  margin_footer int default 9,
  page_size varchar(100) default null,
  orientation varchar(100) default null
);

create table aos_pdf_templates_audit (
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

create index idx_aos_pdf_templates_parent_id on aos_pdf_templates_audit(parent_id);

create table aos_product_categories (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  is_parent boolean default false,
  parent_category_id char(36) default null
);

create table aos_product_categories_audit (
  id uuid primary key,
  parent_id uuid not null,
  date_created timestamptz default null,
  created_by varchar(36) default null,
  field_name varchar(100) default null,
  data_type varchar(100) default null,
  before_value_string varchar(255) default null,
  after_value_string varchar(255) default null,
  before_value_text text default null,
  after_value_text text default null
);

create index idx_aos_product_categories_parent_id on aos_product_categories_audit(parent_id);

create table aos_products (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  maincode varchar(100) default 'xxxx',
  part_number varchar(25) default null,
  category varchar(100) default null,
  type varchar(100) default 'good',
  cost decimal(26,6) default null,
  cost_usdollar decimal(26,6) default null,
  currency_id uuid default null,
  price decimal(26,6) default null,
  price_usdollar decimal(26,6) default null,
  url varchar(255) default null,
  contact_id uuid default null,
  product_image varchar(255) default null,
  aos_product_category_id uuid default null
);

create table aos_products_audit (
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

create index idx_aos_products_parent_id on aos_products_audit (parent_id);

create table aos_products_quotes (
  id uuid primary key,
  name text default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  currency_id uuid default null,
  part_number varchar(255) default null,
  item_description text default null,
  number int default null,
  product_qty decimal(18,4) default null,
  product_cost_price decimal(26,6) default null,
  product_cost_price_usdollar decimal(26,6) default null,
  product_list_price decimal(26,6) default null,
  product_list_price_usdollar decimal(26,6) default null,
  product_discount decimal(26,6) default null,
  product_discount_usdollar decimal(26,6) default null,
  product_discount_amount decimal(26,6) default null,
  product_discount_amount_usdollar decimal(26,6) default null,
  discount varchar(255) default 'percentage',
  product_unit_price decimal(26,6) default null,
  product_unit_price_usdollar decimal(26,6) default null,
  vat_amt decimal(26,6) default null,
  vat_amt_usdollar decimal(26,6) default null,
  product_total_price decimal(26,6) default null,
  product_total_price_usdollar decimal(26,6) default null,
  vat varchar(100) default '5.0',
  parent_type varchar(100) default null,
  parent_id uuid default null,
  product_id uuid default null,
  group_id uuid default null
);

create index idx_aospq_par_del on aos_products_quotes(parent_id,parent_type,deleted);

create table aos_products_quotes_audit (
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

create index idx_aos_products_quotes_parent_id on aos_products_quotes_audit(parent_id);

create table aos_quotes (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  approval_issue text default null,
  billing_account_id uuid default null,
  billing_contact_id uuid default null,
  billing_address_street varchar(150) default null,
  billing_address_city varchar(100) default null,
  billing_address_state varchar(100) default null,
  billing_address_postalcode varchar(20) default null,
  billing_address_country varchar(255) default null,
  shipping_address_street varchar(150) default null,
  shipping_address_city varchar(100) default null,
  shipping_address_state varchar(100) default null,
  shipping_address_postalcode varchar(20) default null,
  shipping_address_country varchar(255) default null,
  expiration date default null,
  number int default null,
  opportunity_id uuid default null,
  template_ddown_c text default null,
  total_amt decimal(26,6) default null,
  total_amt_usdollar decimal(26,6) default null,
  subtotal_amount decimal(26,6) default null,
  subtotal_amount_usdollar decimal(26,6) default null,
  discount_amount decimal(26,6) default null,
  discount_amount_usdollar decimal(26,6) default null,
  tax_amount decimal(26,6) default null,
  tax_amount_usdollar decimal(26,6) default null,
  shipping_amount decimal(26,6) default null,
  shipping_amount_usdollar decimal(26,6) default null,
  shipping_tax varchar(100) default null,
  shipping_tax_amt decimal(26,6) default null,
  shipping_tax_amt_usdollar decimal(26,6) default null,
  total_amount decimal(26,6) default null,
  total_amount_usdollar decimal(26,6) default null,
  currency_id char(36) default null,
  stage varchar(100) default 'draft',
  term varchar(100) default null,
  terms_c text default null,
  approval_status varchar(100) default null,
  invoice_status varchar(100) default 'not invoiced',
  subtotal_tax_amount decimal(26,6) default null,
  subtotal_tax_amount_usdollar decimal(26,6) default null
);

create table aos_quotes_aos_invoices_c (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  aos_quotes77d9_quotes_ida uuid default null,
  aos_quotes6b83nvoices_idb uuid default null
);

create index aos_quotes_aos_invoices_alt on aos_quotes_aos_invoices_c(aos_quotes77d9_quotes_ida,aos_quotes6b83nvoices_idb);

create table aos_quotes_audit (
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

create index idx_aos_quotes_parent_id on aos_quotes_audit(parent_id);

create table aos_quotes_os_contracts_c (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  aos_quotese81e_quotes_ida uuid default null,
  aos_quotes4dc0ntracts_idb uuid default null
);

create index aos_quotes_aos_contracts_alt on aos_quotes_os_contracts_c(aos_quotese81e_quotes_ida,aos_quotes4dc0ntracts_idb);

create table aos_quotes_project_c (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  aos_quotes1112_quotes_ida uuid default null,
  aos_quotes7207project_idb uuid default null
);

create index aos_quotes_project_alt on aos_quotes_project_c(aos_quotes1112_quotes_ida,aos_quotes7207project_idb);

create table aow_actions (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  aow_workflow_id uuid default null,
  action_order int default null,
  action varchar(100) default null,
  parameters text default null
);

create index aow_action_index_workflow_id on aow_actions(aow_workflow_id);

create table aow_conditions (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  aow_workflow_id uuid default null,
  condition_order int default null,
  module_path text default null,
  field varchar(100) default null,
  operator varchar(100) default null,
  value_type varchar(255) default null,
  value varchar(255) default null
);

create index aow_conditions_index_workflow_id on aow_conditions(aow_workflow_id);

create table aow_processed (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  aow_workflow_id uuid default null,
  parent_id uuid default null,
  parent_type varchar(100) default null,
  status varchar(100) default 'pending'
);

create index aow_processed_index_workflow on aow_processed(aow_workflow_id,status,parent_id,deleted);
create index aow_processed_index_status on aow_processed(status);
create index aow_processed_index_workflow_id on aow_processed(aow_workflow_id);

create table aow_processed_aow_actions (
  id uuid primary key,
  aow_processed_id uuid default null,
  aow_action_id uuid default null,
  status varchar(36) default 'pending',
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_aow_processed_aow_actions on aow_processed_aow_actions(aow_processed_id,aow_action_id);
create index idx_actid_del_freid on aow_processed_aow_actions(aow_action_id,deleted,aow_processed_id);

create table aow_workflow (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  flow_module varchar(100) default null,
  flow_run_on varchar(100) default '0',
  status varchar(100) default 'active',
  run_when varchar(100) default 'always',
  multiple_runs boolean default false,
  run_on_import boolean default false
);

create index aow_workflow_index_status on aow_workflow(status);

create table aow_workflow_audit (
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

create index idx_aow_workflow_parent_id on aow_workflow_audit(parent_id);

create table bugs (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  bug_number serial not null,
  type varchar(255) default null,
  status varchar(100) default null,
  priority varchar(100) default null,
  resolution varchar(255) default null,
  work_log text default null,
  found_in_release varchar(255) default null,
  fixed_in_release varchar(255) default null,
  source varchar(255) default null,
  product_category varchar(255) default null
);

create unique index bugsnumk on bugs(bug_number);
create index idx_bug_name on bugs(name);
create index idx_bugs_assigned_user on bugs(assigned_user_id);

create table bugs_audit (
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

create index idx_bugs_parent_id on bugs_audit(parent_id);

create table calls (
  id uuid primary key,
  name varchar(50) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  duration_hours smallint default null,
  duration_minutes smallint default null,
  date_start timestamptz default null,
  date_end timestamptz default null,
  parent_type varchar(255) default null,
  status varchar(100) default 'planned',
  direction varchar(100) default null,
  parent_id uuid default null,
  reminder_time int default -1,
  email_reminder_time int default -1,
  email_reminder_sent boolean default false,
  outlook_id varchar(255) default null,
  repeat_type varchar(36) default null,
  repeat_interval smallint default 1,
  repeat_dow varchar(7) default null,
  repeat_until date default null,
  repeat_count int default null,
  repeat_parent_id uuid default null,
  recurring_source varchar(36) default null
);

create index idx_call_name on calls(name);
create index idx_status on calls (status);
create index idx_calls_date_start on calls(date_start);
create index idx_calls_par_del on calls(parent_id,parent_type,deleted);
create index idx_calls_assigned_del on calls(deleted,assigned_user_id);

create table calls_contacts (
  id uuid primary key,
  call_id uuid default null,
  contact_id uuid default null,
  required varchar(1) default '1',
  accept_status varchar(25) default 'none',
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_con_call_call on calls_contacts(call_id);
create index idx_con_call_con on calls_contacts (contact_id);
create index idx_call_contact on calls_contacts(call_id,contact_id);

create table calls_leads (
  id uuid primary key,
  call_id uuid default null,
  lead_id uuid default null,
  required varchar(1) default '1',
  accept_status varchar(25) default 'none',
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_lead_call_call on calls_leads(call_id);
create index idx_lead_call_lead on calls_leads(lead_id);
create index idx_call_lead on calls_leads(call_id,lead_id);

create table calls_reschedule (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  reason varchar(100) default null,
  call_id uuid default null
);

create table calls_reschedule_audit (
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

create index idx_calls_reschedule_parent_id on calls_reschedule_audit(parent_id);

create table calls_users (
  id uuid primary key,
  call_id uuid default null,
  user_id uuid default null,
  required varchar(1) default '1',
  accept_status varchar(25) default 'none',
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_usr_call_call on calls_users(call_id);
create index idx_usr_call_usr on calls_users(user_id);
create index idx_call_users on calls_users(call_id,user_id);

create table campaign_log (
  id uuid primary key,
  campaign_id uuid default null,
  target_tracker_key uuid default null,
  target_id uuid default null,
  target_type varchar(100) default null,
  activity_type varchar(100) default null,
  activity_date timestamptz default null,
  related_id uuid default null,
  related_type varchar(100) default null,
  archived boolean default false,
  hits int default 0,
  list_id uuid default null,
  deleted boolean default null,
  date_modified timestamptz default null,
  more_information varchar(100) default null,
  marketing_id uuid default null
);

create index idx_camp_tracker on campaign_log(target_tracker_key);
create index idx_camp_campaign_id on campaign_log(campaign_id);
create index idx_camp_more_info on campaign_log(more_information);
create index idx_target_id on campaign_log(target_id);
create index idx_target_id_deleted on campaign_log(target_id,deleted);

create table campaign_trkrs (
  id uuid primary key,
  tracker_name varchar(255) default null,
  tracker_url varchar(255) default 'http://',
  tracker_key serial not null,
  campaign_id uuid default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  is_optout boolean default false,
  deleted boolean default false
);

create index campaign_tracker_key_idx on campaign_trkrs(tracker_key);

create table campaigns (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  tracker_key serial not null,
  tracker_count int default 0,
  refer_url varchar(255) default 'http://',
  tracker_text varchar(255) default null,
  start_date date default null,
  end_date date default null,
  status varchar(100) default null,
  impressions int default 0,
  currency_id uuid default null,
  budget double precision default null,
  expected_cost double precision default null,
  actual_cost double precision default null,
  expected_revenue double precision default null,
  campaign_type varchar(100) default null,
  objective text default null,
  content text default null,
  frequency varchar(100) default null,
  survey_id uuid default null
);

create index camp_auto_tracker_key on campaigns(tracker_key);
create index idx_campaign_name on campaigns(name);
create index idx_survey_id on campaigns(survey_id);

create table campaigns_audit (
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

create index idx_campaigns_parent_id on campaigns_audit(parent_id);

create table cases (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  case_number serial not null,
  type1 varchar(255) default null,
  status varchar(100) default null,
  priority varchar(100) default null,
  resolution text default null,
  work_log text default null,
  account_id uuid default null,
  state varchar(100) default 'open',
  contact_created_by_id uuid default null
);

create unique index casesnumk on cases(case_number);
create index case_number on cases(case_number);
create index idx_case_name on cases(name);
create index idx_account_id on cases(account_id);
create index idx_cases_stat_del on cases(assigned_user_id,status,deleted);

create table cases_audit (
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

create index idx_cases_parent_id on cases_audit(parent_id);

create table cases_bugs (
  id uuid primary key,
  case_id uuid default null,
  bug_id uuid default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_cas_bug_cas on cases_bugs(case_id);
create index idx_cas_bug_bug on cases_bugs(bug_id);
create index idx_case_bug on cases_bugs(case_id,bug_id);

create table cases_cstm (
  id_c uuid primary key,
  jjwg_maps_lng_c float default 0.00000000,
  jjwg_maps_lat_c float default 0.00000000,
  jjwg_maps_geocode_status_c varchar(255) default null,
  jjwg_maps_address_c varchar(255) default null
);

create table config (
  category varchar(32) default null,
  name varchar(32) default null,
  value text default null
);

create index idx_config_cat on config(category);

create table contacts (
  id uuid primary key,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  salutation varchar(255) default null,
  first_name varchar(100) default null,
  last_name varchar(100) default null,
  title varchar(100) default null,
  photo varchar(255) default null,
  department varchar(255) default null,
  do_not_call boolean default false,
  phone_home varchar(100) default null,
  phone_mobile varchar(100) default null,
  phone_work varchar(100) default null,
  phone_other varchar(100) default null,
  phone_fax varchar(100) default null,
  lawful_basis text default null,
  date_reviewed date default null,
  lawful_basis_source varchar(100) default null,
  primary_address_street varchar(150) default null,
  primary_address_city varchar(100) default null,
  primary_address_state varchar(100) default null,
  primary_address_postalcode varchar(20) default null,
  primary_address_country varchar(255) default null,
  alt_address_street varchar(150) default null,
  alt_address_city varchar(100) default null,
  alt_address_state varchar(100) default null,
  alt_address_postalcode varchar(20) default null,
  alt_address_country varchar(255) default null,
  assistant varchar(75) default null,
  assistant_phone varchar(100) default null,
  lead_source varchar(255) default null,
  reports_to_id uuid default null,
  birthdate date default null,
  campaign_id uuid default null,
  joomla_account_id varchar(255) default null,
  portal_account_disabled boolean default null,
  portal_user_type varchar(100) default 'single'
);

create index idx_cont_last_first on contacts(last_name,first_name,deleted);
create index idx_contacts_del_last on contacts(deleted,last_name);
create index idx_cont_del_reports on contacts(deleted,reports_to_id,last_name);
create index idx_reports_to_id on contacts(reports_to_id);
create index idx_del_id_user on contacts(deleted,id,assigned_user_id);
create index idx_cont_assigned on contacts(assigned_user_id);

create table contacts_audit (
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

create index idx_contacts_parent_id on contacts_audit(parent_id);

create table contacts_bugs (
  id uuid primary key,
  contact_id uuid default null,
  bug_id uuid default null,
  contact_role varchar(50) default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_con_bug_con on contacts_bugs(contact_id);
create index idx_con_bug_bug on contacts_bugs(bug_id);
create index idx_contact_bug on contacts_bugs(contact_id,bug_id);

create table contacts_cases (
  id uuid primary key,
  contact_id uuid default null,
  case_id uuid default null,
  contact_role varchar(50) default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_con_case_con on contacts_cases(contact_id);
create index idx_con_case_case on contacts_cases(case_id);
create index idx_contacts_cases on contacts_cases(contact_id,case_id);

create table contacts_cstm (
  id_c uuid primary key,
  jjwg_maps_lng_c float default 0.00000000,
  jjwg_maps_lat_c float default 0.00000000,
  jjwg_maps_geocode_status_c varchar(255) default null,
  jjwg_maps_address_c varchar(255) default null
);

create table contacts_users (
  id uuid primary key,
  contact_id uuid default null,
  user_id uuid default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_con_users_con on contacts_users(contact_id);
create index idx_con_users_user on contacts_users(user_id);
create index idx_contacts_users on contacts_users(contact_id,user_id);

create table cron_remove_documents (
  id uuid primary key,
  bean_id uuid default null,
  module varchar(25) default null,
  date_modified timestamptz default null
);

create index idx_cron_remove_document_bean_id on cron_remove_documents(bean_id);
create index idx_cron_remove_document_stamp on cron_remove_documents(date_modified);

create table currencies (
  id uuid primary key,
  name uuid default null,
  symbol varchar(36) default null,
  iso4217 varchar(3) default null,
  conversion_rate double precision default 0,
  status varchar(100) default null,
  deleted boolean default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  created_by uuid not null
);

create index idx_currency_name on currencies(name,deleted);

create table custom_fields (
  bean_id uuid default null,
  set_num int default 0,
  field0 varchar(255) default null,
  field1 varchar(255) default null,
  field2 varchar(255) default null,
  field3 varchar(255) default null,
  field4 varchar(255) default null,
  field5 varchar(255) default null,
  field6 varchar(255) default null,
  field7 varchar(255) default null,
  field8 varchar(255) default null,
  field9 varchar(255) default null,
  deleted boolean default false
);

create index idx_beanid_set_num on custom_fields(bean_id,set_num);

create table document_revisions (
  id uuid primary key,
  change_log varchar(255) default null,
  document_id uuid default null,
  doc_id varchar(100) default null,
  doc_type varchar(100) default null,
  doc_url varchar(255) default null,
  date_entered timestamptz default null,
  created_by uuid default null,
  filename varchar(255) default null,
  file_ext varchar(100) default null,
  file_mime_type varchar(100) default null,
  revision varchar(100) default null,
  deleted boolean default false,
  date_modified timestamptz default null
);

create index documentrevision_mimetype on document_revisions(file_mime_type);

create table documents (
  id uuid primary key,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  document_name varchar(255) default null,
  doc_id varchar(100) default null,
  doc_type varchar(100) default 'sugar',
  doc_url varchar(255) default null,
  active_date date default null,
  exp_date date default null,
  category_id varchar(100) default null,
  subcategory_id varchar(100) default null,
  status_id varchar(100) default null,
  document_revision_id varchar(36) default null,
  related_doc_id uuid default null,
  related_doc_rev_id uuid default null,
  is_template boolean default false,
  template_type varchar(100) default null
);

create index idx_doc_cat on documents(category_id,subcategory_id);

create table documents_accounts (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  document_id uuid default null,
  account_id uuid default null
);

create index documents_accounts_account_id on documents_accounts(account_id,document_id);
create index documents_accounts_document_id on documents_accounts(document_id,account_id);

create table documents_bugs (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  document_id uuid default null,
  bug_id uuid default null
);

create index documents_bugs_bug_id on documents_bugs(bug_id,document_id);
create index documents_bugs_document_id on documents_bugs(document_id,bug_id);

create table documents_cases (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  document_id uuid default null,
  case_id uuid default null
);

create index documents_cases_case_id on documents_cases(case_id,document_id);
create index documents_cases_document_id on documents_cases(document_id,case_id);

create table documents_contacts (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  document_id uuid default null,
  contact_id uuid default null
);

create index documents_contacts_contact_id on documents_contacts(contact_id,document_id);
create index documents_contacts_document_id on documents_contacts(document_id,contact_id);

create table documents_opportunities (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  document_id uuid default null,
  opportunity_id uuid default null
);

create index idx_docu_opps_oppo_id on documents_opportunities(opportunity_id,document_id);
create index idx_oppo_docu_id on documents_opportunities(document_id,opportunity_id);

create table eapm (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  password varchar(255) default null,
  url varchar(255) default null,
  application varchar(100) default 'webex',
  api_data text default null,
  consumer_key varchar(255) default null,
  consumer_secret varchar(255) default null,
  oauth_token varchar(255) default null,
  oauth_secret varchar(255) default null,
  validated boolean default null
);

create index idx_app_active on eapm(assigned_user_id,application,validated);

create table email_addr_bean_rel (
  id uuid primary key,
  email_address_id uuid not null,
  bean_id uuid not null,
  bean_module varchar(100) default null,
  primary_address boolean default false,
  reply_to_address boolean default false,
  date_created timestamptz default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_email_address_id on email_addr_bean_rel(email_address_id);
create index idx_bean_id on email_addr_bean_rel(bean_id,bean_module);

create table email_addresses (
  id uuid primary key,
  email_address varchar(255) default null,
  email_address_caps varchar(255) default null,
  invalid_email boolean default false,
  opt_out boolean default false,
  confirm_opt_in varchar(255) default 'not-opt-in',
  confirm_opt_in_date timestamptz default null,
  confirm_opt_in_sent_date timestamptz default null,
  confirm_opt_in_fail_date timestamptz default null,
  confirm_opt_in_token varchar(255) default null,
  date_created timestamptz default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_ea_caps_opt_out_invalid on email_addresses(email_address_caps,opt_out,invalid_email);
create index idx_ea_opt_out_invalid on email_addresses(email_address,opt_out,invalid_email);

create table email_addresses_audit (
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

create index idx_email_addresses_parent_id on email_addresses_audit(parent_id);

create table email_cache (
  ie_id uuid default null,
  mbox varchar(60) default null,
  subject varchar(255) default null,
  fromaddr varchar(100) default null,
  toaddr varchar(255) default null,
  senddate timestamptz default null,
  message_id varchar(255) default null,
  mailsize int default null,
  imap_uid int default null,
  msgno int default null,
  recent smallint default null,
  flagged smallint default null,
  answered smallint default null,
  deleted smallint default null,
  seen smallint default null,
  draft smallint default null
);

create index idx_ie_id on email_cache(ie_id);
create index idx_mail_date on email_cache(ie_id,mbox,senddate);
create index idx_mail_from on email_cache(ie_id,mbox,fromaddr);
create index idx_mail_subj on email_cache(subject);
create index idx_mail_to on email_cache(toaddr);

create table email_marketing (
  id uuid primary key,
  deleted boolean default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  name varchar(255) default null,
  from_name varchar(100) default null,
  from_addr varchar(100) default null,
  reply_to_name varchar(100) default null,
  reply_to_addr varchar(100) default null,
  inbound_email_id uuid default null,
  date_start timestamptz default null,
  template_id uuid not null,
  status varchar(100) default null,
  campaign_id uuid default null,
  outbound_email_id uuid default null,
  all_prospect_lists boolean default false
);

create index idx_emmkt_name on email_marketing(name);
create index idx_emmkit_del on email_marketing(deleted);

create table email_marketing_prospect_lists (
  id uuid primary key,
  prospect_list_id uuid default null,
  email_marketing_id uuid default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index email_mp_prospects on email_marketing_prospect_lists(email_marketing_id,prospect_list_id);

create table email_templates (
  id uuid primary key,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  published varchar(3) default null,
  name varchar(255) default null,
  description text default null,
  subject varchar(255) default null,
  body text default null,
  body_html text default null,
  deleted boolean default null,
  assigned_user_id uuid default null,
  text_only boolean default null,
  type varchar(255) default null
);

create index idx_te_name on email_templates(name);

create table emailman (
  id uuid primary key,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  user_id uuid default null,
  campaign_id uuid default null,
  marketing_id uuid default null,
  list_id uuid default null,
  send_date_time timestamptz default null,
  modified_user_id uuid default null,
  in_queue boolean default false,
  in_queue_date timestamptz default null,
  send_attempts int default 0,
  deleted boolean default false,
  related_id uuid default null,
  related_type varchar(100) default null,
  related_confirm_opt_in boolean default false
);

create index idx_eman_list on emailman(list_id,user_id,deleted);
create index idx_eman_campaign_id on emailman(campaign_id);
create index idx_eman_relid_reltype_id on emailman(related_id,related_type,campaign_id);

create table emails (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  orphaned boolean default null,
  last_synced timestamptz default null,
  date_sent_received timestamptz default null,
  message_id varchar(255) default null,
  type varchar(100) default null,
  status varchar(100) default null,
  flagged boolean default null,
  reply_to_status boolean default null,
  intent varchar(100) default 'pick',
  mailbox_id uuid default null,
  parent_type varchar(100) default null,
  parent_id uuid default null,
  uid varchar(255) default null,
  category_id varchar(100) default null
);

create index idx_email_name on emails(name);
create index idx_message_id on emails(message_id);
create index idx_email_parent_id on emails(parent_id);
create index idx_email_assigned on emails(assigned_user_id,type,status);
create index idx_email_cat on emails(category_id);
create index idx_email_uid on emails(uid);

create table emails_beans (
  id uuid primary key,
  email_id uuid default null,
  bean_id uuid default null,
  bean_module varchar(100) default null,
  campaign_data text default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_emails_beans_bean_id on emails_beans(bean_id);
create index idx_emails_beans_email_bean on emails_beans(email_id,bean_id,deleted);

create table emails_email_addr_rel (
  id uuid primary key,
  email_id uuid not null,
  address_type varchar(4) default null,
  email_address_id uuid not null,
  deleted boolean default false
);

create index idx_eearl_email_id on emails_email_addr_rel(email_id,address_type);
create index idx_eearl_address_id on emails_email_addr_rel(email_address_id);

create table emails_text (
  email_id uuid primary key,
  from_addr varchar(250) default null,
  reply_to_addr varchar(250) default null,
  to_addrs text default null,
  cc_addrs text default null,
  bcc_addrs text default null,
  description text default null,
  description_html text default null,
  raw_source text default null,
  deleted boolean default false
);

create index emails_textfromaddr on emails_text(from_addr);

create table external_oauth_connections (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  type varchar(255) default null,
  client_id varchar(32) default null,
  client_secret varchar(32) default null,
  token_type varchar(32) default null,
  expires_in varchar(32) default null,
  access_token text default null,
  refresh_token text default null,
  external_oauth_provider_id char(36) default null
);

create table external_oauth_providers (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  type varchar(255) default null,
  connector varchar(255) default null,
  client_id varchar(255) default null,
  client_secret varchar(255) default null,
  scope text default null,
  url_authorize varchar(255) default null,
  authorize_url_options text default null,
  url_access_token varchar(255) default null,
  extra_provider_params text default null,
  get_token_request_grant varchar(255) default 'authorization_code',
  get_token_request_options text default null,
  refresh_token_request_grant varchar(255) default 'refresh_token',
  refresh_token_request_options text default null,
  access_token_mapping varchar(255) default 'access_token',
  expires_in_mapping varchar(255) default 'expires_in',
  refresh_token_mapping varchar(255) default 'refresh_token',
  token_type_mapping varchar(255) default null
);

create table favorites (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  parent_id uuid default null,
  parent_type varchar(255) default null
);

create table fields_meta_data (
  id varchar(255) not null,
  name varchar(255) default null,
  vname varchar(255) default null,
  comments varchar(255) default null,
  help varchar(255) default null,
  custom_module varchar(255) default null,
  type varchar(255) default null,
  len int default null,
  required boolean default false,
  default_value varchar(255) default null,
  date_modified timestamptz default null,
  deleted boolean default false,
  audited boolean default false,
  massupdate boolean default false,
  duplicate_merge smallint default 0,
  reportable boolean default true,
  importable varchar(255) default null,
  ext1 varchar(255) default null,
  ext2 varchar(255) default null,
  ext3 varchar(255) default null,
  ext4 text default null
);

create index idx_meta_id_del on fields_meta_data(id,deleted);
create index idx_meta_cm_del on fields_meta_data(custom_module,deleted);

create table folders (
  id uuid primary key,
  name varchar(255) default null,
  folder_type varchar(25) default null,
  parent_folder uuid default null,
  has_child boolean default false,
  is_group boolean default false,
  is_dynamic boolean default false,
  dynamic_query text default null,
  assign_to_id uuid default null,
  created_by uuid not null,
  modified_by uuid not null,
  deleted boolean default false
);

create index idx_parent_folder on folders(parent_folder);

create table folders_rel (
  id uuid primary key,
  folder_id uuid not null,
  polymorphic_module varchar(25) default null,
  polymorphic_id uuid not null,
  deleted boolean default false
);

create index idx_poly_module_poly_id on folders_rel(polymorphic_module,polymorphic_id);
create index idx_fr_id_deleted_poly on folders_rel(folder_id,deleted,polymorphic_id);

create table folders_subscriptions (
  id uuid primary key,
  folder_id uuid not null,
  assigned_user_id uuid not null
);

create index idx_folder_id_assigned_user_id on folders_subscriptions(folder_id,assigned_user_id);

create table fp_event_locations (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  address varchar(255) default null,
  address_city varchar(100) default null,
  address_country varchar(100) default null,
  address_postalcode varchar(20) default null,
  address_state varchar(100) default null,
  capacity varchar(255) default null
);

create table fp_event_locations_audit (
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

create index idx_fp_event_locations_parent_id on fp_event_locations_audit(parent_id);

create table fp_event_locations_fp_events_1_c (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  fp_event_locations_fp_events_1fp_event_locations_ida uuid default null,
  fp_event_locations_fp_events_1fp_events_idb uuid default null
);

create index fp_event_locations_fp_events_1_ida1 on fp_event_locations_fp_events_1_c(fp_event_locations_fp_events_1fp_event_locations_ida);
create index fp_event_locations_fp_events_1_alt on fp_event_locations_fp_events_1_c(fp_event_locations_fp_events_1fp_events_idb);

create table fp_events (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  duration_hours smallint default null,
  duration_minutes smallint default null,
  date_start timestamptz default null,
  date_end timestamptz default null,
  budget decimal(26,6) default null,
  currency_id uuid default null,
  invite_templates varchar(100) default null,
  accept_redirect varchar(255) default null,
  decline_redirect varchar(255) default null,
  activity_status_type varchar(255) default null
);

create table fp_events_audit (
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

create index idx_fp_events_parent_id on fp_events_audit(parent_id);

create table fp_events_contacts_c (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  fp_events_contactsfp_events_ida uuid default null,
  fp_events_contactscontacts_idb uuid default null,
  invite_status varchar(25) default 'not invited',
  accept_status varchar(25) default 'no response',
  email_responded smallint default 0
);

create index fp_events_contacts_alt on fp_events_contacts_c(fp_events_contactsfp_events_ida,fp_events_contactscontacts_idb);

create table fp_events_fp_event_delegates_1_c (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  fp_events_fp_event_delegates_1fp_events_ida uuid default null,
  fp_events_fp_event_delegates_1fp_event_delegates_idb uuid default null
);

create index fp_events_fp_event_delegates_1_ida1 on fp_events_fp_event_delegates_1_c(fp_events_fp_event_delegates_1fp_events_ida);
create index fp_events_fp_event_delegates_1_alt on fp_events_fp_event_delegates_1_c(fp_events_fp_event_delegates_1fp_event_delegates_idb);

create table fp_events_fp_event_locations_1_c (
  id uuid not null,
  date_modified timestamptz default null,
  deleted boolean default false,
  fp_events_fp_event_locations_1fp_events_ida uuid default null,
  fp_events_fp_event_locations_1fp_event_locations_idb uuid default null
);

create index fp_events_fp_event_locations_1_alt on fp_events_fp_event_locations_1_c(
  fp_events_fp_event_locations_1fp_events_ida,fp_events_fp_event_locations_1fp_event_locations_idb
);

create table fp_events_leads_1_c (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  fp_events_leads_1fp_events_ida uuid default null,
  fp_events_leads_1leads_idb uuid default null,
  invite_status varchar(25) default 'not invited',
  accept_status varchar(25) default 'no response',
  email_responded smallint default 0
);

create index fp_events_leads_1_alt on fp_events_leads_1_c(fp_events_leads_1fp_events_ida,fp_events_leads_1leads_idb);

create table fp_events_prospects_1_c (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  fp_events_prospects_1fp_events_ida uuid default null,
  fp_events_prospects_1prospects_idb uuid default null,
  invite_status varchar(25) default 'not invited',
  accept_status varchar(25) default 'no response',
  email_responded smallint default 0
);

create index fp_events_prospects_1_alt on fp_events_prospects_1_c(fp_events_prospects_1fp_events_ida,fp_events_prospects_1prospects_idb);

create table import_maps (
  id uuid primary key,
  name varchar(254) default null,
  source varchar(36) default null,
  enclosure varchar(1) default ' ',
  delimiter varchar(1) default ',',
  module varchar(36) default null,
  content text default null,
  default_values text default null,
  has_header boolean default true,
  deleted boolean default false,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  assigned_user_id uuid default null,
  is_published varchar(3) default 'no'
);

create index idx_owner_module_name on import_maps(assigned_user_id,module,name,deleted);

create table inbound_email (
  id uuid primary key,
  deleted boolean default false,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  name varchar(255) default null,
  status varchar(100) default 'active',
  server_url varchar(100) default null,
  connection_string varchar(255) default null,
  email_user varchar(100) default null,
  email_password varchar(100) default null,
  port int default 143,
  service varchar(50) default null,
  mailbox text default null,
  sentfolder varchar(255) default null,
  trashfolder varchar(255) default null,
  delete_seen boolean default false,
  move_messages_to_trash_after_import boolean default false,
  mailbox_type varchar(10) default null,
  template_id uuid default null,
  stored_options text default null,
  group_id uuid default null,
  is_personal boolean default false,
  groupfolder_id uuid default null,
  type varchar(255) default null,
  auth_type varchar(255) default 'basic',
  protocol varchar(255) default 'imap',
  is_ssl boolean default false,
  distribution_user_id uuid default null,
  outbound_email_id uuid default null,
  create_case_template_id uuid default null,
  external_oauth_connection_id uuid default null
);

create table inbound_email_autoreply (
  id uuid primary key,
  deleted boolean default false,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  autoreplied_to varchar(100) default null,
  ie_id uuid
);

create index idx_ie_autoreplied_to on inbound_email_autoreply(autoreplied_to);

create table inbound_email_cache_ts (
  id uuid primary key,
  ie_timestamp bigint default null
);

create table jjwg_address_cache (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  lat float default null,
  lng float default null
);

create table jjwg_address_cache_audit (
  id uuid primary key,
  parent_id uuid not null,
  date_created timestamptz default null,
  created_by varchar(36) default null,
  field_name varchar(100) default null,
  data_type varchar(100) default null,
  before_value_string varchar(255) default null,
  after_value_string varchar(255) default null,
  before_value_text text default null,
  after_value_text text default null
);

create index idx_jjwg_address_cache_parent_id on jjwg_address_cache_audit(parent_id);

create table jjwg_areas (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  city varchar(255) default null,
  state varchar(255) default null,
  country varchar(255) default null,
  coordinates text default null
);

create table jjwg_areas_audit (
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

create index idx_jjwg_areas_parent_id on jjwg_areas_audit(parent_id);

create table jjwg_maps (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  distance float default null,
  unit_type varchar(100) default 'mi',
  module_type varchar(100) default 'accounts',
  parent_type varchar(255) default null,
  parent_id uuid default null
);

create table jjwg_maps_audit (
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

create index idx_jjwg_maps_parent_id on jjwg_maps_audit(parent_id);

create table jjwg_maps_jjwg_areas_c (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  jjwg_maps_5304wg_maps_ida uuid default null,
  jjwg_maps_41f2g_areas_idb uuid default null
);

create index jjwg_maps_jjwg_areas_alt on jjwg_maps_jjwg_areas_c(jjwg_maps_5304wg_maps_ida,jjwg_maps_41f2g_areas_idb);

create table jjwg_maps_jjwg_markers_c (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  jjwg_maps_b229wg_maps_ida uuid default null,
  jjwg_maps_2e31markers_idb uuid default null
);

create index jjwg_maps_jjwg_markers_alt on jjwg_maps_jjwg_markers_c(jjwg_maps_b229wg_maps_ida,jjwg_maps_2e31markers_idb);

create table jjwg_markers (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  city varchar(255) default null,
  state varchar(255) default null,
  country varchar(255) default null,
  jjwg_maps_lat float default 0.00000000,
  jjwg_maps_lng float default 0.00000000,
  marker_image varchar(100) default 'company'
);

create table jjwg_markers_audit (
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

create index idx_jjwg_markers_parent_id on jjwg_markers_audit(parent_id);

create table job_queue (
  id uuid primary key,
  assigned_user_id uuid default null,
  name varchar(255) default null,
  deleted boolean default false,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  scheduler_id uuid default null,
  execute_time timestamptz default null,
  status varchar(20) default null,
  resolution varchar(20) default null,
  message text default null,
  target varchar(255) default null,
  data text default null,
  requeue boolean default false,
  retry_count smallint default null,
  failure_count smallint default null,
  job_delay int default null,
  client varchar(255) default null,
  percent_complete int default null
);

create index idx_status_scheduler on job_queue(status,scheduler_id);
create index idx_status_time on job_queue(status,execute_time,date_entered);
create index idx_status_entered on job_queue(status,date_entered);
create index idx_status_modified on job_queue(status,date_modified);

create table leads (
  id uuid primary key,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  salutation varchar(255) default null,
  first_name varchar(100) default null,
  last_name varchar(100) default null,
  title varchar(100) default null,
  photo varchar(255) default null,
  department varchar(100) default null,
  do_not_call boolean default false,
  phone_home varchar(100) default null,
  phone_mobile varchar(100) default null,
  phone_work varchar(100) default null,
  phone_other varchar(100) default null,
  phone_fax varchar(100) default null,
  lawful_basis text default null,
  date_reviewed date default null,
  lawful_basis_source varchar(100) default null,
  primary_address_street varchar(150) default null,
  primary_address_city varchar(100) default null,
  primary_address_state varchar(100) default null,
  primary_address_postalcode varchar(20) default null,
  primary_address_country varchar(255) default null,
  alt_address_street varchar(150) default null,
  alt_address_city varchar(100) default null,
  alt_address_state varchar(100) default null,
  alt_address_postalcode varchar(20) default null,
  alt_address_country varchar(255) default null,
  assistant varchar(75) default null,
  assistant_phone varchar(100) default null,
  converted boolean default false,
  refered_by varchar(100) default null,
  lead_source varchar(100) default null,
  lead_source_description text default null,
  status varchar(100) default null,
  status_description text default null,
  reports_to_id uuid default null,
  account_name varchar(255) default null,
  account_description text default null,
  contact_id uuid default null,
  account_id uuid default null,
  opportunity_id uuid default null,
  opportunity_name varchar(255) default null,
  opportunity_amount varchar(50) default null,
  campaign_id uuid default null,
  birthdate date default null,
  portal_name varchar(255) default null,
  portal_app varchar(255) default null,
  website varchar(255) default null
);

create index idx_lead_acct_name_first on leads(account_name,deleted);
create index idx_lead_last_first on leads(last_name,first_name,deleted);
create index idx_lead_del_stat on leads(last_name,status,deleted,first_name);
create index idx_lead_opp_del on leads(opportunity_id,deleted);
create index idx_leads_acct_del on leads(account_id,deleted);
create index idx_del_user on leads(deleted,assigned_user_id);
create index idx_lead_assigned on leads(assigned_user_id);
create index idx_lead_contact on leads(contact_id);
create index idx_reports_to on leads(reports_to_id);
create index idx_lead_phone_work on leads(phone_work);
create index idx_leads_id_del on leads(id,deleted);

create table leads_audit (
  id uuid primary key,
  parent_id uuid,
  date_created timestamptz default null,
  created_by uuid default null,
  field_name varchar(100) default null,
  data_type varchar(100) default null,
  before_value_string varchar(255) default null,
  after_value_string varchar(255) default null,
  before_value_text text default null,
  after_value_text text default null
);

create index idx_leads_parent_id on leads_audit(parent_id);

create table leads_cstm (
  id_c uuid primary key,
  jjwg_maps_lng_c float default 0.00000000,
  jjwg_maps_lat_c float default 0.00000000,
  jjwg_maps_geocode_status_c varchar(255) default null,
  jjwg_maps_address_c varchar(255) default null
);

create table linked_documents (
  id uuid primary key,
  parent_id uuid default null,
  parent_type varchar(25) default null,
  document_id uuid default null,
  document_revision_id uuid default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_parent_document on linked_documents(parent_type,parent_id,document_id);

create table meetings (
  id uuid primary key,
  name varchar(50) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  location varchar(50) default null,
  password varchar(50) default null,
  join_url varchar(200) default null,
  host_url varchar(400) default null,
  displayed_url varchar(400) default null,
  creator varchar(50) default null,
  external_id varchar(50) default null,
  duration_hours smallint default null,
  duration_minutes smallint default null,
  date_start timestamptz default null,
  date_end timestamptz default null,
  parent_type varchar(100) default null,
  status varchar(100) default 'planned',
  type varchar(255) default 'sugar',
  parent_id uuid default null,
  reminder_time int default -1,
  email_reminder_time int default -1,
  email_reminder_sent boolean default false,
  outlook_id varchar(255) default null,
  sequence int default 0,
  repeat_type varchar(36) default null,
  repeat_interval int default 1,
  repeat_dow varchar(7) default null,
  repeat_until date default null,
  repeat_count int default null,
  repeat_parent_id uuid default null,
  recurring_source varchar(36) default null,
  gsync_id varchar(1024) default null,
  gsync_lastsync int default null
);

create index idx_mtg_name on meetings(name);
create index idx_meet_par_del on meetings(parent_id,parent_type,deleted);
create index idx_meet_stat_del on meetings(assigned_user_id,status,deleted);
create index idx_meet_date_start on meetings(date_start);

create table meetings_contacts (
  id uuid primary key,
  meeting_id uuid default null,
  contact_id uuid default null,
  required varchar(1) default '1',
  accept_status varchar(25) default 'none',
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_con_mtg_mtg on meetings_contacts(meeting_id);
create index idx_con_mtg_con on meetings_contacts(contact_id);
create index idx_meeting_contact on meetings_contacts(meeting_id,contact_id);

create table meetings_cstm (
  id_c uuid primary key,
  jjwg_maps_lng_c float default 0.00000000,
  jjwg_maps_lat_c float default 0.00000000,
  jjwg_maps_geocode_status_c varchar(255) default null,
  jjwg_maps_address_c varchar(255) default null
);

create table meetings_leads (
  id uuid primary key,
  meeting_id uuid default null,
  lead_id uuid default null,
  required varchar(1) default '1',
  accept_status varchar(25) default 'none',
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_lead_meeting_meeting on meetings_leads(meeting_id);
create index idx_lead_meeting_lead on meetings_leads(lead_id);
create index idx_meeting_lead on meetings_leads(meeting_id,lead_id);

create table meetings_users (
  id uuid primary key,
  meeting_id uuid default null,
  user_id uuid default null,
  required varchar(1) default '1',
  accept_status varchar(25) default 'none',
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_usr_mtg_mtg on meetings_users(meeting_id);
create index idx_usr_mtg_usr on meetings_users(user_id);
create index idx_meeting_users on meetings_users(meeting_id,user_id);

create table notes (
  id uuid primary key,
  assigned_user_id uuid default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  name varchar(255) default null,
  file_mime_type varchar(100) default null,
  filename varchar(255) default null,
  parent_type varchar(255) default null,
  parent_id uuid default null,
  contact_id uuid default null,
  portal_flag boolean default null,
  embed_flag boolean default false,
  description text default null,
  deleted boolean default false
);

create index idx_note_name on notes(name);
create index idx_notes_parent on notes(parent_id,parent_type);
create index idx_note_contact on notes(contact_id);
create index idx_notes_assigned_del on notes(deleted,assigned_user_id);

create table oauth2clients (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  secret varchar(4000) default null,
  redirect_url varchar(255) default null,
  is_confidential boolean default true,
  allowed_grant_type varchar(255) default 'password',
  duration_value int default null,
  duration_amount int default null,
  duration_unit varchar(255) default 'duration unit',
  assigned_user_id uuid default null
);

create table oauth2tokens (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  token_is_revoked boolean default null,
  token_type varchar(255) default null,
  access_token_expires timestamptz default null,
  access_token varchar(4000) default null,
  refresh_token varchar(4000) default null,
  refresh_token_expires timestamptz default null,
  grant_type varchar(255) default null,
  state varchar(1024) default null,
  client uuid default null,
  assigned_user_id uuid default null
);

create table oauth_consumer (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  c_key varchar(255) default null,
  c_secret varchar(255) default null
);

create unique index ckey on oauth_consumer(c_key);

create table oauth_nonce (
  conskey varchar(32) not null,
  nonce varchar(32) not null,
  nonce_ts bigint default null
);

alter table oauth_nonce add primary key(conskey, nonce);
create index oauth_nonce_keyts on oauth_nonce(conskey,nonce_ts);

create table oauth_tokens (
  id uuid not null,
  secret varchar(32) default null,
  tstate varchar(1) default null,
  consumer uuid not null,
  token_ts bigint default null,
  verify varchar(32) default null,
  deleted boolean not null default true,
  callback_url varchar(255) default null,
  assigned_user_id uuid default null
);

alter table oauth_tokens add primary key (id,deleted);
create index oauth_state_ts on oauth_tokens(tstate,token_ts);
create index constoken_key on oauth_tokens(consumer);

create table opportunities (
  id uuid primary key,
  name varchar(50) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  opportunity_type varchar(255) default null,
  campaign_id uuid default null,
  lead_source varchar(50) default null,
  amount double precision default null,
  amount_usdollar double precision default null,
  currency_id uuid default null,
  date_closed date default null,
  next_step varchar(100) default null,
  sales_stage varchar(255) default null,
  probability double precision default null
);

create index idx_opp_name on opportunities(name);
create index idx_opp_assigned on opportunities(assigned_user_id);
create index idx_opp_id_deleted on opportunities(id,deleted);

create table opportunities_audit (
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

create index idx_opportunities_parent_id on opportunities_audit(parent_id);

create table opportunities_contacts (
  id uuid primary key,
  contact_id uuid default null,
  opportunity_id uuid default null,
  contact_role varchar(50) default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_con_opp_con on opportunities_contacts(contact_id);
create index idx_con_opp_opp on opportunities_contacts(opportunity_id);
create index idx_opportunities_contacts on opportunities_contacts(opportunity_id,contact_id);

create table opportunities_cstm (
  id_c uuid primary key,
  jjwg_maps_lng_c float default 0.00000000,
  jjwg_maps_lat_c float default 0.00000000,
  jjwg_maps_geocode_status_c varchar(255) default null,
  jjwg_maps_address_c varchar(255) default null
);

create table outbound_email (
  id uuid primary key,
  name varchar(255) default null,
  type varchar(15) default 'user',
  user_id uuid default null,
  smtp_from_name varchar(255) default null,
  smtp_from_addr varchar(255) default null,
  reply_to_name varchar(255) default null,
  reply_to_addr varchar(255) default null,
  signature text default null,
  mail_sendtype varchar(8) default 'smtp',
  mail_smtptype varchar(20) default 'other',
  mail_smtpserver varchar(100) default null,
  mail_smtpport varchar(5) default '25',
  mail_smtpuser varchar(100) default null,
  mail_smtppass varchar(100) default null,
  mail_smtpauth_req boolean default false,
  mail_smtpssl varchar(1) default '0',
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  deleted boolean default false,
  assigned_user_id uuid default null
);

create table outbound_email_audit (
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

create index idx_outbound_email_parent_id on outbound_email_audit(parent_id);

create table project (
  id uuid primary key,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  assigned_user_id uuid default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  name varchar(50) default null,
  description text default null,
  deleted boolean default false,
  estimated_start_date date default null,
  estimated_end_date date default null,
  status varchar(255) default null,
  priority varchar(255) default null,
  override_business_hours boolean default false
);

create table project_contacts_1_c (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  project_contacts_1project_ida varchar(36) default null,
  project_contacts_1contacts_idb varchar(36) default null
);

create index project_contacts_1_alt on project_contacts_1_c(project_contacts_1project_ida,project_contacts_1contacts_idb);

create table project_cstm (
  id_c uuid primary key,
  jjwg_maps_lng_c float default 0.00000000,
  jjwg_maps_lat_c float default 0.00000000,
  jjwg_maps_geocode_status_c varchar(255) default null,
  jjwg_maps_address_c varchar(255) default null
);

create table project_task (
  id uuid primary key,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  project_id uuid not null,
  project_task_id int default null,
  name varchar(50) default null,
  status varchar(255) default null,
  relationship_type varchar(255) default null,
  description text default null,
  predecessors text default null,
  date_start date default null,
  time_start int default null,
  time_finish int default null,
  date_finish date default null,
  duration int default null,
  duration_unit text default null,
  actual_duration int default null,
  percent_complete int default null,
  date_due date default null,
  time_due time default null,
  parent_task_id int default null,
  assigned_user_id uuid default null,
  modified_user_id uuid default null,
  priority varchar(255) default null,
  created_by uuid default null,
  milestone_flag boolean default null,
  order_number int default 1,
  task_number int default null,
  estimated_effort int default null,
  actual_effort int default null,
  deleted boolean default false,
  utilization int default 100
);

create table project_task_audit (
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

create index idx_project_task_parent_id on project_task_audit(parent_id);

create table project_users_1_c (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  project_users_1project_ida uuid default null,
  project_users_1users_idb uuid default null
);

create index project_users_1_alt on project_users_1_c(project_users_1project_ida,project_users_1users_idb);

create table projects_accounts (
  id uuid primary key,
  account_id uuid default null,
  project_id uuid default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_proj_acct_proj on projects_accounts(project_id);
create index idx_proj_acct_acct on projects_accounts(account_id);
create index projects_accounts_alt on projects_accounts (project_id,account_id);

create table projects_bugs (
  id uuid primary key,
  bug_id uuid default null,
  project_id uuid default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_proj_bug_proj on projects_bugs(project_id);
create index idx_proj_bug_bug on projects_bugs(bug_id);
create index projects_bugs_alt on projects_bugs(project_id,bug_id);

create table projects_cases (
  id uuid primary key,
  case_id uuid default null,
  project_id uuid default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_proj_case_proj on projects_cases(project_id);
create index idx_proj_case_case on projects_cases(case_id);
create index projects_cases_alt on projects_cases(project_id,case_id);

create table projects_contacts (
  id uuid primary key,
  contact_id uuid default null,
  project_id uuid default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_proj_con_proj on projects_contacts(project_id);
create index idx_proj_con_con on projects_contacts(contact_id);
create index projects_contacts_alt on projects_contacts(project_id,contact_id);

create table projects_opportunities (
  id uuid primary key,
  opportunity_id uuid default null,
  project_id uuid default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_proj_opp_proj on projects_opportunities(project_id);
create index idx_proj_opp_opp on projects_opportunities(opportunity_id);
create index projects_opportunities_alt on projects_opportunities(project_id,opportunity_id);

create table projects_products (
  id uuid primary key,
  product_id uuid default null,
  project_id uuid default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_proj_prod_project on projects_products(project_id);
create index idx_proj_prod_product on projects_products(product_id);
create index projects_products_alt on projects_products(project_id,product_id);

create table prospect_list_campaigns (
  id uuid primary key,
  prospect_list_id uuid default null,
  campaign_id uuid default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_pro_id on prospect_list_campaigns(prospect_list_id);
create index idx_cam_id on prospect_list_campaigns(campaign_id);
create index idx_prospect_list_campaigns on prospect_list_campaigns(prospect_list_id,campaign_id);

create table prospect_lists (
  id uuid primary key,
  assigned_user_id uuid default null,
  name varchar(255) default null,
  list_type varchar(100) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  deleted boolean default null,
  description text default null,
  domain_name varchar(255) default null
);

create index idx_prospect_list_name on prospect_lists(name);

create table prospect_lists_prospects (
  id uuid primary key,
  prospect_list_id uuid default null,
  related_id uuid default null,
  related_type varchar(25) default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_plp_pro_id on prospect_lists_prospects(prospect_list_id,deleted);
create index idx_plp_rel_id on prospect_lists_prospects(related_id,related_type,prospect_list_id);

create table prospects (
  id uuid primary key,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  salutation varchar(255) default null,
  first_name varchar(100) default null,
  last_name varchar(100) default null,
  title varchar(100) default null,
  photo varchar(255) default null,
  department varchar(255) default null,
  do_not_call boolean default false,
  phone_home varchar(100) default null,
  phone_mobile varchar(100) default null,
  phone_work varchar(100) default null,
  phone_other varchar(100) default null,
  phone_fax varchar(100) default null,
  lawful_basis text default null,
  date_reviewed date default null,
  lawful_basis_source varchar(100) default null,
  primary_address_street varchar(150) default null,
  primary_address_city varchar(100) default null,
  primary_address_state varchar(100) default null,
  primary_address_postalcode varchar(20) default null,
  primary_address_country varchar(255) default null,
  alt_address_street varchar(150) default null,
  alt_address_city varchar(100) default null,
  alt_address_state varchar(100) default null,
  alt_address_postalcode varchar(20) default null,
  alt_address_country varchar(255) default null,
  assistant varchar(75) default null,
  assistant_phone varchar(100) default null,
  tracker_key serial not null,
  birthdate date default null,
  lead_id uuid default null,
  account_name varchar(150) default null,
  campaign_id uuid default null
);

create index prospect_auto_tracker_key on prospects(tracker_key);
create index idx_prospects_last_first on prospects(last_name,first_name,deleted);
create index idx_prospecs_del_last on prospects(last_name,deleted);
create index idx_prospects_id_del on prospects(id,deleted);
create index idx_prospects_assigned on prospects(assigned_user_id);

create table prospects_cstm (
  id_c uuid primary key,
  jjwg_maps_lng_c float default 0.00000000,
  jjwg_maps_lat_c float default 0.00000000,
  jjwg_maps_geocode_status_c varchar(255) default null,
  jjwg_maps_address_c varchar(255) default null
);

create table relationships (
  id uuid primary key,
  relationship_name varchar(150) default null,
  lhs_module varchar(100) default null,
  lhs_table varchar(64) default null,
  lhs_key varchar(64) default null,
  rhs_module varchar(100) default null,
  rhs_table varchar(64) default null,
  rhs_key varchar(64) default null,
  join_table varchar(64) default null,
  join_key_lhs varchar(64) default null,
  join_key_rhs varchar(64) default null,
  relationship_type varchar(64) default null,
  relationship_role_column varchar(64) default null,
  relationship_role_column_value varchar(50) default null,
  reverse boolean default false,
  deleted boolean default false
);

create index idx_rel_name on relationships(relationship_name);

create table releases (
  id uuid primary key,
  deleted boolean default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  name varchar(50) default null,
  list_order int default null,
  status varchar(100) default null
);

create index idx_releases on releases(name,deleted);

create table reminders (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  popup boolean default null,
  email boolean default null,
  email_sent boolean default null,
  timer_popup varchar(32) default null,
  timer_email varchar(32) default null,
  related_event_module varchar(32) default null,
  related_event_module_id uuid not null,
  date_willexecute int default -1,
  popup_viewed boolean default false
);

create index idx_reminder_name on reminders(name);
create index idx_reminder_deleted on reminders(deleted);
create index idx_reminder_related_event_module on reminders(related_event_module);
create index idx_reminder_related_event_module_id on reminders(related_event_module_id);

create table reminders_invitees (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  reminder_id uuid not null,
  related_invitee_module varchar(32) default null,
  related_invitee_module_id uuid not null
);

create index idx_reminder_invitee_name on reminders_invitees(name);
create index idx_reminder_invitee_assigned_user_id on reminders_invitees(assigned_user_id);
create index idx_reminder_invitee_reminder_id on reminders_invitees(reminder_id);
create index idx_reminder_invitee_related_invitee_module on reminders_invitees(related_invitee_module);
create index idx_reminder_invitee_related_invitee_module_id on reminders_invitees(related_invitee_module_id);

create table roles (
  id uuid primary key,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  name varchar(150) default null,
  description text default null,
  modules text default null,
  deleted boolean default null
);

create index idx_role_id_del on roles(id,deleted);

create table roles_modules (
  id uuid primary key,
  role_id uuid default null,
  module_id uuid default null,
  allow boolean default false,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_role_id on roles_modules(role_id);
create index idx_module_id on roles_modules(module_id);

create table roles_users (
  id uuid primary key,
  role_id uuid default null,
  user_id uuid default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_ru_role_id on roles_users(role_id);
create index idx_ru_user_id on roles_users(user_id);

create table saved_search (
  id uuid primary key,
  name varchar(150) default null,
  search_module varchar(150) default null,
  deleted boolean default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  assigned_user_id uuid default null,
  contents text default null,
  description text default null
);

create index idx_desc on saved_search(name,deleted);

create table schedulers (
  id uuid primary key,
  deleted boolean default false,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  created_by uuid default null,
  modified_user_id uuid default null,
  name varchar(255) default null,
  job varchar(255) default null,
  date_time_start timestamptz default null,
  date_time_end timestamptz default null,
  job_interval varchar(100) default null,
  time_from time default null,
  time_to time default null,
  last_run timestamptz default null,
  status varchar(100) default null,
  catch_up boolean default true
);

create index idx_schedule on schedulers(date_time_start,deleted);

create table securitygroups (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  noninheritable boolean default null
);

create table securitygroups_acl_roles (
  id uuid primary key,
  securitygroup_id uuid default null,
  role_id uuid default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create table securitygroups_audit (
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

create index idx_securitygroups_parent_id on securitygroups_audit(parent_id);

create table securitygroups_default (
  id uuid primary key,
  securitygroup_id uuid default null,
  module varchar(50) default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create table securitygroups_records (
  id uuid primary key,
  securitygroup_id uuid default null,
  record_id uuid default null,
  module varchar(100) default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  deleted boolean default false
);

create index idx_securitygroups_records_mod on securitygroups_records(module,deleted,record_id,securitygroup_id);
create index idx_securitygroups_records_del on securitygroups_records(deleted,record_id,module,securitygroup_id);

create table securitygroups_users (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  securitygroup_id uuid default null,
  user_id uuid default null,
  primary_group boolean default null,
  noninheritable boolean default false
);

create index securitygroups_users_idxa on securitygroups_users(securitygroup_id);
create index securitygroups_users_idxb on securitygroups_users(user_id);
create index securitygroups_users_idxc on securitygroups_users(user_id,deleted,securitygroup_id,id);
create index securitygroups_users_idxd on securitygroups_users(user_id,deleted,securitygroup_id);

create table sugarfeed (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  related_module varchar(100) default null,
  related_id uuid default null,
  link_url varchar(255) default null,
  link_type varchar(30) default null
);

create index sgrfeed_date on sugarfeed(date_entered,deleted);

create table surveyquestionoptions (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  sort_order int default null,
  survey_question_id uuid default null
);

create table surveyquestionoptions_audit (
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

create index idx_surveyquestionoptions_parent_id on surveyquestionoptions_audit(parent_id);

create table surveyquestionoptions_surveyquestionresponses (
  id uuid primary key,
  date_modified timestamptz default null,
  deleted boolean default false,
  surveyq72c7options_ida uuid default null,
  surveyq10d4sponses_idb uuid default null
);

create index surveyquestionoptions_surveyquestionresponses_alt on surveyquestionoptions_surveyquestionresponses
(surveyq72c7options_ida,surveyq10d4sponses_idb);

create table surveyquestionresponses (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  answer text default null,
  answer_bool boolean default null,
  answer_datetime timestamptz default null,
  surveyquestion_id uuid default null,
  surveyresponse_id uuid default null
);

create table surveyquestionresponses_audit (
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

create index idx_surveyquestionresponses_parent_id on surveyquestionresponses_audit(parent_id);

create table surveyquestions (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  sort_order int default null,
  type varchar(100) default null,
  happiness_question boolean default null,
  survey_id char(36) default null
);

create table surveyquestions_audit (
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

create index idx_surveyquestions_parent_id on surveyquestions_audit(parent_id);

create table surveyresponses (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  happiness int default null,
  email_response_sent boolean default null,
  account_id uuid default null,
  campaign_id uuid default null,
  contact_id uuid default null,
  survey_id uuid default null
);

create table surveyresponses_audit (
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

create index idx_surveyresponses_parent_id on surveyresponses_audit(parent_id);;

create table surveys (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  status varchar(100) default 'lbl_draft',
  submit_text varchar(255) default 'submit',
  satisfied_text varchar(255) default 'satisfied',
  neither_text varchar(255) default 'neither satisfied nor dissatisfied',
  dissatisfied_text varchar(255) default 'dissatisfied'
);

create table surveys_audit (
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

create index idx_surveys_parent_id on surveys_audit(parent_id);

create table tasks (
  id uuid primary key,
  name varchar(50) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  assigned_user_id uuid default null,
  status varchar(100) default 'not started',
  date_due_flag boolean default false,
  date_due timestamptz default null,
  date_start_flag boolean default false,
  date_start timestamptz default null,
  parent_type varchar(255) default null,
  parent_id uuid default null,
  contact_id uuid default null,
  priority varchar(100) default null
);

create index idx_tsk_name on tasks(name);
create index idx_task_con_del on tasks(contact_id,deleted);
create index idx_task_par_del on tasks(parent_id,parent_type,deleted);
create index idx_task_assigned on tasks(assigned_user_id);
create index idx_task_status on tasks(status);

create table templatesectionline (
  id uuid primary key,
  name varchar(255) default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  modified_user_id uuid default null,
  created_by uuid default null,
  description text default null,
  deleted boolean default false,
  thumbnail varchar(255) default null,
  grp varchar(255) default null,
  ord int default null
);

create table tracker (
  id bigserial primary key,
  monitor_id uuid not null,
  user_id uuid default null,
  module_name varchar(255) default null,
  item_id varchar(36) default null,
  item_summary varchar(255) default null,
  date_modified timestamptz default null,
  action varchar(255) default null,
  session_id varchar(36) default null,
  visible boolean default false,
  deleted boolean default false
);

create index idx_tracker_iid on tracker(item_id);
create index idx_tracker_userid_vis_id on tracker(user_id,visible,id);
create index idx_tracker_userid_itemid_vis on tracker(user_id,item_id,visible);
create index idx_tracker_monitor_id on tracker(monitor_id);
create index idx_tracker_date_modified on tracker(date_modified);

create table upgrade_history (
  id uuid primary key,
  filename varchar(255) default null,
  md5sum varchar(32) default null,
  type varchar(30) default null,
  status varchar(50) default null,
  version varchar(64) default null,
  name varchar(255) default null,
  description text default null,
  id_name varchar(255) default null,
  manifest text default null,
  date_entered timestamptz default null,
  enabled boolean default true
);

create  unique index upgrade_history_md5_uk on upgrade_history(md5sum);

create table user_preferences (
  id uuid primary key,
  category varchar(50) default null,
  deleted boolean default false,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  assigned_user_id uuid default null,
  contents text default null
);

create index idx_userprefnamecat on user_preferences(assigned_user_id,category);

create table users (
  id uuid primary key,
  email varchar(255) not null,
  username varchar(64) not null,
  password_hash varchar(255) not null,
  system_generated_password boolean default null,
  pwd_last_changed timestamptz default null,
  authenticate_id varchar(100) default null,
  sugar_login boolean default true,
  first_name varchar(255) default '',
  last_name varchar(255) default '',
  is_admin boolean default false,
  external_auth_only boolean default false,
  receive_notifications boolean default true,
  description text default null,
  created_date timestamptz default now(),
  modified_date timestamptz default now(),
  modified_user_id uuid default null,
  created_by uuid default null,
  title varchar(50) default null,
  photo varchar(255) default null,
  department varchar(50) default null,
  phone_home varchar(50) default null,
  phone_mobile varchar(50) default null,
  phone_work varchar(50) default null,
  phone_other varchar(50) default null,
  phone_fax varchar(50) default null,
  status varchar(100) default null,
  address_street varchar(150) default null,
  address_city varchar(100) default null,
  address_state varchar(100) default null,
  address_country varchar(100) default null,
  address_postalcode varchar(20) default null,
  deleted boolean default null,
  portal_only boolean default false,
  show_on_employees boolean default true,
  employee_status varchar(100) default null,
  messenger_id varchar(100) default null,
  messenger_type varchar(100) default null,
  reports_to_id uuid default null,
  is_group boolean default null,
  factor_auth boolean default null,
  factor_auth_interface varchar(255) default null
);

create unique index users_username on users(username);
create unique index users_email on users(email);
create index idx_user_name on users(user_name,is_group,status,last_name,first_name,id);

create table users_feeds (
  user_id uuid default null,
  feed_id uuid default null,
  rank int default null,
  date_modified timestamptz default null,
  deleted boolean default false
);

create index idx_ud_user_id on users_feeds(user_id,feed_id);

create table users_last_import (
  id uuid primary key,
  assigned_user_id uuid default null,
  import_module varchar(36) default null,
  bean_type uuid default null,
  bean_id uuid default null,
  deleted boolean default null
);

create index idx_user_id on users_last_import(assigned_user_id);

create table users_password_link (
  id uuid primary key,
  keyhash varchar(255) default null,
  user_id uuid default null,
  username varchar(36) default null,
  date_generated timestamptz default null,
  deleted boolean default null
);

create index idx_username on users_password_link(username);

create table users_signatures (
  id uuid primary key,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  deleted boolean default null,
  user_id uuid default null,
  name varchar(255) default null,
  signature text default null,
  signature_html text default null
);

create index idx_usersig_uid on users_signatures(user_id);

create table vcals (
  id uuid primary key,
  deleted boolean default null,
  date_entered timestamptz default null,
  date_modified timestamptz default null,
  user_id uuid not null,
  type1 varchar(100) default null,
  source varchar(100) default null,
  content text default null
);

create index idx_vcal on vcals(type1,user_id);

create table jwt_xsrf (
  email varchar(255) primary key,
  username varchar(64) unique not null,
  xsrf_token uuid not null
);

create index idx_jwt_xsrf on jwt_xsrf(xsrf_token);