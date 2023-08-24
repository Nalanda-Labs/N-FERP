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
  action_order int(255) default null,
  action varchar(100) default null,
  parameters longtext default null
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
