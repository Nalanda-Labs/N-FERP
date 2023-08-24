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

create index aok_knowledgebase_categories_alt on aok_knowledge_base_categories(aok_knowledgebase_id,aok_knowledge_base_categories_id);

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

CREATE TABLE aos_products_audit (
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

create index idx_aos_products_parent_id on aos_products_audit (parent_id);

CREATE TABLE aos_products_quotes (
  id uuid primary key,
  name text DEFAULT NULL,
  date_entered timestamptz DEFAULT NULL,
  date_modified timestamptz DEFAULT NULL,
  modified_user_id uuid DEFAULT NULL,
  created_by uuid DEFAULT NULL,
  description text DEFAULT NULL,
  deleted boolean DEFAULT false,
  assigned_user_id uuid DEFAULT NULL,
  currency_id uuid DEFAULT NULL,
  part_number varchar(255) DEFAULT NULL,
  item_description text DEFAULT NULL,
  number int DEFAULT NULL,
  product_qty decimal(18,4) DEFAULT NULL,
  product_cost_price decimal(26,6) DEFAULT NULL,
  product_cost_price_usdollar decimal(26,6) DEFAULT NULL,
  product_list_price decimal(26,6) DEFAULT NULL,
  product_list_price_usdollar decimal(26,6) DEFAULT NULL,
  product_discount decimal(26,6) DEFAULT NULL,
  product_discount_usdollar decimal(26,6) DEFAULT NULL,
  product_discount_amount decimal(26,6) DEFAULT NULL,
  product_discount_amount_usdollar decimal(26,6) DEFAULT NULL,
  discount varchar(255) DEFAULT 'Percentage',
  product_unit_price decimal(26,6) DEFAULT NULL,
  product_unit_price_usdollar decimal(26,6) DEFAULT NULL,
  vat_amt decimal(26,6) DEFAULT NULL,
  vat_amt_usdollar decimal(26,6) DEFAULT NULL,
  product_total_price decimal(26,6) DEFAULT NULL,
  product_total_price_usdollar decimal(26,6) DEFAULT NULL,
  vat varchar(100) DEFAULT '5.0',
  parent_type varchar(100) DEFAULT NULL,
  parent_id uuid DEFAULT NULL,
  product_id uuid DEFAULT NULL,
  group_id uuid DEFAULT NULL
);

create index idx_aospq_par_del on aos_products_quotes(parent_id,parent_type,deleted);

CREATE TABLE aos_products_quotes_audit (
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

create index idx_aos_products_quotes_parent_id on aos_products_quotes_audit(parent_id);

CREATE TABLE aos_quotes (
  id uuid primary key,
  name varchar(255) DEFAULT NULL,
  date_entered timestamptz DEFAULT NULL,
  date_modified timestamptz DEFAULT NULL,
  modified_user_id uuid DEFAULT NULL,
  created_by uuid DEFAULT NULL,
  description text DEFAULT NULL,
  deleted boolean DEFAULT false,
  assigned_user_id uuid DEFAULT NULL,
  approval_issue text DEFAULT NULL,
  billing_account_id uuid DEFAULT NULL,
  billing_contact_id uuid DEFAULT NULL,
  billing_address_street varchar(150) DEFAULT NULL,
  billing_address_city varchar(100) DEFAULT NULL,
  billing_address_state varchar(100) DEFAULT NULL,
  billing_address_postalcode varchar(20) DEFAULT NULL,
  billing_address_country varchar(255) DEFAULT NULL,
  shipping_address_street varchar(150) DEFAULT NULL,
  shipping_address_city varchar(100) DEFAULT NULL,
  shipping_address_state varchar(100) DEFAULT NULL,
  shipping_address_postalcode varchar(20) DEFAULT NULL,
  shipping_address_country varchar(255) DEFAULT NULL,
  expiration date DEFAULT NULL,
  number int DEFAULT NULL,
  opportunity_id uuid DEFAULT NULL,
  template_ddown_c text DEFAULT NULL,
  total_amt decimal(26,6) DEFAULT NULL,
  total_amt_usdollar decimal(26,6) DEFAULT NULL,
  subtotal_amount decimal(26,6) DEFAULT NULL,
  subtotal_amount_usdollar decimal(26,6) DEFAULT NULL,
  discount_amount decimal(26,6) DEFAULT NULL,
  discount_amount_usdollar decimal(26,6) DEFAULT NULL,
  tax_amount decimal(26,6) DEFAULT NULL,
  tax_amount_usdollar decimal(26,6) DEFAULT NULL,
  shipping_amount decimal(26,6) DEFAULT NULL,
  shipping_amount_usdollar decimal(26,6) DEFAULT NULL,
  shipping_tax varchar(100) DEFAULT NULL,
  shipping_tax_amt decimal(26,6) DEFAULT NULL,
  shipping_tax_amt_usdollar decimal(26,6) DEFAULT NULL,
  total_amount decimal(26,6) DEFAULT NULL,
  total_amount_usdollar decimal(26,6) DEFAULT NULL,
  currency_id char(36) DEFAULT NULL,
  stage varchar(100) DEFAULT 'Draft',
  term varchar(100) DEFAULT NULL,
  terms_c text DEFAULT NULL,
  approval_status varchar(100) DEFAULT NULL,
  invoice_status varchar(100) DEFAULT 'Not Invoiced',
  subtotal_tax_amount decimal(26,6) DEFAULT NULL,
  subtotal_tax_amount_usdollar decimal(26,6) DEFAULT NULL
);

CREATE TABLE aos_quotes_aos_invoices_c (
  id uuid primary key,
  date_modified timestamptz DEFAULT NULL,
  deleted boolean DEFAULT false,
  aos_quotes77d9_quotes_ida uuid DEFAULT NULL,
  aos_quotes6b83nvoices_idb uuid DEFAULT NULL
);

create index aos_quotes_aos_invoices_alt on aos_quotes_aos_invoices_c(aos_quotes77d9_quotes_ida,aos_quotes6b83nvoices_idb);

CREATE TABLE aos_quotes_audit (
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

create index idx_aos_quotes_parent_id on aos_quotes_audit(parent_id);

CREATE TABLE aos_quotes_os_contracts_c (
  id uuid primary key,
  date_modified timestamptz DEFAULT NULL,
  deleted boolean DEFAULT false,
  aos_quotese81e_quotes_ida uuid DEFAULT NULL,
  aos_quotes4dc0ntracts_idb uuid DEFAULT NULL
);

create index aos_quotes_aos_contracts_alt on aos_quotes_os_contracts_c(aos_quotese81e_quotes_ida,aos_quotes4dc0ntracts_idb);

CREATE TABLE aos_quotes_project_c (
  id uuid primary key,
  date_modified timestamptz DEFAULT NULL,
  deleted boolean DEFAULT false,
  aos_quotes1112_quotes_ida uuid DEFAULT NULL,
  aos_quotes7207project_idb uuid DEFAULT NULL
);

create index aos_quotes_project_alt on aos_quotes_project_c(aos_quotes1112_quotes_ida,aos_quotes7207project_idb);

CREATE TABLE aow_actions (
  id uuid primary key,
  name varchar(255) DEFAULT NULL,
  date_entered timestamptz DEFAULT NULL,
  date_modified timestamptz DEFAULT NULL,
  modified_user_id uuid DEFAULT NULL,
  created_by uuid DEFAULT NULL,
  description text DEFAULT NULL,
  deleted boolean DEFAULT false,
  aow_workflow_id uuid DEFAULT NULL,
  action_order int(255) DEFAULT NULL,
  action varchar(100) DEFAULT NULL,
  parameters longtext DEFAULT NULL
);

create index aow_action_index_workflow_id on aow_actions(aow_workflow_id);

CREATE TABLE aow_conditions (
  id uuid primary key,
  name varchar(255) DEFAULT NULL,
  date_entered timestamptz DEFAULT NULL,
  date_modified timestamptz DEFAULT NULL,
  modified_user_id uuid DEFAULT NULL,
  created_by uuid DEFAULT NULL,
  description text DEFAULT NULL,
  deleted boolean DEFAULT false,
  aow_workflow_id uuid DEFAULT NULL,
  condition_order int DEFAULT NULL,
  module_path text DEFAULT NULL,
  field varchar(100) DEFAULT NULL,
  operator varchar(100) DEFAULT NULL,
  value_type varchar(255) DEFAULT NULL,
  value varchar(255) DEFAULT NULL
);

create index aow_conditions_index_workflow_id on aow_conditions(aow_workflow_id);

CREATE TABLE aow_processed (
  id uuid primary key,
  name varchar(255) DEFAULT NULL,
  date_entered timestamptz DEFAULT NULL,
  date_modified timestamptz DEFAULT NULL,
  modified_user_id uuid DEFAULT NULL,
  created_by uuid DEFAULT NULL,
  description text DEFAULT NULL,
  deleted boolean DEFAULT false,
  aow_workflow_id uuid DEFAULT NULL,
  parent_id uuid DEFAULT NULL,
  parent_type varchar(100) DEFAULT NULL,
  status varchar(100) DEFAULT 'Pending'
);

create index aow_processed_index_workflow on aow_processed(aow_workflow_id,status,parent_id,deleted);
create index aow_processed_index_status on aow_processed(status);
create index aow_processed_index_workflow_id on aow_processed(aow_workflow_id);

CREATE TABLE aow_processed_aow_actions (
  id uuid primary key,
  aow_processed_id uuid DEFAULT NULL,
  aow_action_id uuid DEFAULT NULL,
  status varchar(36) DEFAULT 'Pending',
  date_modified timestamptz DEFAULT NULL,
  deleted boolean DEFAULT false
);

create index idx_aow_processed_aow_actions on aow_processed_aow_actions(aow_processed_id,aow_action_id);
create index idx_actid_del_freid on aow_processed_aow_actions(aow_action_id,deleted,aow_processed_id);
