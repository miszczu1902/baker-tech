--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4 (Debian 15.4-2.pgdg120+1)
-- Dumped by pg_dump version 15.4 (Debian 15.4-2.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: keycloak; Type: SCHEMA; Schema: -; Owner: bakertech
--

CREATE SCHEMA keycloak;


ALTER SCHEMA keycloak OWNER TO bakertech;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE keycloak.admin_event_entity OWNER TO bakertech;

--
-- Name: associated_policy; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.associated_policy OWNER TO bakertech;

--
-- Name: authentication_execution; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE keycloak.authentication_execution OWNER TO bakertech;

--
-- Name: authentication_flow; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.authentication_flow OWNER TO bakertech;

--
-- Name: authenticator_config; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE keycloak.authenticator_config OWNER TO bakertech;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.authenticator_config_entry OWNER TO bakertech;

--
-- Name: broker_link; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE keycloak.broker_link OWNER TO bakertech;

--
-- Name: client; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.client OWNER TO bakertech;

--
-- Name: client_attributes; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.client_attributes OWNER TO bakertech;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE keycloak.client_auth_flow_bindings OWNER TO bakertech;

--
-- Name: client_initial_access; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE keycloak.client_initial_access OWNER TO bakertech;

--
-- Name: client_node_registrations; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.client_node_registrations OWNER TO bakertech;

--
-- Name: client_scope; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE keycloak.client_scope OWNER TO bakertech;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.client_scope_attributes OWNER TO bakertech;

--
-- Name: client_scope_client; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.client_scope_client OWNER TO bakertech;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_scope_role_mapping OWNER TO bakertech;

--
-- Name: client_session; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE keycloak.client_session OWNER TO bakertech;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_session_auth_status OWNER TO bakertech;

--
-- Name: client_session_note; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_session_note OWNER TO bakertech;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_session_prot_mapper OWNER TO bakertech;

--
-- Name: client_session_role; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_session_role OWNER TO bakertech;

--
-- Name: client_user_session_note; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_user_session_note OWNER TO bakertech;

--
-- Name: component; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE keycloak.component OWNER TO bakertech;

--
-- Name: component_config; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE keycloak.component_config OWNER TO bakertech;

--
-- Name: composite_role; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE keycloak.composite_role OWNER TO bakertech;

--
-- Name: credential; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE keycloak.credential OWNER TO bakertech;

--
-- Name: databasechangelog; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE keycloak.databasechangelog OWNER TO bakertech;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE keycloak.databasechangeloglock OWNER TO bakertech;

--
-- Name: default_client_scope; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.default_client_scope OWNER TO bakertech;

--
-- Name: event_entity; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE keycloak.event_entity OWNER TO bakertech;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE keycloak.fed_user_attribute OWNER TO bakertech;

--
-- Name: fed_user_consent; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE keycloak.fed_user_consent OWNER TO bakertech;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.fed_user_consent_cl_scope OWNER TO bakertech;

--
-- Name: fed_user_credential; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE keycloak.fed_user_credential OWNER TO bakertech;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE keycloak.fed_user_group_membership OWNER TO bakertech;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE keycloak.fed_user_required_action OWNER TO bakertech;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE keycloak.fed_user_role_mapping OWNER TO bakertech;

--
-- Name: federated_identity; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.federated_identity OWNER TO bakertech;

--
-- Name: federated_user; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.federated_user OWNER TO bakertech;

--
-- Name: group_attribute; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.group_attribute OWNER TO bakertech;

--
-- Name: group_role_mapping; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.group_role_mapping OWNER TO bakertech;

--
-- Name: identity_provider; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.identity_provider OWNER TO bakertech;

--
-- Name: identity_provider_config; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.identity_provider_config OWNER TO bakertech;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.identity_provider_mapper OWNER TO bakertech;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.idp_mapper_config OWNER TO bakertech;

--
-- Name: keycloak_group; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE keycloak.keycloak_group OWNER TO bakertech;

--
-- Name: keycloak_role; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE keycloak.keycloak_role OWNER TO bakertech;

--
-- Name: migration_model; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE keycloak.migration_model OWNER TO bakertech;

--
-- Name: offline_client_session; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE keycloak.offline_client_session OWNER TO bakertech;

--
-- Name: offline_user_session; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE keycloak.offline_user_session OWNER TO bakertech;

--
-- Name: policy_config; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE keycloak.policy_config OWNER TO bakertech;

--
-- Name: protocol_mapper; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE keycloak.protocol_mapper OWNER TO bakertech;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.protocol_mapper_config OWNER TO bakertech;

--
-- Name: realm; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE keycloak.realm OWNER TO bakertech;

--
-- Name: realm_attribute; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE keycloak.realm_attribute OWNER TO bakertech;

--
-- Name: realm_default_groups; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.realm_default_groups OWNER TO bakertech;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.realm_enabled_event_types OWNER TO bakertech;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.realm_events_listeners OWNER TO bakertech;

--
-- Name: realm_localizations; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE keycloak.realm_localizations OWNER TO bakertech;

--
-- Name: realm_required_credential; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.realm_required_credential OWNER TO bakertech;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.realm_smtp_config OWNER TO bakertech;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.realm_supported_locales OWNER TO bakertech;

--
-- Name: redirect_uris; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.redirect_uris OWNER TO bakertech;

--
-- Name: required_action_config; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.required_action_config OWNER TO bakertech;

--
-- Name: required_action_provider; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE keycloak.required_action_provider OWNER TO bakertech;

--
-- Name: resource_attribute; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.resource_attribute OWNER TO bakertech;

--
-- Name: resource_policy; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.resource_policy OWNER TO bakertech;

--
-- Name: resource_scope; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.resource_scope OWNER TO bakertech;

--
-- Name: resource_server; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE keycloak.resource_server OWNER TO bakertech;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE keycloak.resource_server_perm_ticket OWNER TO bakertech;

--
-- Name: resource_server_policy; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE keycloak.resource_server_policy OWNER TO bakertech;

--
-- Name: resource_server_resource; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE keycloak.resource_server_resource OWNER TO bakertech;

--
-- Name: resource_server_scope; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE keycloak.resource_server_scope OWNER TO bakertech;

--
-- Name: resource_uris; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.resource_uris OWNER TO bakertech;

--
-- Name: role_attribute; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE keycloak.role_attribute OWNER TO bakertech;

--
-- Name: scope_mapping; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.scope_mapping OWNER TO bakertech;

--
-- Name: scope_policy; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.scope_policy OWNER TO bakertech;

--
-- Name: user_attribute; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE keycloak.user_attribute OWNER TO bakertech;

--
-- Name: user_consent; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE keycloak.user_consent OWNER TO bakertech;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.user_consent_client_scope OWNER TO bakertech;

--
-- Name: user_entity; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE keycloak.user_entity OWNER TO bakertech;

--
-- Name: user_federation_config; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.user_federation_config OWNER TO bakertech;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.user_federation_mapper OWNER TO bakertech;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.user_federation_mapper_config OWNER TO bakertech;

--
-- Name: user_federation_provider; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE keycloak.user_federation_provider OWNER TO bakertech;

--
-- Name: user_group_membership; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.user_group_membership OWNER TO bakertech;

--
-- Name: user_required_action; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE keycloak.user_required_action OWNER TO bakertech;

--
-- Name: user_role_mapping; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.user_role_mapping OWNER TO bakertech;

--
-- Name: user_session; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE keycloak.user_session OWNER TO bakertech;

--
-- Name: user_session_note; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE keycloak.user_session_note OWNER TO bakertech;

--
-- Name: username_login_failure; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE keycloak.username_login_failure OWNER TO bakertech;

--
-- Name: web_origins; Type: TABLE; Schema: keycloak; Owner: bakertech
--

CREATE TABLE keycloak.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.web_origins OWNER TO bakertech;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
7ca12811-1f0d-4113-bd58-ee4f81c4c5d0	\N	auth-cookie	a7ba7779-875b-4788-99a3-328f298d05b3	71de9b6a-70d7-49ad-a469-ad487e0ab7e9	2	10	f	\N	\N
41e8cc5f-0e83-411a-b50f-62799eb712fa	\N	auth-spnego	a7ba7779-875b-4788-99a3-328f298d05b3	71de9b6a-70d7-49ad-a469-ad487e0ab7e9	3	20	f	\N	\N
e3c00794-363c-44e3-990d-f92a129d8c00	\N	identity-provider-redirector	a7ba7779-875b-4788-99a3-328f298d05b3	71de9b6a-70d7-49ad-a469-ad487e0ab7e9	2	25	f	\N	\N
f588c63e-3786-4468-9c87-879a7f64bc5e	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	71de9b6a-70d7-49ad-a469-ad487e0ab7e9	2	30	t	7fd2f281-d6cd-492d-9ace-0b578ff9f8ea	\N
fe85b166-f0c7-4153-942c-c2eb4f91011b	\N	auth-username-password-form	a7ba7779-875b-4788-99a3-328f298d05b3	7fd2f281-d6cd-492d-9ace-0b578ff9f8ea	0	10	f	\N	\N
a9a6a6f3-524c-4e3f-bc58-710d819a21a2	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	7fd2f281-d6cd-492d-9ace-0b578ff9f8ea	1	20	t	4a8ed191-484f-44bd-bb9d-3310cb55f793	\N
e086b473-5786-4c99-84b2-eeeb0f11f82c	\N	conditional-user-configured	a7ba7779-875b-4788-99a3-328f298d05b3	4a8ed191-484f-44bd-bb9d-3310cb55f793	0	10	f	\N	\N
be957207-d4c6-4ed5-8869-38ebd92b60e5	\N	auth-otp-form	a7ba7779-875b-4788-99a3-328f298d05b3	4a8ed191-484f-44bd-bb9d-3310cb55f793	0	20	f	\N	\N
5fd6a7c1-c2f1-428e-a34d-28dfa6300150	\N	direct-grant-validate-username	a7ba7779-875b-4788-99a3-328f298d05b3	7e345b1f-eb9e-4ab0-976b-827d1c3d0bf0	0	10	f	\N	\N
9e8c6af2-2c92-4a4c-a4bf-4a80918b3520	\N	direct-grant-validate-password	a7ba7779-875b-4788-99a3-328f298d05b3	7e345b1f-eb9e-4ab0-976b-827d1c3d0bf0	0	20	f	\N	\N
3dc634fd-75db-41f2-97a8-84b1c69315b9	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	7e345b1f-eb9e-4ab0-976b-827d1c3d0bf0	1	30	t	12a2d04c-1793-49bf-b35d-7af54eeec565	\N
cc61007c-7587-4bc3-b2d9-5319753e439a	\N	conditional-user-configured	a7ba7779-875b-4788-99a3-328f298d05b3	12a2d04c-1793-49bf-b35d-7af54eeec565	0	10	f	\N	\N
de125882-d7d5-4784-8b75-0083290a79c3	\N	direct-grant-validate-otp	a7ba7779-875b-4788-99a3-328f298d05b3	12a2d04c-1793-49bf-b35d-7af54eeec565	0	20	f	\N	\N
0a7dd0fa-f8ed-40fc-9d4c-8789406b5bce	\N	registration-page-form	a7ba7779-875b-4788-99a3-328f298d05b3	bf1acb06-8db2-4020-9530-60e67daa441a	0	10	t	2569a5a2-a23f-49a8-8956-580bbb80741c	\N
397e9f27-769c-41f5-9cb4-a5e885323cec	\N	registration-user-creation	a7ba7779-875b-4788-99a3-328f298d05b3	2569a5a2-a23f-49a8-8956-580bbb80741c	0	20	f	\N	\N
6f1eff32-79e6-4879-ac90-b2558d1414b4	\N	registration-profile-action	a7ba7779-875b-4788-99a3-328f298d05b3	2569a5a2-a23f-49a8-8956-580bbb80741c	0	40	f	\N	\N
cb453409-ca09-41cc-adbf-3590e9b0c725	\N	registration-password-action	a7ba7779-875b-4788-99a3-328f298d05b3	2569a5a2-a23f-49a8-8956-580bbb80741c	0	50	f	\N	\N
3d12ee09-b054-4882-bb56-710c551f901a	\N	registration-recaptcha-action	a7ba7779-875b-4788-99a3-328f298d05b3	2569a5a2-a23f-49a8-8956-580bbb80741c	3	60	f	\N	\N
8ff8e9b9-fe3f-4abe-9049-ba28032d441e	\N	reset-credentials-choose-user	a7ba7779-875b-4788-99a3-328f298d05b3	4071f835-5419-4776-bad5-795f323a2927	0	10	f	\N	\N
a7ad72c1-811b-41bd-a698-31beeba20077	\N	reset-credential-email	a7ba7779-875b-4788-99a3-328f298d05b3	4071f835-5419-4776-bad5-795f323a2927	0	20	f	\N	\N
94de7772-a4e3-4b8c-afcb-f8e97195a254	\N	reset-password	a7ba7779-875b-4788-99a3-328f298d05b3	4071f835-5419-4776-bad5-795f323a2927	0	30	f	\N	\N
b3fa6e6e-2a4c-4e3e-ba9f-be0080dfcbb3	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	4071f835-5419-4776-bad5-795f323a2927	1	40	t	3f04c543-fa3d-4463-a565-04c42db61361	\N
3e966bac-a7c1-4b3c-a1d4-b38010bd0f8a	\N	conditional-user-configured	a7ba7779-875b-4788-99a3-328f298d05b3	3f04c543-fa3d-4463-a565-04c42db61361	0	10	f	\N	\N
1b0de09b-c4d7-4263-9761-364a04437915	\N	reset-otp	a7ba7779-875b-4788-99a3-328f298d05b3	3f04c543-fa3d-4463-a565-04c42db61361	0	20	f	\N	\N
493f3091-a79c-4ddf-a2ee-b6eadccc9d4b	\N	client-secret	a7ba7779-875b-4788-99a3-328f298d05b3	fb6e7ae4-ceeb-4475-99ba-f63b3c73daec	2	10	f	\N	\N
0ca97bf2-2bce-4afb-911d-4f7241e9a688	\N	client-jwt	a7ba7779-875b-4788-99a3-328f298d05b3	fb6e7ae4-ceeb-4475-99ba-f63b3c73daec	2	20	f	\N	\N
5244161c-a395-4f31-a7ca-92ce9bcd8fc6	\N	client-secret-jwt	a7ba7779-875b-4788-99a3-328f298d05b3	fb6e7ae4-ceeb-4475-99ba-f63b3c73daec	2	30	f	\N	\N
d1ebb591-a584-4da3-817b-3160cd110b1f	\N	client-x509	a7ba7779-875b-4788-99a3-328f298d05b3	fb6e7ae4-ceeb-4475-99ba-f63b3c73daec	2	40	f	\N	\N
2b00c4cd-8678-46f0-8b88-9eeff7b983db	\N	idp-review-profile	a7ba7779-875b-4788-99a3-328f298d05b3	8278d942-9827-41bc-97b8-b22b3e8575e0	0	10	f	\N	528baae5-89f3-4c50-b700-a21388a7c3fd
67f3c1ba-1b32-4375-b270-f57a4f2ea276	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	8278d942-9827-41bc-97b8-b22b3e8575e0	0	20	t	be29d494-c389-4dc7-bc96-6de602150208	\N
41c146cc-c4c2-4b42-96db-319d6da94f8a	\N	idp-create-user-if-unique	a7ba7779-875b-4788-99a3-328f298d05b3	be29d494-c389-4dc7-bc96-6de602150208	2	10	f	\N	1b6574fc-67ef-4945-b0af-b24664cfe8bb
6a2b22ec-e3b6-45de-9121-b1389295d0b6	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	be29d494-c389-4dc7-bc96-6de602150208	2	20	t	771555ca-ca66-4089-8363-e8d085fb9c0e	\N
75ad5858-3e62-4e3f-bf02-f5403aa6fa78	\N	idp-confirm-link	a7ba7779-875b-4788-99a3-328f298d05b3	771555ca-ca66-4089-8363-e8d085fb9c0e	0	10	f	\N	\N
b45ba964-3c4c-427c-b5bf-86ee69b8eea2	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	771555ca-ca66-4089-8363-e8d085fb9c0e	0	20	t	44c9ee9f-1d8d-40d0-be13-1152197bfc6f	\N
67c87cec-ba53-425c-9458-2383eb3a5e3c	\N	idp-email-verification	a7ba7779-875b-4788-99a3-328f298d05b3	44c9ee9f-1d8d-40d0-be13-1152197bfc6f	2	10	f	\N	\N
6a01e362-de54-4573-a446-9966e439b526	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	44c9ee9f-1d8d-40d0-be13-1152197bfc6f	2	20	t	2abd1c2e-dc6f-4339-be6a-edb48f6b1580	\N
fb2c7435-971d-4d15-a1e6-24169918a6b3	\N	idp-username-password-form	a7ba7779-875b-4788-99a3-328f298d05b3	2abd1c2e-dc6f-4339-be6a-edb48f6b1580	0	10	f	\N	\N
709396fc-a24f-4646-86c3-573ec48ce8a1	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	2abd1c2e-dc6f-4339-be6a-edb48f6b1580	1	20	t	12d19b36-8bc8-442f-9cd6-c8643d7e8dec	\N
ecab43d2-922c-4bf6-9328-8fa46d3b606e	\N	conditional-user-configured	a7ba7779-875b-4788-99a3-328f298d05b3	12d19b36-8bc8-442f-9cd6-c8643d7e8dec	0	10	f	\N	\N
b1bc3fe8-0f6f-4808-840b-957b40a325a8	\N	auth-otp-form	a7ba7779-875b-4788-99a3-328f298d05b3	12d19b36-8bc8-442f-9cd6-c8643d7e8dec	0	20	f	\N	\N
2c67dd77-f0d5-4b4a-8b10-bf90c010785d	\N	http-basic-authenticator	a7ba7779-875b-4788-99a3-328f298d05b3	d878b3de-edad-43fb-9a61-d50c867abdac	0	10	f	\N	\N
3d6b9302-de6f-47dc-9917-7af88f516e17	\N	docker-http-basic-authenticator	a7ba7779-875b-4788-99a3-328f298d05b3	8417162e-11e8-4373-ab62-e8d15a9edd61	0	10	f	\N	\N
e549b13d-769f-4ce4-a568-085fee8afb8c	\N	no-cookie-redirect	a7ba7779-875b-4788-99a3-328f298d05b3	ad7723b5-0ae4-439d-8321-39cefcf742f1	0	10	f	\N	\N
1ee93b93-822e-48ca-a4f3-a272402d448a	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	ad7723b5-0ae4-439d-8321-39cefcf742f1	0	20	t	ea89be6d-8ecf-40f3-88e6-1688bafaa047	\N
237ae8ba-28a5-4013-a73b-f19d85770886	\N	basic-auth	a7ba7779-875b-4788-99a3-328f298d05b3	ea89be6d-8ecf-40f3-88e6-1688bafaa047	0	10	f	\N	\N
6cadc136-fea1-4b25-a10b-8cb96feb40be	\N	basic-auth-otp	a7ba7779-875b-4788-99a3-328f298d05b3	ea89be6d-8ecf-40f3-88e6-1688bafaa047	3	20	f	\N	\N
12e6f540-142e-41b5-86ae-ecaf76df0bdc	\N	auth-spnego	a7ba7779-875b-4788-99a3-328f298d05b3	ea89be6d-8ecf-40f3-88e6-1688bafaa047	3	30	f	\N	\N
d6b6905a-e592-43db-aad4-58240619de01	\N	idp-email-verification	8eee160c-5edd-481a-b964-c368a057e598	d31d9315-ce76-4b8d-919f-9a6a2dea7664	2	10	f	\N	\N
2441bb7e-1631-44af-a5ae-576183511fa4	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	d31d9315-ce76-4b8d-919f-9a6a2dea7664	2	20	t	5afb0963-7997-435e-9a8c-d3d5dad6cde9	\N
3c575faf-04d4-485f-82f2-d3708583cce8	\N	basic-auth	8eee160c-5edd-481a-b964-c368a057e598	caadfd80-82fb-4e63-8aa9-89484521f382	0	10	f	\N	\N
56c3f006-02da-492c-b57b-36f04930833d	\N	basic-auth-otp	8eee160c-5edd-481a-b964-c368a057e598	caadfd80-82fb-4e63-8aa9-89484521f382	3	20	f	\N	\N
b76a9633-6e25-4465-9c4a-e6db8c9c5ad3	\N	auth-spnego	8eee160c-5edd-481a-b964-c368a057e598	caadfd80-82fb-4e63-8aa9-89484521f382	3	30	f	\N	\N
c31872fb-bdf0-4401-bd6e-c328b490c1bb	\N	conditional-user-configured	8eee160c-5edd-481a-b964-c368a057e598	7e516904-307b-4e64-ab2b-716a0ef6ed3a	0	10	f	\N	\N
1f8a2849-6d98-4c0c-902a-aa93e118ea9a	\N	auth-otp-form	8eee160c-5edd-481a-b964-c368a057e598	7e516904-307b-4e64-ab2b-716a0ef6ed3a	0	20	f	\N	\N
c59a018e-8f9b-4c9b-8df8-7e612eab94aa	\N	conditional-user-configured	8eee160c-5edd-481a-b964-c368a057e598	ad78ff98-5d09-4d3e-9c3c-0a7ea669f3c4	0	10	f	\N	\N
02d28980-e575-4db7-98e8-8646f804c0b2	\N	direct-grant-validate-otp	8eee160c-5edd-481a-b964-c368a057e598	ad78ff98-5d09-4d3e-9c3c-0a7ea669f3c4	0	20	f	\N	\N
ad5616e5-7bbc-4f28-872e-8e07340820dc	\N	conditional-user-configured	8eee160c-5edd-481a-b964-c368a057e598	ff1e79dd-c2ab-4579-9500-79db600e8db4	0	10	f	\N	\N
0b1e0927-8bf4-4dd4-a6ad-833c28e9dc23	\N	auth-otp-form	8eee160c-5edd-481a-b964-c368a057e598	ff1e79dd-c2ab-4579-9500-79db600e8db4	0	20	f	\N	\N
577939ac-065f-4772-aedf-068528de8ee3	\N	idp-confirm-link	8eee160c-5edd-481a-b964-c368a057e598	2e50a0d7-485f-42e3-90fd-8cfb0f30139c	0	10	f	\N	\N
89cd1297-36ab-4fdd-9be3-46ee1b2ac616	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	2e50a0d7-485f-42e3-90fd-8cfb0f30139c	0	20	t	d31d9315-ce76-4b8d-919f-9a6a2dea7664	\N
f185f880-c4ec-4595-a44a-9654ae27e8b5	\N	conditional-user-configured	8eee160c-5edd-481a-b964-c368a057e598	6aac7811-f531-4aa3-960c-b0b51c6e6100	0	10	f	\N	\N
95b13492-ef96-400f-a6e0-ca173979ef63	\N	reset-otp	8eee160c-5edd-481a-b964-c368a057e598	6aac7811-f531-4aa3-960c-b0b51c6e6100	0	20	f	\N	\N
ee9a79dd-5e1d-40ec-b201-b89e63d70d5b	\N	idp-create-user-if-unique	8eee160c-5edd-481a-b964-c368a057e598	1e0a7c45-e61f-4512-971a-92f44fbd635b	2	10	f	\N	078d5767-6098-4d2d-9f30-db03ea3dc0b6
48797272-3c2e-4946-9f4c-6b4f99fd5d2a	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	1e0a7c45-e61f-4512-971a-92f44fbd635b	2	20	t	2e50a0d7-485f-42e3-90fd-8cfb0f30139c	\N
c033fc7e-f2e3-489c-9b70-04e188381a0e	\N	idp-username-password-form	8eee160c-5edd-481a-b964-c368a057e598	5afb0963-7997-435e-9a8c-d3d5dad6cde9	0	10	f	\N	\N
cacc7504-96f6-4219-b2c0-0756123d3468	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	5afb0963-7997-435e-9a8c-d3d5dad6cde9	1	20	t	ff1e79dd-c2ab-4579-9500-79db600e8db4	\N
4143a41c-f122-4dc4-a486-2f0fc6877d69	\N	auth-cookie	8eee160c-5edd-481a-b964-c368a057e598	a6633ee8-cc41-4751-9c29-83a01f6772ef	2	10	f	\N	\N
01adf0f2-297f-4231-8619-ad1442b8e557	\N	auth-spnego	8eee160c-5edd-481a-b964-c368a057e598	a6633ee8-cc41-4751-9c29-83a01f6772ef	3	20	f	\N	\N
ea238edc-1a36-494a-b9e5-acba804be289	\N	identity-provider-redirector	8eee160c-5edd-481a-b964-c368a057e598	a6633ee8-cc41-4751-9c29-83a01f6772ef	2	25	f	\N	\N
36cc3bdf-f510-417c-aac8-36f496e9186a	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	a6633ee8-cc41-4751-9c29-83a01f6772ef	2	30	t	d3dcdfb6-7133-4020-bace-b7954ad2edf2	\N
118c9414-9bf8-4193-9141-d7b03b0112c4	\N	client-secret	8eee160c-5edd-481a-b964-c368a057e598	86e02597-dbaa-4f5c-b827-97004b71f580	2	10	f	\N	\N
badef713-bcb2-4a6b-b204-1613e1fa6637	\N	client-jwt	8eee160c-5edd-481a-b964-c368a057e598	86e02597-dbaa-4f5c-b827-97004b71f580	2	20	f	\N	\N
822479e1-281e-4f2c-97f4-1a13ea63e315	\N	client-secret-jwt	8eee160c-5edd-481a-b964-c368a057e598	86e02597-dbaa-4f5c-b827-97004b71f580	2	30	f	\N	\N
36c4d4f3-cd12-471a-9bc1-24bb5860c32b	\N	client-x509	8eee160c-5edd-481a-b964-c368a057e598	86e02597-dbaa-4f5c-b827-97004b71f580	2	40	f	\N	\N
7ac60df8-3202-4507-85a3-0fadf18402bc	\N	direct-grant-validate-username	8eee160c-5edd-481a-b964-c368a057e598	859b702d-59c5-4eac-b920-5744824ac778	0	10	f	\N	\N
20989273-1aec-427f-9df1-3ca21d921cf4	\N	direct-grant-validate-password	8eee160c-5edd-481a-b964-c368a057e598	859b702d-59c5-4eac-b920-5744824ac778	0	20	f	\N	\N
04d9997e-a6e8-421c-8104-fa7176af5206	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	859b702d-59c5-4eac-b920-5744824ac778	1	30	t	ad78ff98-5d09-4d3e-9c3c-0a7ea669f3c4	\N
00c8f9cc-3e7b-4fa5-bf23-f2d171e8b84a	\N	docker-http-basic-authenticator	8eee160c-5edd-481a-b964-c368a057e598	ecdb11a4-e6fb-4851-bf7f-1eec3e0ac6d6	0	10	f	\N	\N
02020081-2ad1-473c-acfa-0708b427e4d5	\N	idp-review-profile	8eee160c-5edd-481a-b964-c368a057e598	2924064d-be95-4e8e-8d99-46c50b069e84	0	10	f	\N	65da87b2-5b75-4707-8d25-e18d54a736c7
bd6903ab-6a7f-4808-85da-8f96debb836b	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	2924064d-be95-4e8e-8d99-46c50b069e84	0	20	t	1e0a7c45-e61f-4512-971a-92f44fbd635b	\N
c3a3d096-3113-4122-a992-abaa964e85ef	\N	auth-username-password-form	8eee160c-5edd-481a-b964-c368a057e598	d3dcdfb6-7133-4020-bace-b7954ad2edf2	0	10	f	\N	\N
bec3f2e1-e143-4aa9-a408-dfc7d35501ab	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	d3dcdfb6-7133-4020-bace-b7954ad2edf2	1	20	t	7e516904-307b-4e64-ab2b-716a0ef6ed3a	\N
db010fe6-187d-4010-a18a-6992e6dd0752	\N	no-cookie-redirect	8eee160c-5edd-481a-b964-c368a057e598	5f940c08-7cff-4061-b02a-4101d7f5ae6b	0	10	f	\N	\N
07c6823c-4753-45b6-bb7b-98b90c2aba24	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	5f940c08-7cff-4061-b02a-4101d7f5ae6b	0	20	t	caadfd80-82fb-4e63-8aa9-89484521f382	\N
bd0d4e38-a44e-4042-b0c7-7ab66a6d32c8	\N	registration-page-form	8eee160c-5edd-481a-b964-c368a057e598	2b3a7059-60e6-4c84-a94b-d05e5bf98d7b	0	10	t	f3daa608-8901-4617-bf36-3fbb55fae93d	\N
6c8e03e2-5c60-481a-8a08-dce62af9a2f7	\N	registration-user-creation	8eee160c-5edd-481a-b964-c368a057e598	f3daa608-8901-4617-bf36-3fbb55fae93d	0	20	f	\N	\N
4ecbe0fd-ce08-4172-b273-96ed4ee4208d	\N	registration-profile-action	8eee160c-5edd-481a-b964-c368a057e598	f3daa608-8901-4617-bf36-3fbb55fae93d	0	40	f	\N	\N
d0f2e12f-7d71-491b-95a2-b08e3d98ef9a	\N	registration-password-action	8eee160c-5edd-481a-b964-c368a057e598	f3daa608-8901-4617-bf36-3fbb55fae93d	0	50	f	\N	\N
a2337d07-e663-42f6-8588-70f59da2c0bb	\N	registration-recaptcha-action	8eee160c-5edd-481a-b964-c368a057e598	f3daa608-8901-4617-bf36-3fbb55fae93d	3	60	f	\N	\N
65ab67e9-e29d-41f8-8e0c-6040da155652	\N	reset-credentials-choose-user	8eee160c-5edd-481a-b964-c368a057e598	4a7f827d-e6be-418d-a65b-2619fb1eac91	0	10	f	\N	\N
315288cd-effd-4a08-bb82-badbe02bad18	\N	reset-credential-email	8eee160c-5edd-481a-b964-c368a057e598	4a7f827d-e6be-418d-a65b-2619fb1eac91	0	20	f	\N	\N
2e9f9f25-e674-4ca3-a7b4-0f52c012f4c8	\N	reset-password	8eee160c-5edd-481a-b964-c368a057e598	4a7f827d-e6be-418d-a65b-2619fb1eac91	0	30	f	\N	\N
16901f08-d661-4483-92c0-31e296b20f79	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	4a7f827d-e6be-418d-a65b-2619fb1eac91	1	40	t	6aac7811-f531-4aa3-960c-b0b51c6e6100	\N
2e5ddb0d-f4e6-4ed4-af42-e4edc9dedc4c	\N	http-basic-authenticator	8eee160c-5edd-481a-b964-c368a057e598	e415d8fa-63b1-4968-8874-7401b58e1fcc	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
71de9b6a-70d7-49ad-a469-ad487e0ab7e9	browser	browser based authentication	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	t	t
7fd2f281-d6cd-492d-9ace-0b578ff9f8ea	forms	Username, password, otp and other auth forms.	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	f	t
4a8ed191-484f-44bd-bb9d-3310cb55f793	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	f	t
7e345b1f-eb9e-4ab0-976b-827d1c3d0bf0	direct grant	OpenID Connect Resource Owner Grant	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	t	t
12a2d04c-1793-49bf-b35d-7af54eeec565	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	f	t
bf1acb06-8db2-4020-9530-60e67daa441a	registration	registration flow	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	t	t
2569a5a2-a23f-49a8-8956-580bbb80741c	registration form	registration form	a7ba7779-875b-4788-99a3-328f298d05b3	form-flow	f	t
4071f835-5419-4776-bad5-795f323a2927	reset credentials	Reset credentials for a user if they forgot their password or something	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	t	t
3f04c543-fa3d-4463-a565-04c42db61361	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	f	t
fb6e7ae4-ceeb-4475-99ba-f63b3c73daec	clients	Base authentication for clients	a7ba7779-875b-4788-99a3-328f298d05b3	client-flow	t	t
8278d942-9827-41bc-97b8-b22b3e8575e0	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	t	t
be29d494-c389-4dc7-bc96-6de602150208	User creation or linking	Flow for the existing/non-existing user alternatives	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	f	t
771555ca-ca66-4089-8363-e8d085fb9c0e	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	f	t
44c9ee9f-1d8d-40d0-be13-1152197bfc6f	Account verification options	Method with which to verity the existing account	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	f	t
2abd1c2e-dc6f-4339-be6a-edb48f6b1580	Verify Existing Account by Re-authentication	Reauthentication of existing account	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	f	t
12d19b36-8bc8-442f-9cd6-c8643d7e8dec	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	f	t
d878b3de-edad-43fb-9a61-d50c867abdac	saml ecp	SAML ECP Profile Authentication Flow	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	t	t
8417162e-11e8-4373-ab62-e8d15a9edd61	docker auth	Used by Docker clients to authenticate against the IDP	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	t	t
ad7723b5-0ae4-439d-8321-39cefcf742f1	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	t	t
ea89be6d-8ecf-40f3-88e6-1688bafaa047	Authentication Options	Authentication options.	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	f	t
d31d9315-ce76-4b8d-919f-9a6a2dea7664	Account verification options	Method with which to verity the existing account	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	f	t
caadfd80-82fb-4e63-8aa9-89484521f382	Authentication Options	Authentication options.	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	f	t
7e516904-307b-4e64-ab2b-716a0ef6ed3a	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	f	t
ad78ff98-5d09-4d3e-9c3c-0a7ea669f3c4	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	f	t
ff1e79dd-c2ab-4579-9500-79db600e8db4	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	f	t
2e50a0d7-485f-42e3-90fd-8cfb0f30139c	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	f	t
6aac7811-f531-4aa3-960c-b0b51c6e6100	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	f	t
1e0a7c45-e61f-4512-971a-92f44fbd635b	User creation or linking	Flow for the existing/non-existing user alternatives	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	f	t
5afb0963-7997-435e-9a8c-d3d5dad6cde9	Verify Existing Account by Re-authentication	Reauthentication of existing account	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	f	t
a6633ee8-cc41-4751-9c29-83a01f6772ef	browser	browser based authentication	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	t	t
86e02597-dbaa-4f5c-b827-97004b71f580	clients	Base authentication for clients	8eee160c-5edd-481a-b964-c368a057e598	client-flow	t	t
859b702d-59c5-4eac-b920-5744824ac778	direct grant	OpenID Connect Resource Owner Grant	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	t	t
ecdb11a4-e6fb-4851-bf7f-1eec3e0ac6d6	docker auth	Used by Docker clients to authenticate against the IDP	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	t	t
2924064d-be95-4e8e-8d99-46c50b069e84	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	t	t
d3dcdfb6-7133-4020-bace-b7954ad2edf2	forms	Username, password, otp and other auth forms.	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	f	t
5f940c08-7cff-4061-b02a-4101d7f5ae6b	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	t	t
2b3a7059-60e6-4c84-a94b-d05e5bf98d7b	registration	registration flow	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	t	t
f3daa608-8901-4617-bf36-3fbb55fae93d	registration form	registration form	8eee160c-5edd-481a-b964-c368a057e598	form-flow	f	t
4a7f827d-e6be-418d-a65b-2619fb1eac91	reset credentials	Reset credentials for a user if they forgot their password or something	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	t	t
e415d8fa-63b1-4968-8874-7401b58e1fcc	saml ecp	SAML ECP Profile Authentication Flow	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.authenticator_config (id, alias, realm_id) FROM stdin;
528baae5-89f3-4c50-b700-a21388a7c3fd	review profile config	a7ba7779-875b-4788-99a3-328f298d05b3
1b6574fc-67ef-4945-b0af-b24664cfe8bb	create unique user config	a7ba7779-875b-4788-99a3-328f298d05b3
078d5767-6098-4d2d-9f30-db03ea3dc0b6	create unique user config	8eee160c-5edd-481a-b964-c368a057e598
65da87b2-5b75-4707-8d25-e18d54a736c7	review profile config	8eee160c-5edd-481a-b964-c368a057e598
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
528baae5-89f3-4c50-b700-a21388a7c3fd	missing	update.profile.on.first.login
1b6574fc-67ef-4945-b0af-b24664cfe8bb	false	require.password.update.after.registration
078d5767-6098-4d2d-9f30-db03ea3dc0b6	false	require.password.update.after.registration
65da87b2-5b75-4707-8d25-e18d54a736c7	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	f	master-realm	0	f	\N	\N	t	\N	f	a7ba7779-875b-4788-99a3-328f298d05b3	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
530aa4ab-ff70-4256-8abb-0a905d775a99	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	a7ba7779-875b-4788-99a3-328f298d05b3	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	a7ba7779-875b-4788-99a3-328f298d05b3	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
82ccf254-bfc4-462b-97e1-50f2595b7f06	t	f	broker	0	f	\N	\N	t	\N	f	a7ba7779-875b-4788-99a3-328f298d05b3	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	a7ba7779-875b-4788-99a3-328f298d05b3	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
adc7cfaa-ca92-4e9a-adb1-6eb90c9bba02	t	f	admin-cli	0	t	\N	\N	f	\N	f	a7ba7779-875b-4788-99a3-328f298d05b3	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
d0bd1619-802f-413e-bca4-31bbce9059a1	t	f	BakerTech-realm	0	f	\N	\N	t	\N	f	a7ba7779-875b-4788-99a3-328f298d05b3	\N	0	f	f	BakerTech Realm	f	client-secret	\N	\N	\N	t	f	f	f
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	t	f	account	0	t	\N	/realms/BakerTech/account/	f	\N	f	8eee160c-5edd-481a-b964-c368a057e598	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
74b39df6-1c8b-4e84-8251-5771ca6a6470	t	f	account-console	0	t	\N	/realms/BakerTech/account/	f	\N	f	8eee160c-5edd-481a-b964-c368a057e598	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
9c411dbd-4e42-431f-9093-f8c77db6966f	t	f	admin-cli	0	t	\N	\N	f	\N	f	8eee160c-5edd-481a-b964-c368a057e598	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
92f5bea7-369a-483d-a9ea-a330f05968b5	t	t	bakertech	0	f	l0pkoW2RuTFkq8ZE5HOmL07RzRJ83yax	http://localhost:9990/auth/realms/BakerTech/bakertech/	f		f	8eee160c-5edd-481a-b964-c368a057e598	openid-connect	-1	t	f		t	client-secret	${authBaseUrl}		\N	t	f	t	f
80710076-562f-4877-bf9c-7a005d70367b	t	f	broker	0	f	\N	\N	t	\N	f	8eee160c-5edd-481a-b964-c368a057e598	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
39610acb-a894-4f24-811f-08d0590f7f79	t	f	realm-management	0	f	bmMSOQNYUQVop1k2xTo9GVqIfpXedilj	\N	f	\N	f	8eee160c-5edd-481a-b964-c368a057e598	openid-connect	0	f	f	${client_realm-management}	t	client-secret	\N	\N	\N	t	f	f	f
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	t	f	security-admin-console	0	t	\N	/admin/BakerTech/console/	f	\N	f	8eee160c-5edd-481a-b964-c368a057e598	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_attributes (client_id, value, name) FROM stdin;
530aa4ab-ff70-4256-8abb-0a905d775a99	+	post.logout.redirect.uris
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	+	post.logout.redirect.uris
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	S256	pkce.code.challenge.method
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	+	post.logout.redirect.uris
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	S256	pkce.code.challenge.method
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	+	post.logout.redirect.uris
74b39df6-1c8b-4e84-8251-5771ca6a6470	+	post.logout.redirect.uris
74b39df6-1c8b-4e84-8251-5771ca6a6470	S256	pkce.code.challenge.method
9c411dbd-4e42-431f-9093-f8c77db6966f	+	post.logout.redirect.uris
92f5bea7-369a-483d-a9ea-a330f05968b5	1694025627	client.secret.creation.time
92f5bea7-369a-483d-a9ea-a330f05968b5	+	post.logout.redirect.uris
92f5bea7-369a-483d-a9ea-a330f05968b5	false	oauth2.device.authorization.grant.enabled
92f5bea7-369a-483d-a9ea-a330f05968b5	false	use.jwks.url
92f5bea7-369a-483d-a9ea-a330f05968b5	false	backchannel.logout.revoke.offline.tokens
92f5bea7-369a-483d-a9ea-a330f05968b5	true	use.refresh.tokens
92f5bea7-369a-483d-a9ea-a330f05968b5	false	tls-client-certificate-bound-access-tokens
92f5bea7-369a-483d-a9ea-a330f05968b5	false	oidc.ciba.grant.enabled
92f5bea7-369a-483d-a9ea-a330f05968b5	true	backchannel.logout.session.required
92f5bea7-369a-483d-a9ea-a330f05968b5	false	client_credentials.use_refresh_token
92f5bea7-369a-483d-a9ea-a330f05968b5	{}	acr.loa.map
92f5bea7-369a-483d-a9ea-a330f05968b5	false	require.pushed.authorization.requests
92f5bea7-369a-483d-a9ea-a330f05968b5	false	display.on.consent.screen
92f5bea7-369a-483d-a9ea-a330f05968b5	false	token.response.type.bearer.lower-case
80710076-562f-4877-bf9c-7a005d70367b	+	post.logout.redirect.uris
39610acb-a894-4f24-811f-08d0590f7f79	1695580874	client.secret.creation.time
39610acb-a894-4f24-811f-08d0590f7f79	+	post.logout.redirect.uris
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	+	post.logout.redirect.uris
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	S256	pkce.code.challenge.method
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_scope (id, name, realm_id, description, protocol) FROM stdin;
07ab3675-42f8-4b10-b192-8ccd1b2d585c	offline_access	a7ba7779-875b-4788-99a3-328f298d05b3	OpenID Connect built-in scope: offline_access	openid-connect
fcb250d4-b039-468b-9052-c54a64fb504c	role_list	a7ba7779-875b-4788-99a3-328f298d05b3	SAML role list	saml
6977acb4-8b54-432e-b849-816f8c20c04c	profile	a7ba7779-875b-4788-99a3-328f298d05b3	OpenID Connect built-in scope: profile	openid-connect
43820c2a-045e-4909-a8f2-f65ed2433a7d	email	a7ba7779-875b-4788-99a3-328f298d05b3	OpenID Connect built-in scope: email	openid-connect
afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	address	a7ba7779-875b-4788-99a3-328f298d05b3	OpenID Connect built-in scope: address	openid-connect
5fdd6127-2f29-4a63-a405-0fea438c255a	phone	a7ba7779-875b-4788-99a3-328f298d05b3	OpenID Connect built-in scope: phone	openid-connect
e923f6a9-0cd2-4899-a184-d866bf9756a9	roles	a7ba7779-875b-4788-99a3-328f298d05b3	OpenID Connect scope for add user roles to the access token	openid-connect
97183b7b-2c55-4fbd-99b3-4837cfbc0b00	web-origins	a7ba7779-875b-4788-99a3-328f298d05b3	OpenID Connect scope for add allowed web origins to the access token	openid-connect
fa167aac-9554-424f-8b30-4c0297b499d2	microprofile-jwt	a7ba7779-875b-4788-99a3-328f298d05b3	Microprofile - JWT built-in scope	openid-connect
815a3e74-387c-4f80-b408-01309615b469	acr	a7ba7779-875b-4788-99a3-328f298d05b3	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
f8859454-c1a8-4f25-815d-8c2f38e11968	roles	8eee160c-5edd-481a-b964-c368a057e598	OpenID Connect scope for add user roles to the access token	openid-connect
33583b6c-e729-4916-9bf6-2a3e3b79100f	role_list	8eee160c-5edd-481a-b964-c368a057e598	SAML role list	saml
811127fe-927b-4211-b57f-b0ded9b327ef	web-origins	8eee160c-5edd-481a-b964-c368a057e598	OpenID Connect scope for add allowed web origins to the access token	openid-connect
2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	microprofile-jwt	8eee160c-5edd-481a-b964-c368a057e598	Microprofile - JWT built-in scope	openid-connect
ff02e659-87de-4b64-9207-c64548a8d463	profile	8eee160c-5edd-481a-b964-c368a057e598	OpenID Connect built-in scope: profile	openid-connect
b0fe611c-3950-44df-832b-14e0814a70aa	acr	8eee160c-5edd-481a-b964-c368a057e598	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	address	8eee160c-5edd-481a-b964-c368a057e598	OpenID Connect built-in scope: address	openid-connect
0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	offline_access	8eee160c-5edd-481a-b964-c368a057e598	OpenID Connect built-in scope: offline_access	openid-connect
d4320bae-9ace-4165-b177-a00033b8fbdb	phone	8eee160c-5edd-481a-b964-c368a057e598	OpenID Connect built-in scope: phone	openid-connect
03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	email	8eee160c-5edd-481a-b964-c368a057e598	OpenID Connect built-in scope: email	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_scope_attributes (scope_id, value, name) FROM stdin;
07ab3675-42f8-4b10-b192-8ccd1b2d585c	true	display.on.consent.screen
07ab3675-42f8-4b10-b192-8ccd1b2d585c	${offlineAccessScopeConsentText}	consent.screen.text
fcb250d4-b039-468b-9052-c54a64fb504c	true	display.on.consent.screen
fcb250d4-b039-468b-9052-c54a64fb504c	${samlRoleListScopeConsentText}	consent.screen.text
6977acb4-8b54-432e-b849-816f8c20c04c	true	display.on.consent.screen
6977acb4-8b54-432e-b849-816f8c20c04c	${profileScopeConsentText}	consent.screen.text
6977acb4-8b54-432e-b849-816f8c20c04c	true	include.in.token.scope
43820c2a-045e-4909-a8f2-f65ed2433a7d	true	display.on.consent.screen
43820c2a-045e-4909-a8f2-f65ed2433a7d	${emailScopeConsentText}	consent.screen.text
43820c2a-045e-4909-a8f2-f65ed2433a7d	true	include.in.token.scope
afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	true	display.on.consent.screen
afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	${addressScopeConsentText}	consent.screen.text
afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	true	include.in.token.scope
5fdd6127-2f29-4a63-a405-0fea438c255a	true	display.on.consent.screen
5fdd6127-2f29-4a63-a405-0fea438c255a	${phoneScopeConsentText}	consent.screen.text
5fdd6127-2f29-4a63-a405-0fea438c255a	true	include.in.token.scope
e923f6a9-0cd2-4899-a184-d866bf9756a9	true	display.on.consent.screen
e923f6a9-0cd2-4899-a184-d866bf9756a9	${rolesScopeConsentText}	consent.screen.text
e923f6a9-0cd2-4899-a184-d866bf9756a9	false	include.in.token.scope
97183b7b-2c55-4fbd-99b3-4837cfbc0b00	false	display.on.consent.screen
97183b7b-2c55-4fbd-99b3-4837cfbc0b00		consent.screen.text
97183b7b-2c55-4fbd-99b3-4837cfbc0b00	false	include.in.token.scope
fa167aac-9554-424f-8b30-4c0297b499d2	false	display.on.consent.screen
fa167aac-9554-424f-8b30-4c0297b499d2	true	include.in.token.scope
815a3e74-387c-4f80-b408-01309615b469	false	display.on.consent.screen
815a3e74-387c-4f80-b408-01309615b469	false	include.in.token.scope
f8859454-c1a8-4f25-815d-8c2f38e11968	false	include.in.token.scope
f8859454-c1a8-4f25-815d-8c2f38e11968	true	display.on.consent.screen
f8859454-c1a8-4f25-815d-8c2f38e11968	${rolesScopeConsentText}	consent.screen.text
33583b6c-e729-4916-9bf6-2a3e3b79100f	${samlRoleListScopeConsentText}	consent.screen.text
33583b6c-e729-4916-9bf6-2a3e3b79100f	true	display.on.consent.screen
811127fe-927b-4211-b57f-b0ded9b327ef	false	include.in.token.scope
811127fe-927b-4211-b57f-b0ded9b327ef	false	display.on.consent.screen
811127fe-927b-4211-b57f-b0ded9b327ef		consent.screen.text
2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	true	include.in.token.scope
2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	false	display.on.consent.screen
ff02e659-87de-4b64-9207-c64548a8d463	true	include.in.token.scope
ff02e659-87de-4b64-9207-c64548a8d463	true	display.on.consent.screen
ff02e659-87de-4b64-9207-c64548a8d463	${profileScopeConsentText}	consent.screen.text
b0fe611c-3950-44df-832b-14e0814a70aa	false	include.in.token.scope
b0fe611c-3950-44df-832b-14e0814a70aa	false	display.on.consent.screen
7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	true	include.in.token.scope
7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	true	display.on.consent.screen
7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	${addressScopeConsentText}	consent.screen.text
0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	${offlineAccessScopeConsentText}	consent.screen.text
0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	true	display.on.consent.screen
d4320bae-9ace-4165-b177-a00033b8fbdb	true	include.in.token.scope
d4320bae-9ace-4165-b177-a00033b8fbdb	true	display.on.consent.screen
d4320bae-9ace-4165-b177-a00033b8fbdb	${phoneScopeConsentText}	consent.screen.text
03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	true	include.in.token.scope
03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	true	display.on.consent.screen
03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	${emailScopeConsentText}	consent.screen.text
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
530aa4ab-ff70-4256-8abb-0a905d775a99	e923f6a9-0cd2-4899-a184-d866bf9756a9	t
530aa4ab-ff70-4256-8abb-0a905d775a99	6977acb4-8b54-432e-b849-816f8c20c04c	t
530aa4ab-ff70-4256-8abb-0a905d775a99	815a3e74-387c-4f80-b408-01309615b469	t
530aa4ab-ff70-4256-8abb-0a905d775a99	97183b7b-2c55-4fbd-99b3-4837cfbc0b00	t
530aa4ab-ff70-4256-8abb-0a905d775a99	43820c2a-045e-4909-a8f2-f65ed2433a7d	t
530aa4ab-ff70-4256-8abb-0a905d775a99	5fdd6127-2f29-4a63-a405-0fea438c255a	f
530aa4ab-ff70-4256-8abb-0a905d775a99	afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	f
530aa4ab-ff70-4256-8abb-0a905d775a99	07ab3675-42f8-4b10-b192-8ccd1b2d585c	f
530aa4ab-ff70-4256-8abb-0a905d775a99	fa167aac-9554-424f-8b30-4c0297b499d2	f
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	e923f6a9-0cd2-4899-a184-d866bf9756a9	t
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	6977acb4-8b54-432e-b849-816f8c20c04c	t
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	815a3e74-387c-4f80-b408-01309615b469	t
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	97183b7b-2c55-4fbd-99b3-4837cfbc0b00	t
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	43820c2a-045e-4909-a8f2-f65ed2433a7d	t
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	5fdd6127-2f29-4a63-a405-0fea438c255a	f
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	f
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	07ab3675-42f8-4b10-b192-8ccd1b2d585c	f
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	fa167aac-9554-424f-8b30-4c0297b499d2	f
adc7cfaa-ca92-4e9a-adb1-6eb90c9bba02	e923f6a9-0cd2-4899-a184-d866bf9756a9	t
adc7cfaa-ca92-4e9a-adb1-6eb90c9bba02	6977acb4-8b54-432e-b849-816f8c20c04c	t
adc7cfaa-ca92-4e9a-adb1-6eb90c9bba02	815a3e74-387c-4f80-b408-01309615b469	t
adc7cfaa-ca92-4e9a-adb1-6eb90c9bba02	97183b7b-2c55-4fbd-99b3-4837cfbc0b00	t
adc7cfaa-ca92-4e9a-adb1-6eb90c9bba02	43820c2a-045e-4909-a8f2-f65ed2433a7d	t
adc7cfaa-ca92-4e9a-adb1-6eb90c9bba02	5fdd6127-2f29-4a63-a405-0fea438c255a	f
adc7cfaa-ca92-4e9a-adb1-6eb90c9bba02	afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	f
adc7cfaa-ca92-4e9a-adb1-6eb90c9bba02	07ab3675-42f8-4b10-b192-8ccd1b2d585c	f
adc7cfaa-ca92-4e9a-adb1-6eb90c9bba02	fa167aac-9554-424f-8b30-4c0297b499d2	f
82ccf254-bfc4-462b-97e1-50f2595b7f06	e923f6a9-0cd2-4899-a184-d866bf9756a9	t
82ccf254-bfc4-462b-97e1-50f2595b7f06	6977acb4-8b54-432e-b849-816f8c20c04c	t
82ccf254-bfc4-462b-97e1-50f2595b7f06	815a3e74-387c-4f80-b408-01309615b469	t
82ccf254-bfc4-462b-97e1-50f2595b7f06	97183b7b-2c55-4fbd-99b3-4837cfbc0b00	t
82ccf254-bfc4-462b-97e1-50f2595b7f06	43820c2a-045e-4909-a8f2-f65ed2433a7d	t
82ccf254-bfc4-462b-97e1-50f2595b7f06	5fdd6127-2f29-4a63-a405-0fea438c255a	f
82ccf254-bfc4-462b-97e1-50f2595b7f06	afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	f
82ccf254-bfc4-462b-97e1-50f2595b7f06	07ab3675-42f8-4b10-b192-8ccd1b2d585c	f
82ccf254-bfc4-462b-97e1-50f2595b7f06	fa167aac-9554-424f-8b30-4c0297b499d2	f
3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	e923f6a9-0cd2-4899-a184-d866bf9756a9	t
3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	6977acb4-8b54-432e-b849-816f8c20c04c	t
3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	815a3e74-387c-4f80-b408-01309615b469	t
3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	97183b7b-2c55-4fbd-99b3-4837cfbc0b00	t
3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	43820c2a-045e-4909-a8f2-f65ed2433a7d	t
3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	5fdd6127-2f29-4a63-a405-0fea438c255a	f
3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	f
3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	07ab3675-42f8-4b10-b192-8ccd1b2d585c	f
3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	fa167aac-9554-424f-8b30-4c0297b499d2	f
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	e923f6a9-0cd2-4899-a184-d866bf9756a9	t
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	6977acb4-8b54-432e-b849-816f8c20c04c	t
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	815a3e74-387c-4f80-b408-01309615b469	t
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	97183b7b-2c55-4fbd-99b3-4837cfbc0b00	t
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	43820c2a-045e-4909-a8f2-f65ed2433a7d	t
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	5fdd6127-2f29-4a63-a405-0fea438c255a	f
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	f
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	07ab3675-42f8-4b10-b192-8ccd1b2d585c	f
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	fa167aac-9554-424f-8b30-4c0297b499d2	f
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	811127fe-927b-4211-b57f-b0ded9b327ef	t
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	b0fe611c-3950-44df-832b-14e0814a70aa	t
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	f8859454-c1a8-4f25-815d-8c2f38e11968	t
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	ff02e659-87de-4b64-9207-c64548a8d463	t
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	t
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	f
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	d4320bae-9ace-4165-b177-a00033b8fbdb	f
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	f
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	f
74b39df6-1c8b-4e84-8251-5771ca6a6470	811127fe-927b-4211-b57f-b0ded9b327ef	t
74b39df6-1c8b-4e84-8251-5771ca6a6470	b0fe611c-3950-44df-832b-14e0814a70aa	t
74b39df6-1c8b-4e84-8251-5771ca6a6470	f8859454-c1a8-4f25-815d-8c2f38e11968	t
74b39df6-1c8b-4e84-8251-5771ca6a6470	ff02e659-87de-4b64-9207-c64548a8d463	t
74b39df6-1c8b-4e84-8251-5771ca6a6470	03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	t
74b39df6-1c8b-4e84-8251-5771ca6a6470	7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	f
74b39df6-1c8b-4e84-8251-5771ca6a6470	d4320bae-9ace-4165-b177-a00033b8fbdb	f
74b39df6-1c8b-4e84-8251-5771ca6a6470	0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	f
74b39df6-1c8b-4e84-8251-5771ca6a6470	2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	f
9c411dbd-4e42-431f-9093-f8c77db6966f	811127fe-927b-4211-b57f-b0ded9b327ef	t
9c411dbd-4e42-431f-9093-f8c77db6966f	b0fe611c-3950-44df-832b-14e0814a70aa	t
9c411dbd-4e42-431f-9093-f8c77db6966f	f8859454-c1a8-4f25-815d-8c2f38e11968	t
9c411dbd-4e42-431f-9093-f8c77db6966f	ff02e659-87de-4b64-9207-c64548a8d463	t
9c411dbd-4e42-431f-9093-f8c77db6966f	03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	t
9c411dbd-4e42-431f-9093-f8c77db6966f	7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	f
9c411dbd-4e42-431f-9093-f8c77db6966f	d4320bae-9ace-4165-b177-a00033b8fbdb	f
9c411dbd-4e42-431f-9093-f8c77db6966f	0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	f
9c411dbd-4e42-431f-9093-f8c77db6966f	2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	f
92f5bea7-369a-483d-a9ea-a330f05968b5	811127fe-927b-4211-b57f-b0ded9b327ef	t
92f5bea7-369a-483d-a9ea-a330f05968b5	b0fe611c-3950-44df-832b-14e0814a70aa	t
92f5bea7-369a-483d-a9ea-a330f05968b5	f8859454-c1a8-4f25-815d-8c2f38e11968	t
92f5bea7-369a-483d-a9ea-a330f05968b5	ff02e659-87de-4b64-9207-c64548a8d463	t
92f5bea7-369a-483d-a9ea-a330f05968b5	7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	f
92f5bea7-369a-483d-a9ea-a330f05968b5	0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	f
92f5bea7-369a-483d-a9ea-a330f05968b5	2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	f
80710076-562f-4877-bf9c-7a005d70367b	811127fe-927b-4211-b57f-b0ded9b327ef	t
80710076-562f-4877-bf9c-7a005d70367b	b0fe611c-3950-44df-832b-14e0814a70aa	t
80710076-562f-4877-bf9c-7a005d70367b	f8859454-c1a8-4f25-815d-8c2f38e11968	t
80710076-562f-4877-bf9c-7a005d70367b	ff02e659-87de-4b64-9207-c64548a8d463	t
80710076-562f-4877-bf9c-7a005d70367b	03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	t
80710076-562f-4877-bf9c-7a005d70367b	7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	f
80710076-562f-4877-bf9c-7a005d70367b	d4320bae-9ace-4165-b177-a00033b8fbdb	f
80710076-562f-4877-bf9c-7a005d70367b	0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	f
80710076-562f-4877-bf9c-7a005d70367b	2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	f
39610acb-a894-4f24-811f-08d0590f7f79	811127fe-927b-4211-b57f-b0ded9b327ef	t
39610acb-a894-4f24-811f-08d0590f7f79	b0fe611c-3950-44df-832b-14e0814a70aa	t
39610acb-a894-4f24-811f-08d0590f7f79	f8859454-c1a8-4f25-815d-8c2f38e11968	t
39610acb-a894-4f24-811f-08d0590f7f79	ff02e659-87de-4b64-9207-c64548a8d463	t
39610acb-a894-4f24-811f-08d0590f7f79	03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	t
39610acb-a894-4f24-811f-08d0590f7f79	7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	f
39610acb-a894-4f24-811f-08d0590f7f79	d4320bae-9ace-4165-b177-a00033b8fbdb	f
39610acb-a894-4f24-811f-08d0590f7f79	0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	f
39610acb-a894-4f24-811f-08d0590f7f79	2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	f
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	811127fe-927b-4211-b57f-b0ded9b327ef	t
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	b0fe611c-3950-44df-832b-14e0814a70aa	t
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	f8859454-c1a8-4f25-815d-8c2f38e11968	t
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	ff02e659-87de-4b64-9207-c64548a8d463	t
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	t
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	f
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	d4320bae-9ace-4165-b177-a00033b8fbdb	f
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	f
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	f
92f5bea7-369a-483d-a9ea-a330f05968b5	03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	f
92f5bea7-369a-483d-a9ea-a330f05968b5	d4320bae-9ace-4165-b177-a00033b8fbdb	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_scope_role_mapping (scope_id, role_id) FROM stdin;
07ab3675-42f8-4b10-b192-8ccd1b2d585c	de5a54e6-b775-4742-afa3-0572fbcfe48d
0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	e873c552-e603-456e-abbf-121bc85963df
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
ab9fda5f-46a5-429a-9dc2-046a301265eb	Trusted Hosts	a7ba7779-875b-4788-99a3-328f298d05b3	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7ba7779-875b-4788-99a3-328f298d05b3	anonymous
6a2e607a-eeea-4b13-9dc4-6e28ebb6cb34	Consent Required	a7ba7779-875b-4788-99a3-328f298d05b3	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7ba7779-875b-4788-99a3-328f298d05b3	anonymous
a30ba79e-27d3-4ca7-a6a7-72092d9834d0	Full Scope Disabled	a7ba7779-875b-4788-99a3-328f298d05b3	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7ba7779-875b-4788-99a3-328f298d05b3	anonymous
ed01e19f-4333-4730-a11e-604084a6bff4	Max Clients Limit	a7ba7779-875b-4788-99a3-328f298d05b3	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7ba7779-875b-4788-99a3-328f298d05b3	anonymous
18679e9a-bf57-4262-940b-80060b0dd0a6	Allowed Protocol Mapper Types	a7ba7779-875b-4788-99a3-328f298d05b3	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7ba7779-875b-4788-99a3-328f298d05b3	anonymous
e1fcf90b-93f0-4100-8b04-abbe1cf6e517	Allowed Client Scopes	a7ba7779-875b-4788-99a3-328f298d05b3	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7ba7779-875b-4788-99a3-328f298d05b3	anonymous
26b6f7fd-046a-41a4-a8b2-ff2bdff972b0	Allowed Protocol Mapper Types	a7ba7779-875b-4788-99a3-328f298d05b3	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7ba7779-875b-4788-99a3-328f298d05b3	authenticated
0fe50638-3ae4-49c3-8806-e7cccfc22d6d	Allowed Client Scopes	a7ba7779-875b-4788-99a3-328f298d05b3	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7ba7779-875b-4788-99a3-328f298d05b3	authenticated
59903dbb-1555-44af-96e7-a615979dcdfb	rsa-generated	a7ba7779-875b-4788-99a3-328f298d05b3	rsa-generated	org.keycloak.keys.KeyProvider	a7ba7779-875b-4788-99a3-328f298d05b3	\N
7d3a3577-3fa4-4d7f-bc1d-f068bf54a7db	rsa-enc-generated	a7ba7779-875b-4788-99a3-328f298d05b3	rsa-enc-generated	org.keycloak.keys.KeyProvider	a7ba7779-875b-4788-99a3-328f298d05b3	\N
27ec18ee-0aa2-49ba-aedc-d40acb436850	hmac-generated	a7ba7779-875b-4788-99a3-328f298d05b3	hmac-generated	org.keycloak.keys.KeyProvider	a7ba7779-875b-4788-99a3-328f298d05b3	\N
34dff816-9350-49af-a74e-a4ca88f1c193	aes-generated	a7ba7779-875b-4788-99a3-328f298d05b3	aes-generated	org.keycloak.keys.KeyProvider	a7ba7779-875b-4788-99a3-328f298d05b3	\N
2fd66a4a-e362-4ceb-917c-46d00ee2a48b	Allowed Protocol Mapper Types	8eee160c-5edd-481a-b964-c368a057e598	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8eee160c-5edd-481a-b964-c368a057e598	anonymous
db9cc60b-3b35-43fb-9885-295ba1569a4f	Allowed Protocol Mapper Types	8eee160c-5edd-481a-b964-c368a057e598	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8eee160c-5edd-481a-b964-c368a057e598	authenticated
39f459e5-64a3-41bc-aa87-b1f81ed16008	Trusted Hosts	8eee160c-5edd-481a-b964-c368a057e598	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8eee160c-5edd-481a-b964-c368a057e598	anonymous
8e4d7c26-f257-455f-98d0-d61c5cae63d1	Allowed Client Scopes	8eee160c-5edd-481a-b964-c368a057e598	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8eee160c-5edd-481a-b964-c368a057e598	authenticated
b30f4500-a433-4eb3-87a1-48f8f582f896	Max Clients Limit	8eee160c-5edd-481a-b964-c368a057e598	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8eee160c-5edd-481a-b964-c368a057e598	anonymous
0dc1f5b0-e2f9-4596-8b2d-f6141a619239	Consent Required	8eee160c-5edd-481a-b964-c368a057e598	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8eee160c-5edd-481a-b964-c368a057e598	anonymous
741ed740-e1c2-46bc-9f8e-6e6dc6817dd0	Full Scope Disabled	8eee160c-5edd-481a-b964-c368a057e598	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8eee160c-5edd-481a-b964-c368a057e598	anonymous
48a49652-05f7-420c-93a0-c60452f1d006	Allowed Client Scopes	8eee160c-5edd-481a-b964-c368a057e598	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8eee160c-5edd-481a-b964-c368a057e598	anonymous
0b19ca7e-e573-421a-b588-370966a024a5	aes-generated	8eee160c-5edd-481a-b964-c368a057e598	aes-generated	org.keycloak.keys.KeyProvider	8eee160c-5edd-481a-b964-c368a057e598	\N
28f7555a-f8e8-4e21-8e43-5916ed429afc	hmac-generated	8eee160c-5edd-481a-b964-c368a057e598	hmac-generated	org.keycloak.keys.KeyProvider	8eee160c-5edd-481a-b964-c368a057e598	\N
e19679f4-bdea-4911-bf47-10fd78276042	rsa-generated	8eee160c-5edd-481a-b964-c368a057e598	rsa-generated	org.keycloak.keys.KeyProvider	8eee160c-5edd-481a-b964-c368a057e598	\N
55a4e627-b217-4d4b-ba34-53543be4b53c	rsa-enc-generated	8eee160c-5edd-481a-b964-c368a057e598	rsa-enc-generated	org.keycloak.keys.KeyProvider	8eee160c-5edd-481a-b964-c368a057e598	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.component_config (id, component_id, name, value) FROM stdin;
d4a60805-4be4-4bce-8fdb-02489a6a20ea	26b6f7fd-046a-41a4-a8b2-ff2bdff972b0	allowed-protocol-mapper-types	saml-role-list-mapper
2efb84a6-93f6-435d-ac62-9e09f5a9779a	26b6f7fd-046a-41a4-a8b2-ff2bdff972b0	allowed-protocol-mapper-types	oidc-address-mapper
b981a2c4-64d1-4664-b843-f4de037641b0	26b6f7fd-046a-41a4-a8b2-ff2bdff972b0	allowed-protocol-mapper-types	saml-user-attribute-mapper
e864e273-f872-43f9-b4b6-075b0dd5d652	26b6f7fd-046a-41a4-a8b2-ff2bdff972b0	allowed-protocol-mapper-types	saml-user-property-mapper
7c9ce9b5-7745-4c82-8ca2-267982687b12	26b6f7fd-046a-41a4-a8b2-ff2bdff972b0	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
18cf4ed4-504d-4f40-80b4-2575aee2906b	26b6f7fd-046a-41a4-a8b2-ff2bdff972b0	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
35211df5-78f6-49fb-a6ee-074dca7805b2	26b6f7fd-046a-41a4-a8b2-ff2bdff972b0	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
4f82fb0c-3293-45e7-a254-fa1c43a63071	26b6f7fd-046a-41a4-a8b2-ff2bdff972b0	allowed-protocol-mapper-types	oidc-full-name-mapper
eecdd5f7-8ab9-4092-913f-d4923864285f	ed01e19f-4333-4730-a11e-604084a6bff4	max-clients	200
dda9b8f9-f157-4b05-9146-df4f985cab94	18679e9a-bf57-4262-940b-80060b0dd0a6	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
17dcfff8-b0ab-4565-a344-e211646071af	18679e9a-bf57-4262-940b-80060b0dd0a6	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
b4befcfd-7173-4399-8d85-bdc533418298	18679e9a-bf57-4262-940b-80060b0dd0a6	allowed-protocol-mapper-types	saml-user-property-mapper
0504e94d-0574-4434-bc82-8ece3ac2fcb4	18679e9a-bf57-4262-940b-80060b0dd0a6	allowed-protocol-mapper-types	oidc-full-name-mapper
060b7de1-94a6-462f-91d1-8f3f0f361921	18679e9a-bf57-4262-940b-80060b0dd0a6	allowed-protocol-mapper-types	oidc-address-mapper
287950d1-b28f-4c74-aca4-117042cf1ca6	18679e9a-bf57-4262-940b-80060b0dd0a6	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
ac437d60-c1de-4f23-9d35-b69b04ad6bad	18679e9a-bf57-4262-940b-80060b0dd0a6	allowed-protocol-mapper-types	saml-role-list-mapper
86b1de1f-6f4b-4f4d-b024-49f087557fd4	18679e9a-bf57-4262-940b-80060b0dd0a6	allowed-protocol-mapper-types	saml-user-attribute-mapper
f60ffded-f120-4736-981e-cc81211845b4	0fe50638-3ae4-49c3-8806-e7cccfc22d6d	allow-default-scopes	true
7891d0ae-be64-400e-addb-b38b28e81682	ab9fda5f-46a5-429a-9dc2-046a301265eb	client-uris-must-match	true
fb8c35e8-edb0-413a-b791-c8e91766fb44	ab9fda5f-46a5-429a-9dc2-046a301265eb	host-sending-registration-request-must-match	true
ce16c3f4-978a-473c-b5e5-c645d38373bd	e1fcf90b-93f0-4100-8b04-abbe1cf6e517	allow-default-scopes	true
007c9c3e-6cfe-4c9b-a666-8df664c9ad46	34dff816-9350-49af-a74e-a4ca88f1c193	kid	fd6aa87c-2351-4dc3-9fb5-f31fd7d15caf
96f8bec6-a86f-4844-892d-0e549373fc97	34dff816-9350-49af-a74e-a4ca88f1c193	secret	mQp3WQGgaZaPbazebKNVQg
4686ebed-ce2f-461d-ae2f-26535ba9dc3c	34dff816-9350-49af-a74e-a4ca88f1c193	priority	100
de1f5950-cce5-4c79-b8da-4ae996eb311f	59903dbb-1555-44af-96e7-a615979dcdfb	keyUse	SIG
eef7fc2b-0327-4361-8516-c72c906cf240	59903dbb-1555-44af-96e7-a615979dcdfb	certificate	MIICmzCCAYMCBgGKyH7VqDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwOTI0MTgzOTMwWhcNMzMwOTI0MTg0MTEwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDEQ6WfLyLejOLlhqqQcLQlw3occUab/Slqfzw1aalHbWJUl4cwm+EajdotItEqN9hfgoTkwPlEK3J+IO1zv7PJkDblIjVM9aGRYZzfftlkh4HapoGDjIAwsIzwXO60tyfOX+/c4v08U8P7e59XDDbNQwmoRWRy0ulGJETTnGlkRGrfNu+fpbbyxaTu6dB6PSeW9DKsWc2crEeXI0Esc2VGKPPlVBK/6lFPheFfvrkvpqZ4n1YUUBAA5E2i13KZNkf6jqHS4NbKUF0J6OcUT7ZeHHkDWO2iiEadwqPZ5PTWL5EWPNdVwKzsQd0uaw+DqBeebQklf5cXGdXGpSqB0WEPAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFApnosoaz/YTS6VN2+zMjgx2qY7YPf2Dxw6pZxXcQm+5BViU9GXqElyptJxD/jsttfZLG/7w8xn4DUGaG80lfr1BeGv5JP44Wj5PnFYP3vpEtTPgCqFdUqLQYfv+JeG730PwIbyqaudgKa2pbnl4RpeHmvXviO2o1aHShKHttBevgtrAZbAMy2Q2X6Dsy7s0oKGbFmLfwQEbnh8rrfekZmP1CHisJ6ddX6KLiTHsdTwfLXNW8IvaSgVobIiCEQavvMrIJU7dxgQHD712DAn6A4dousZGY4EN4MsgZQBNuI5IHwakAkCVQSre3EZLuTeCxpGzqC8GOXxAoIXP/x+7Xs=
298675de-982a-4aec-8fd4-7f2b02c0bdd3	59903dbb-1555-44af-96e7-a615979dcdfb	priority	100
04910fb4-881a-4c32-8173-2f34ce02008e	59903dbb-1555-44af-96e7-a615979dcdfb	privateKey	MIIEpAIBAAKCAQEAxEOlny8i3ozi5YaqkHC0JcN6HHFGm/0pan88NWmpR21iVJeHMJvhGo3aLSLRKjfYX4KE5MD5RCtyfiDtc7+zyZA25SI1TPWhkWGc337ZZIeB2qaBg4yAMLCM8FzutLcnzl/v3OL9PFPD+3ufVww2zUMJqEVkctLpRiRE05xpZERq3zbvn6W28sWk7unQej0nlvQyrFnNnKxHlyNBLHNlRijz5VQSv+pRT4XhX765L6ameJ9WFFAQAORNotdymTZH+o6h0uDWylBdCejnFE+2Xhx5A1jtoohGncKj2eT01i+RFjzXVcCs7EHdLmsPg6gXnm0JJX+XFxnVxqUqgdFhDwIDAQABAoIBAFib5Agw+1C4Ee6ntJUe1S6hiR2TRNpDW7IBvNiumict6vGfMgGPtvtKpQCw0fd6HB3O6xnuR/vvk7L/QcV6/PxZOHeN0LuswGPHStCa0CJzjXx+pUWTpwKUiyUwB/OeJ4IkzUIQV12nwfll8GQYFxvoEtGedsHimEA7OrnBSdHiyU4PEn+6AI22kt/9faIXUtvWeOuiQHhAI3PI07ZqZJIoFF4OcQszXSqlSVt7AHDvnYgiXGciMMs8XG9CYOcZ1vaDHIdckkPgYrelmThVt+W1uP1G6BihymbP4Lh0NCPL8hs3ieT16tPw93TyP86pq+xjY17N6EvdPJqMV64fKb0CgYEA53TtJ5j2f887Hv4KnoLVeq+BGz5ogGOjNVCb00g4P92QpOf0y4xsXkWKfNc734ohFcIiujTlu2hR+KodyrXYGPvuXlvyETBQIAWQJgfITs0JX/YdNoCWg6hBiymlBo9lW4c0sD4M4Ip3zy8pTy368IBozcsPQj/KPbn24Z7/aG0CgYEA2RNkjw8GY/9lb4Or8sEOyPuY5O1AR9dacjSQpeO6cpWGBtJ38JfhzsUJ8x7RxA5XIVZyL+0LuKpvyYw3t/Ev+P6QmCnmDubfa6NXiiXvozxkWxaR1qxUdqFM7cn37qg+0UjrRXYN2+Vxwel9rWD+TtM8CPrHnuQpxrqfC+pleesCgYEAvdUJmRt8uLDHhZDINt+JpZkCI80Yuox91IFrfGtULxVSx92yyas/SkZw4hlJcvsATa8u+lfeP8m8yV0FGDfyp/MguuVgcTaV0N2fL4HciLzjvn/Fz+jBCfRa5X9faTT85YfL7+zEdPk8cIH2uIk2skAvNPIhbq2Q+vVmBgB47DUCgYAXy5hqVitNKuHjp3th0OfeADZyYc96EJFJk5mHlb8KcHmQpeGf7gZCtDay/93er/O9I8zAlCuEwqoeXdB9yWKI2N7gzzb4yzYShoVCD4aFTklx8rdp4NohZu0X49vZvXelWWjw5FAAmtYte3rbVpaJ7X3XPiZDtJ8fubVViQw2oQKBgQDDKyAfLzysjQXm9eAoXWHl4BmKoTxWTMZZ6+ZZqOUDo3gAGbo32XOAymGF/7V0K+M3DrviTv4dFavNYnkcl8+fpsPsBEL5zKuG9syQSTeHL7E7dAY+B1S0x7lxNFP9v+asXj5NbU5lZbN5IseMskmnoJe2iiKpeXmFVjpB7JJs6Q==
133064e5-ad86-415c-b2c3-7474eb641b71	7d3a3577-3fa4-4d7f-bc1d-f068bf54a7db	priority	100
65cef1d0-1de2-4766-a8a8-a778d95de4e8	7d3a3577-3fa4-4d7f-bc1d-f068bf54a7db	certificate	MIICmzCCAYMCBgGKyH7XtDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwOTI0MTgzOTMwWhcNMzMwOTI0MTg0MTEwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDB5f6OwzHqngbiCX7djXEttWhtBwT6e/ob11KPvWIPLOmf66TIAnuFE14g7nM9AzfcCLoA9QQtV3StuuWAtuAi6Ef/VsSXLfejYkA+O8c6ssQ5HaH2FfxKM4MDDH8d1EcIAJ7Q7Iemcycb/VHQC8MqzI27s9TanKKJpaleyPpomOvBKvIIu3nESjxZTR2iRfrKZoocEcXfFCDgyL80hmusFx6VjwRsx5Xe4UVjWtAFgiiUmBaGVFFJdOutlJqSbPiEy75VnGrmynxMa/rBTYwrP71DvvxCWBPljW/LX61Yy6+9ra6n6E2sev6feiRKxGCvJihIKWGZMVcGHYGe+G1RAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAKReuBItg5vA60EC1UKnwBxM3VZdVI7wvuAJZXtegcB2qUHAUaHof52sufpusVeBjw+1dpA3pV604GZKcucY2o5TUQA9k1nKo6X+dwMs7HO9ANDeF7un9u8JAwoGDEivyl5zAycsqrmeOMBaUzPWBrlUaQTzVLcf9sSsmWTz4MGB8odCboXRrfLFSzpaNNFhAmwWOs6RoDqaHt+PuNX8AnKvXOZxvbD6yLCtpgh9oO+dJVkqIepJGKcW4VrZSHX1Y8qwl6V3tuyEf4HyCQ7TnKcPyjETLxLrbeWRcnyHcdP7MlV0jNTnFgljrke0q8BiGDBOhbnxGdfHrTXpNa+JWkU=
b3641496-76e3-4eb4-81de-072e9541bb83	7d3a3577-3fa4-4d7f-bc1d-f068bf54a7db	privateKey	MIIEowIBAAKCAQEAweX+jsMx6p4G4gl+3Y1xLbVobQcE+nv6G9dSj71iDyzpn+ukyAJ7hRNeIO5zPQM33Ai6APUELVd0rbrlgLbgIuhH/1bEly33o2JAPjvHOrLEOR2h9hX8SjODAwx/HdRHCACe0OyHpnMnG/1R0AvDKsyNu7PU2pyiiaWpXsj6aJjrwSryCLt5xEo8WU0dokX6ymaKHBHF3xQg4Mi/NIZrrBcelY8EbMeV3uFFY1rQBYIolJgWhlRRSXTrrZSakmz4hMu+VZxq5sp8TGv6wU2MKz+9Q778QlgT5Y1vy1+tWMuvva2up+hNrHr+n3okSsRgryYoSClhmTFXBh2BnvhtUQIDAQABAoIBACD+MS/6n9JDvHkW04sAZ8s2zIOMx7iVguvc2jQSLg7V/hTTpHDSF1GAB6rD2ED//K/InlnOVz0d3gE3xZh+xam665FTotT0oegfrj3IrzBaPdBYLfhxKkI3/Kl2pWSee82tSVjUfoqAmp2FH7guYDG2p8FSKrxeHbwdP7IcsZs9aey4eqRliADOiMBCRWisSQvdNLf3x+HthFk9zXpu7nE/EM6iShZBd09oI6irEgLGu5D4h1lEF6EaIAsaoPqfJoK5aKHlVhfxEyCTugPvyMSR2pudbexa5oLPrhg9esbtc2lSMPUcKTWeDsc4EB5zKRQJ7FrLwCEbLNnItZ88ro8CgYEA9K18VuyJ67Nq9STwzgkE8DiMNOyII6XaUrkSIoRyhldQsvKpJ32tMio9W3p6ndJ9E/KkY1MtiUncQp3c+xLa0K7ARTjFgJrP1DCQDy+Inm4N5IIJe0LB47q80j7Rl7WncRW/CQsN3MPJOnrtnOxrDTz/Sp5zZ97VpgEYRHNtR+cCgYEAyt727BSr27hcweCsBhHxlWhUhGFgVpmQtmOgX6QS0dkzJDbCQ4mKxZKEO27MjXpi3Jo8gscVuhgBOWJMrZOQJ8UmkKuqF8GAV7M0GBzj+/PXCblFiE2zTNXKegl+jdQUaI6TCEvHjUzBgVsV/CASp1AnM4EBp0tVUnCGTYciGgcCgYApO2MMsue7FI0dqo/56IMwiBb4hDOc7kIQVqe7sV4rTWOIBGSFByS8o2mblNQ87E+voOAa7NVroUrA3yFyHgdJy2kTQTHnLi9/rn9YT8ZSDHHC5Db80o8h9UIEnBlt22rQH74FpBs97LBobnbETwLrRDAxPuprwp12UBDq2Bi+WQKBgAsn/8Qzzs+ib9dpl4wt6G8i8aLmB/o7L64YBHW9/Br2Ks3PBRfZtHvw9ryd9znAhTdEdBdtA1DciRSyxyy0dLT7Loe+KPhtd7Va8X5x+EeevTCXs68vNrD/AMd9RixegVDOpl9Ka4rlsa5/Z9IZoWz6B23ZplGg3uxNq9UPnVx5AoGBAOBpZHD8XU/JPMpsRpQB2oFQvZk35uijzCEiO1ea8trWP8i67pTW5QV5DVw25MUjcEoQQ0Tf8M0jY/QmUNvdr3hv8yZaVzAnwtg9lW2My/LwDjp3ikH9tnrf6XGPmvav2Gp1RQ+4CM+EXEDTXtPN4fnDDfrHzeJYzU7yJJaifip6
445fe9b9-ab26-47ef-b2fa-65a62b3f8a97	7d3a3577-3fa4-4d7f-bc1d-f068bf54a7db	keyUse	ENC
04e92a43-5cb1-4b65-b911-00087968e76e	7d3a3577-3fa4-4d7f-bc1d-f068bf54a7db	algorithm	RSA-OAEP
e13b9134-ee22-4627-b0e2-5cb23dde3dc5	27ec18ee-0aa2-49ba-aedc-d40acb436850	kid	868ffdb3-dfe0-46a4-8cd7-46f76a6e6b4b
12d0cd9f-eb29-4c79-84e8-df2f5834768c	27ec18ee-0aa2-49ba-aedc-d40acb436850	priority	100
7508f61e-f673-40ab-be2c-ae20920938eb	27ec18ee-0aa2-49ba-aedc-d40acb436850	algorithm	HS256
b36b13db-5ed0-4165-89e1-1c02def3f8f7	27ec18ee-0aa2-49ba-aedc-d40acb436850	secret	Qr75g1-EUGB0JANUNtwwawQtS2Io0E3-Th14wbx_AQL-zD1KnUqkcymT7NnPH-28FOShoWObwLIAtqgtwcFVYw
38c82620-38d5-49ac-beac-b6e0c341273d	2fd66a4a-e362-4ceb-917c-46d00ee2a48b	allowed-protocol-mapper-types	saml-user-property-mapper
fb11ef8e-e33e-4be3-8ac2-f6db5259dd05	2fd66a4a-e362-4ceb-917c-46d00ee2a48b	allowed-protocol-mapper-types	saml-role-list-mapper
ea496a56-658d-4ebb-95ec-edc24b94deca	2fd66a4a-e362-4ceb-917c-46d00ee2a48b	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
e778be78-d22d-40bf-8072-687f8072417c	2fd66a4a-e362-4ceb-917c-46d00ee2a48b	allowed-protocol-mapper-types	saml-user-attribute-mapper
16303877-7e56-4d50-8095-c86583fee94d	2fd66a4a-e362-4ceb-917c-46d00ee2a48b	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
da5a8200-19f0-4922-a057-d21391840e76	2fd66a4a-e362-4ceb-917c-46d00ee2a48b	allowed-protocol-mapper-types	oidc-address-mapper
5b0b1b59-c97c-49a4-8a18-cf93266381bd	2fd66a4a-e362-4ceb-917c-46d00ee2a48b	allowed-protocol-mapper-types	oidc-full-name-mapper
18cd456a-e3e3-48cc-bcd3-91dcd318ac31	2fd66a4a-e362-4ceb-917c-46d00ee2a48b	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
a518d9af-8432-4fdc-b201-8b7042337b5f	db9cc60b-3b35-43fb-9885-295ba1569a4f	allowed-protocol-mapper-types	saml-user-attribute-mapper
c195ec53-ec3f-4b92-b27d-e965a58ba769	db9cc60b-3b35-43fb-9885-295ba1569a4f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
9c0b0141-da01-4071-8eb5-fcf5dc6e17a1	db9cc60b-3b35-43fb-9885-295ba1569a4f	allowed-protocol-mapper-types	oidc-address-mapper
03ae4f81-6783-4d4a-a511-fa8cc5e03ad7	db9cc60b-3b35-43fb-9885-295ba1569a4f	allowed-protocol-mapper-types	oidc-full-name-mapper
44d6dc56-9e20-474d-a199-f6aed5d2ca4e	db9cc60b-3b35-43fb-9885-295ba1569a4f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
bb81ec44-b178-446d-9b62-685e92e3bffd	db9cc60b-3b35-43fb-9885-295ba1569a4f	allowed-protocol-mapper-types	saml-user-property-mapper
57077729-f396-4c67-baff-5cc07dd7bd17	db9cc60b-3b35-43fb-9885-295ba1569a4f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
23d28de2-ab2b-4680-8c06-7a452456bd1e	db9cc60b-3b35-43fb-9885-295ba1569a4f	allowed-protocol-mapper-types	saml-role-list-mapper
f106a378-4d51-4182-a501-1c6e8825e140	0b19ca7e-e573-421a-b588-370966a024a5	secret	zpFK4sLXf-XeJe5hx_N1DA
11a94e01-c4fa-465b-9e30-e0e1e24af323	0b19ca7e-e573-421a-b588-370966a024a5	kid	df80de53-a98f-42f2-ac3f-ff111b0555e1
cdda8768-991e-49e4-9c2c-43a33b51a991	0b19ca7e-e573-421a-b588-370966a024a5	priority	100
cfb726f5-f794-4dbb-8e16-6d729f3fca3b	28f7555a-f8e8-4e21-8e43-5916ed429afc	secret	-imKUS6QkmUWnO5C8bX_nljXsnF0YJSMgCQx8nZw5k7doUbcKElIOqjlKylPGm9CwxaEBGYlmfhTvTIqxxgdqg
93ebc3c5-778a-425d-b7ef-3d56ef249fe4	28f7555a-f8e8-4e21-8e43-5916ed429afc	algorithm	HS256
16042f1b-bb97-4c72-a004-00f0a54e81d8	28f7555a-f8e8-4e21-8e43-5916ed429afc	kid	a0d8415f-a008-4291-aa8a-4a6351e1d61e
0d6ee24b-9dd8-43d4-8d72-73704c219d18	28f7555a-f8e8-4e21-8e43-5916ed429afc	priority	100
454d2ff1-4e2d-46b8-a7ad-b337aed2ad25	39f459e5-64a3-41bc-aa87-b1f81ed16008	host-sending-registration-request-must-match	true
e304ab45-aef8-4d62-b7ed-ae85542f91b4	39f459e5-64a3-41bc-aa87-b1f81ed16008	client-uris-must-match	true
409f6569-655a-40d7-a8cb-e357be98cf03	8e4d7c26-f257-455f-98d0-d61c5cae63d1	allow-default-scopes	true
5915c63e-f059-43f2-bdad-ee138f5a0f36	e19679f4-bdea-4911-bf47-10fd78276042	priority	100
45ee13a4-052e-4634-acf8-6ee361ae45d0	e19679f4-bdea-4911-bf47-10fd78276042	certificate	MIICoTCCAYkCBgGKyH7pQjANBgkqhkiG9w0BAQsFADAUMRIwEAYDVQQDDAlCYWtlclRlY2gwHhcNMjMwOTI0MTgzOTM1WhcNMzMwOTI0MTg0MTE1WjAUMRIwEAYDVQQDDAlCYWtlclRlY2gwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCk0p8Ggy3HQ29dGXluJAK3ynW8xGaMFsQwmAlQIS44MRfaWXdONBbZiPoThhQF+RNQxNs62WOMyCtdsUsyGg0ckPKTc11QrFglu9pljQ95fld1XpPoJyxTdhxEgY9ZMV0OZDKJPh5819/HuxoxEa2zmcNbvphPBpWd3EJoUEQ87akMQi7YMNnYo8ZmWiTo8ycYm366rCfpowVeTQ5MEqnsuY+qwDIM82lbYyXptLRidp5VJiRfJDGfz2R0WA84+6qY3MTzM9if6mY87gVCGa8nJIvcyD1em4K9xR6EBepUPVNt9fX/LNdSNnDZp9q6AIWHzG/+F7tA04zG+8g1lNHjAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAPk2bdKbZy3t3vX+BYAYZJwuOnlEgPqcWqPxJ9kGPim4UANR6g9VGl6QJJjbTJhfu2JHZh++4dt4WUNu9cLViwYzH+tPwvcrwqOeKct8ovg9x0sN3BIw/5VR61CUBGTZjfx/HJuX0PuG7PityJ9ckkqhGdiClQRcPwgg0w5m688pBzktOY6yyL1/zrP9C7itQZTg5K6Fc0VrezWAD7YgRC+0uzW4AsIdCmssx6hqPPUQ/kW6rB08kUQ1Em0iX57TDY5CCFFjVlrdI8DmZmo499nVAb0xs5MZpFb4RZwzhiS0r4zZcBSnPLJCHt8ySp/vSuX0ozIgRG0pbL9oxbfIFg=
eadffed8-3018-490f-ae56-61b62fd5bb72	e19679f4-bdea-4911-bf47-10fd78276042	privateKey	MIIEowIBAAKCAQEApNKfBoMtx0NvXRl5biQCt8p1vMRmjBbEMJgJUCEuODEX2ll3TjQW2Yj6E4YUBfkTUMTbOtljjMgrXbFLMhoNHJDyk3NdUKxYJbvaZY0PeX5XdV6T6CcsU3YcRIGPWTFdDmQyiT4efNffx7saMRGts5nDW76YTwaVndxCaFBEPO2pDEIu2DDZ2KPGZlok6PMnGJt+uqwn6aMFXk0OTBKp7LmPqsAyDPNpW2Ml6bS0YnaeVSYkXyQxn89kdFgPOPuqmNzE8zPYn+pmPO4FQhmvJySL3Mg9XpuCvcUehAXqVD1TbfX1/yzXUjZw2afaugCFh8xv/he7QNOMxvvINZTR4wIDAQABAoIBAD5z4jblALUWu71CmEzgDzmV2OvoXVTqkXc6PJkkoW9ARuIA8WBsA1Z0/RDlxnOG78c0eD9BvONMu4XaVnxK+7ndwFSXq32UeCgAGJ5PB1SJR1ldN10JbtXHFKnuj6MDvddkpvNy2rmCULRNFH0QTkmV0zzRqMOU4p84pN8CvwB4jjch5Uw26MMYf2jZzIRkA10Rdp8dFe++r1LHCXNMwVFwS5IWVVsErxoA2844JdvLxq7YY0XZsSB6+TTJPLHreFkRvIUeL6Pp3ll2TNbBYDn6Z+oNxE2znJtgC9CSdXCZ41MUQ47i5pP+yiNgREBgYYNL5cF7wvk17ZGF654qslkCgYEA6BuVj3bL24wih9nlxX6ZCsQP9HHEwSW6gAphClk6UPB9W+rjPkF5lGaFkUjE9rYHDykUFC14vyA+Mi3/aUKqvlaV+GOQtnX/PjbpZ0n6wEKs3LdBNNWdJDI0eCKNX6gAIuhd0omuxP6kObcWQkPqLMyIhaBFeoZgR6kKmO7gdzkCgYEAtcn3vtkGI8xMb6G3AwyjF1MJXZbJbBDdP0SMIjEkBSZh9DCqes3PfRsXjOqq3X47+mFM+8jmJGZxZBc4DRujbcQk6tnDMni/LidsTCVDFQWlWWwDjYxZoI830JByTKcfUdyaGIegZWCdDdHZhUefeU5sTP1MG0P0JAvEcR06VfsCgYBoicvxopKsXlBLGXOoYJ1zQNzivr7cMy7tbj9Ilulx/O6pEICq0Hh+wzITPlAfwdoqFNlLQTOp+U6p8RehA/q84WiIR+esljaQgdDbyXEbWKxceFjw/+jXnZkOJpm/5H2zOy7OnV5OsVWr/O8Uh1wYM0Kl1IqWZaFFhTgVqzkD2QKBgQC1ORteSVHCnCbS3l7ojk+DsAbVIr23mnRFXxtn9p8W9zWNTnqVI9klub1XgJVHa1F1gExTcOpk/S8q/a6l+piIk5HOAbqC9TZ5V1mx6y+dpFw68d/02yZ6Vmvo4ibf3Xbuj8GalJJEnfTTUxDKuiTztEdo1NZrE+otiQGTVfTSwwKBgFT09ej1Hifh0Dgbo4qa8UguLrYkQZIMjAmfk/tjxcRRMyJbLW/+RmfHGwyV2eidRxXz4OANyXvBYSCFbZ5gIi/JaX0cq4vOvuk9JerzbseiXGiN/m++wzib2jaczEqCIUe1FcmqQPGtxf7nwyjMAPhKWf6ppbuAkqoO2XPuFWMb
b5ed7a72-a3ac-4da9-a610-9058352d832f	b30f4500-a433-4eb3-87a1-48f8f582f896	max-clients	200
b5dcbc9a-10b3-4963-b67f-6e4dbb653d83	48a49652-05f7-420c-93a0-c60452f1d006	allow-default-scopes	true
6117738d-40c7-45aa-90ee-b4ca1d247126	55a4e627-b217-4d4b-ba34-53543be4b53c	algorithm	RSA-OAEP
b4132e63-6150-4296-b169-4c31a2ec37f6	55a4e627-b217-4d4b-ba34-53543be4b53c	privateKey	MIIEoAIBAAKCAQEAlDFZnu7XDOkP/FEh7XGYUCkmnoXMYSQ6vRNBk4B3g+sxDr0u78l4X9NR2lHJN9qo8Z/7mM5sNrL84+xjsvB7yqmqMFi/wYAKVJGUstRV3iqi9tPIHQuldBFnWEu/JRQLP4AlUExfvfmITFAWc1CRlYw4BpbVrOQicVZN7bNRbQ0ACUhTJuFbSN1sZattk+450t4iKcCFEUfUehRyaz/dp46U2BwlqL59TZw47k1L9ll7octKZZpcttgxmVx/iD5l77mpWB2huFsWPIpz5H2O4QOCfFbM9NfNS3XkzfoeJY3TwlIoTT0Mm2eEfCKruaostOe6z4V2RlQC47NHLZicMQIDAQABAoH/bLseMVQMyuw1+RY4+SmKbUZu5ODxlFTWGY8yDjJe0+vnkr48MgkgyS5uYEFMjNlixpEbiS1BOOEbAXXwW4UXTxuC7kuFEUoLn6vb7q+HpqVMl3h224OFYiQNhOYO2VBbmxFAT3+6FSmBV9IV/DChS5jA2BTTsocGE80UYH5cFXuBEffs/laM+GU2cAHwwD4phpvhpg7JV+Qn4e38GOdd4IdxDN+p3Slx9L2IgOmRFZU/xxx0xOrTCMmh/Wj0hk1OXRDzL/jrbfcmHacdjsHRPOt/sbkDz0W2bdqwxVstmbRXxfbTpHkMW2guZmpsBAJmDm5LeS22tPFXItWAO0yZAoGBAMk5PImPOykFA7y6oMNrYrTeAKyj5VrPNjO2b6QmoR7l6WAowPeecq19b4Ka3um/+W+l+tnNRtrhRuTUu45gIoVQ43yN/IgcRT/rOzc0l6m68IA4IMI7Uy874uRB7Q7BJ+9204QY0h3IiZyWjloEBCMisnSVdTMGhWMTQ5uHeyHlAoGBALyIh9FeDCCUyje7jP0rs9f0ftz67BALFUN8bcnqXZoHheD8KHXzXVXmLsVwlK0tT+s8hAZzeRY686ful+5K94llUGjdxS9SpRAhbHOZIR/83RQOTSdNOsNELqpJNG1D2SKQlayw8V+5CFS9A6OT5YeM/SS9KpWiZ6kFH/sQA1xdAoGAX/of6NDbe+47YRp3MZ6XvwMguTeXXt/0z2eWCmqucQlibg4iNDlsI1nwBRCPgFijxeAaLSafRCktYlohd4BdFs+FIdSrfdRWJ22wmd1I9ZkHu3CKF3qqa54Z05uqUV5KCQrZSml4VuJe2MRq83505rlW+wqKkyLqHl6C4b0WOw0CgYAnwm9KIxhRoq9Gs6HXHmlOCLzcY3p3I683TT1mEKvuuNluCh+KSGmNnP6OGuDv6JdrF5cMOTv3CTWrW7DkyyCK9DfR9bsI8Nfon/PcKRYIRe5ltWJmAG59EZr5xHhu9pkLJgy6n5I3yrDMFhR3YdBNFtmn7tDVP6u2xGLrMoRS7QKBgEIXJ23PpmBJ5LWsdsWe95cpNkW9aSuM5mD3uuIMz0ma7HOjubK89Wh92KR7oFFt8zTZtKfWZ7o9EXHunBKgDzQYHXQoKA+zxSk8/XBIalfAYl5ps+rhfYi8+/Hrh282C93L0kHWXmCOoncXk2hBNJUAqxfSNQ+SE1tGOIYQbhTe
0438a6fe-1087-45da-9693-6459c6050710	55a4e627-b217-4d4b-ba34-53543be4b53c	certificate	MIICoTCCAYkCBgGKyH7qozANBgkqhkiG9w0BAQsFADAUMRIwEAYDVQQDDAlCYWtlclRlY2gwHhcNMjMwOTI0MTgzOTM1WhcNMzMwOTI0MTg0MTE1WjAUMRIwEAYDVQQDDAlCYWtlclRlY2gwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUMVme7tcM6Q/8USHtcZhQKSaehcxhJDq9E0GTgHeD6zEOvS7vyXhf01HaUck32qjxn/uYzmw2svzj7GOy8HvKqaowWL/BgApUkZSy1FXeKqL208gdC6V0EWdYS78lFAs/gCVQTF+9+YhMUBZzUJGVjDgGltWs5CJxVk3ts1FtDQAJSFMm4VtI3Wxlq22T7jnS3iIpwIURR9R6FHJrP92njpTYHCWovn1NnDjuTUv2WXuhy0plmly22DGZXH+IPmXvualYHaG4WxY8inPkfY7hA4J8Vsz0181LdeTN+h4ljdPCUihNPQybZ4R8Iqu5qiy057rPhXZGVALjs0ctmJwxAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAe/0SVvcc4WjvTl0BM67aYtPQ+8LcmUjAiLU7HMQ9HfmPW93bho6/1DylyO79EjzdBsGS7Wpam04uDdD7s9SaNGY4JaAYWWRh/vLeIDBrhiC1UgbGFqJ6zgFOTtkwr6FmhYldRTRNOxEFAmIw+0gAEWYre9tMa+0X4750Yp+lNfAW+b2UJra+HGAvxV8eQBqmmCzFHRQSz/1vm0gYC2BN2aq0RgefX0uDdlZppKRrV4omxy+1l41YzPIqbZ5MidK5zDhzpBd3TxlD2eXamh9m/aNSg8M7X/UHgmlefBo1MWtqJ1vJLK6sublzkMUlkrIlUaEOu4K6cJWYF/brxWX3o=
e4b97aef-02df-4686-82ed-0f1d72877c17	55a4e627-b217-4d4b-ba34-53543be4b53c	priority	100
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.composite_role (composite, child_role) FROM stdin;
3346375c-ae15-476f-8a16-91310b1cf560	25f480ba-775f-41fb-85df-3edc0a045f61
3346375c-ae15-476f-8a16-91310b1cf560	6e21c771-d0fd-428d-8609-59861f12aebc
3346375c-ae15-476f-8a16-91310b1cf560	3f193827-f731-4932-a6a1-638b88850ffd
3346375c-ae15-476f-8a16-91310b1cf560	6806a7a4-5c5f-4f45-b436-de9139b6520b
3346375c-ae15-476f-8a16-91310b1cf560	3f2b76bd-0962-4e3d-b147-6cb8f743ce71
3346375c-ae15-476f-8a16-91310b1cf560	9b6d3b89-b487-47ab-b55b-77b31da54e50
3346375c-ae15-476f-8a16-91310b1cf560	45e2a0d5-5536-4372-a063-c41246abd304
3346375c-ae15-476f-8a16-91310b1cf560	ffa20766-3303-4fc1-a0ae-abc00662c372
3346375c-ae15-476f-8a16-91310b1cf560	b459b4a9-0462-4757-bb83-457a3414f691
3346375c-ae15-476f-8a16-91310b1cf560	915db407-192c-493b-9663-3fa222c62c0a
3346375c-ae15-476f-8a16-91310b1cf560	a563494e-4bc8-45f3-94c2-e5c3e1229015
3346375c-ae15-476f-8a16-91310b1cf560	d01b7b5b-3793-4370-9573-a0f5c1e8dee3
3346375c-ae15-476f-8a16-91310b1cf560	4a4766ef-05e3-4320-aa9a-2b28474a888c
3346375c-ae15-476f-8a16-91310b1cf560	e0ec1da6-2b53-459b-b9e6-2faadbdf2063
3346375c-ae15-476f-8a16-91310b1cf560	a08cfd99-f68a-45bd-9bce-ad065e374e40
3346375c-ae15-476f-8a16-91310b1cf560	16844fb3-b621-451d-a6fa-217da6b75c0a
3346375c-ae15-476f-8a16-91310b1cf560	bb5b8ca1-ceba-4e0d-998d-4ef7088d09ff
3346375c-ae15-476f-8a16-91310b1cf560	c901fa80-49af-40b4-a961-9bf0b6d103c2
3f2b76bd-0962-4e3d-b147-6cb8f743ce71	16844fb3-b621-451d-a6fa-217da6b75c0a
6806a7a4-5c5f-4f45-b436-de9139b6520b	a08cfd99-f68a-45bd-9bce-ad065e374e40
6806a7a4-5c5f-4f45-b436-de9139b6520b	c901fa80-49af-40b4-a961-9bf0b6d103c2
2390bb88-23d8-469d-8399-764197dda005	22ea4db2-3182-4136-9d60-2308186cca48
2390bb88-23d8-469d-8399-764197dda005	5e5b9d0e-7035-45d5-bd68-bb345180da84
5e5b9d0e-7035-45d5-bd68-bb345180da84	1f93d1d3-c032-4bcf-9fe0-5b94a805bb2d
24e990d7-3295-4096-a2a4-28cbef3d8ab7	ab04fedb-87e5-4740-9386-352bedcea25a
3346375c-ae15-476f-8a16-91310b1cf560	ce0b306a-6359-4769-bf04-11f3036d8295
2390bb88-23d8-469d-8399-764197dda005	de5a54e6-b775-4742-afa3-0572fbcfe48d
2390bb88-23d8-469d-8399-764197dda005	ee710467-0e78-4534-b1de-408a4d0ae728
3346375c-ae15-476f-8a16-91310b1cf560	0a8142b2-36e1-4915-8207-8a63cc5c2e24
3346375c-ae15-476f-8a16-91310b1cf560	46ca92e7-75ce-491c-bd7f-d4e2219fdb38
3346375c-ae15-476f-8a16-91310b1cf560	f251da0b-b417-4c1d-a533-053c8b78c283
3346375c-ae15-476f-8a16-91310b1cf560	503fd9e1-8700-4144-9c93-4a859380d5b3
3346375c-ae15-476f-8a16-91310b1cf560	6d745769-0b85-4ebf-b6cb-4bbe8ee5fd1f
3346375c-ae15-476f-8a16-91310b1cf560	f5628a59-ed46-4f58-a1da-626a992a7e75
3346375c-ae15-476f-8a16-91310b1cf560	6b2674a9-0b18-40f1-a393-8c413445d254
3346375c-ae15-476f-8a16-91310b1cf560	3682b022-5c48-4383-befb-31b561a753f1
3346375c-ae15-476f-8a16-91310b1cf560	b1a99391-0947-48ab-b4ad-467cee5b42b3
3346375c-ae15-476f-8a16-91310b1cf560	61660e5d-bf82-4f61-aacf-29ff00679137
3346375c-ae15-476f-8a16-91310b1cf560	2ab5e78e-719d-4a1f-82e8-1917cb8bc2ee
3346375c-ae15-476f-8a16-91310b1cf560	6c64c453-29a8-4471-b1ec-c9762c6a407f
3346375c-ae15-476f-8a16-91310b1cf560	8ef0e236-f8b1-4e4c-bc30-d4adced43489
3346375c-ae15-476f-8a16-91310b1cf560	53fc3309-d03d-4cbf-8476-2d58f6e84d27
3346375c-ae15-476f-8a16-91310b1cf560	bd47289b-aea1-4c58-8488-203c762ef7a5
3346375c-ae15-476f-8a16-91310b1cf560	ecfdaa35-6d98-4439-a1c6-9c93dcce981f
3346375c-ae15-476f-8a16-91310b1cf560	2e38d188-20b6-4751-a465-9a241dbf23fe
503fd9e1-8700-4144-9c93-4a859380d5b3	bd47289b-aea1-4c58-8488-203c762ef7a5
f251da0b-b417-4c1d-a533-053c8b78c283	53fc3309-d03d-4cbf-8476-2d58f6e84d27
f251da0b-b417-4c1d-a533-053c8b78c283	2e38d188-20b6-4751-a465-9a241dbf23fe
b8430a61-318a-4536-8a67-e07515882ed2	e873c552-e603-456e-abbf-121bc85963df
b8430a61-318a-4536-8a67-e07515882ed2	ce904331-e00c-4157-a4de-e2fbe6cef12f
b8430a61-318a-4536-8a67-e07515882ed2	8119c6da-88d5-47bc-a54f-e9c262a76b3e
b8430a61-318a-4536-8a67-e07515882ed2	3b370eb7-9b41-4e4e-b9b6-ed77e7d627f9
942fab8f-595d-4882-b26a-ca721f755519	757946dd-b8c9-4b27-859a-a9ad555e2dd4
942fab8f-595d-4882-b26a-ca721f755519	58ee82ca-f23c-4747-9984-9f20a3eeda23
21a2c0c0-1237-42ab-aeb6-cd9f4751dfcb	1197cf25-0463-47d0-ad05-bdd3370d8e10
db2682ad-1530-4a7f-922f-9a8dea19f4d1	163ce16a-8982-43a5-b2a3-fb1aec2d228c
db2682ad-1530-4a7f-922f-9a8dea19f4d1	942fab8f-595d-4882-b26a-ca721f755519
db2682ad-1530-4a7f-922f-9a8dea19f4d1	757946dd-b8c9-4b27-859a-a9ad555e2dd4
db2682ad-1530-4a7f-922f-9a8dea19f4d1	697690dd-0725-48dd-a074-488f7cd69161
db2682ad-1530-4a7f-922f-9a8dea19f4d1	21a2c0c0-1237-42ab-aeb6-cd9f4751dfcb
db2682ad-1530-4a7f-922f-9a8dea19f4d1	58ee82ca-f23c-4747-9984-9f20a3eeda23
db2682ad-1530-4a7f-922f-9a8dea19f4d1	c31ae3f8-45f1-4d77-a961-e44f58722e59
db2682ad-1530-4a7f-922f-9a8dea19f4d1	0795eafa-5831-4bb0-89bc-34c57fbcab41
db2682ad-1530-4a7f-922f-9a8dea19f4d1	10099c9a-99b6-4f7c-adc0-8e54cbbf6939
db2682ad-1530-4a7f-922f-9a8dea19f4d1	edc9153b-f546-41b8-bf81-019bb8af94fd
db2682ad-1530-4a7f-922f-9a8dea19f4d1	84774cb4-f335-4305-b213-02935049e7cb
db2682ad-1530-4a7f-922f-9a8dea19f4d1	20f331fe-dfff-492a-8300-03a516eb6c45
db2682ad-1530-4a7f-922f-9a8dea19f4d1	c95a2125-5ae7-4761-88cf-6214e553c63e
db2682ad-1530-4a7f-922f-9a8dea19f4d1	2275587b-3ae1-4c93-9a3c-bd5666fcf695
db2682ad-1530-4a7f-922f-9a8dea19f4d1	cf389b40-2527-40a3-93c2-570be37e0d89
db2682ad-1530-4a7f-922f-9a8dea19f4d1	4ddcf3d2-c22e-4d0c-85aa-9749bd5a7456
db2682ad-1530-4a7f-922f-9a8dea19f4d1	d532129b-594d-4f24-af53-3245693a84d4
db2682ad-1530-4a7f-922f-9a8dea19f4d1	1197cf25-0463-47d0-ad05-bdd3370d8e10
ce904331-e00c-4157-a4de-e2fbe6cef12f	5b9d18b7-a864-4619-9c54-2eede09cb669
387d8dba-a69c-4c1d-8873-aca3a7b4712f	ac5b0414-ba95-4b27-950b-97e08c819f5f
3346375c-ae15-476f-8a16-91310b1cf560	e26197fa-f330-453e-a050-e2847b9c5109
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
335d3518-c9fd-470e-89a5-1729f77743a1	\N	password	c2ce3624-9d13-47fa-98ea-4075b0fb180b	1695580876312	\N	{"value":"4Oedu2DPLN1jdB533EBoZC/6SvSqAOEBtZNhoFAiUd5Ha0DUBlgDg1Wv4bFY6+//0WNX0SM4MMhkUj8yKlsBow==","salt":"h6KjdVHnQCg0zkvlGbkrJQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
6b6befb1-d9fb-43ba-bdc8-a73ecf0c8118	\N	password	fa9a03d5-2ec0-45cd-a584-6d9231ffa3bf	1695581049823	My password	{"value":"4mTkIrU1azofsR6SCJvNQ/Cyh4LfMkCCeTW6oWSTF0Om3uXNzCz30bNu8TEkdlCFTiU/uX68RZPz4R9n6Y3e2w==","salt":"jFezE6le7T4U92BCA6BjwQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
9c3798f6-e8b5-4752-9c97-23b4a4d57a2f	\N	password	c3e9b1e5-4363-4d11-b01f-7e6d77e35433	1696185377325	\N	{"value":"fkalX/ewF59NTtlNvguVtPO+1HAQlTyM/zEgBlmMN2mEeMEfVjr6mV5ywI5XmXWHtxLnGFEH3IJQjzjST3IcIA==","salt":"VqY/i3p1nkpgrl+AIHQxKA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2023-09-24 18:40:58.144318	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	5580857513
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2023-09-24 18:40:58.158847	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	5580857513
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2023-09-24 18:40:58.234696	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	5580857513
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2023-09-24 18:40:58.24313	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2023-09-24 18:40:58.431014	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	5580857513
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2023-09-24 18:40:58.436464	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	5580857513
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2023-09-24 18:40:58.610517	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	5580857513
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2023-09-24 18:40:58.616212	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	5580857513
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2023-09-24 18:40:58.626586	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2023-09-24 18:40:58.809994	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	5580857513
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2023-09-24 18:40:58.912612	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2023-09-24 18:40:58.916867	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2023-09-24 18:40:58.964626	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:58.998869	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	5580857513
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.002662	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.00653	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	5580857513
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.010023	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	5580857513
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2023-09-24 18:40:59.103957	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	5580857513
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.180987	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	5580857513
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.189115	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.135265	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	5580857513
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.19374	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	5580857513
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.19779	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	5580857513
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2023-09-24 18:40:59.285352	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	5580857513
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2023-09-24 18:40:59.295224	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	5580857513
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2023-09-24 18:40:59.299227	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	5580857513
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2023-09-24 18:40:59.6336	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	5580857513
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2023-09-24 18:40:59.765083	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	5580857513
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2023-09-24 18:40:59.76963	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	5580857513
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2023-09-24 18:40:59.859857	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	5580857513
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2023-09-24 18:40:59.877674	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	5580857513
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2023-09-24 18:40:59.904181	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	5580857513
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2023-09-24 18:40:59.910237	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	5580857513
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.918053	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.921261	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	5580857513
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.964776	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	5580857513
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.976145	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.985116	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2023-09-24 18:40:59.991177	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	5580857513
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2023-09-24 18:40:59.997382	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	5580857513
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.000333	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	5580857513
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.011473	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	5580857513
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.020981	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	5580857513
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:01.110615	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	5580857513
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2023-09-24 18:41:01.121379	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.144592	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.148798	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.254377	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	5580857513
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.261232	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2023-09-24 18:41:01.351144	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	5580857513
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2023-09-24 18:41:01.5781	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	5580857513
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2023-09-24 18:41:01.584905	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2023-09-24 18:41:01.59002	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	5580857513
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2023-09-24 18:41:01.617693	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.634561	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	5580857513
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.64802	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.729156	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:02.064056	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	5580857513
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2023-09-24 18:41:02.109284	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	5580857513
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2023-09-24 18:41:02.121164	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	5580857513
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-09-24 18:41:02.135543	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	5580857513
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-09-24 18:41:02.146347	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	5580857513
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2023-09-24 18:41:02.152819	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	5580857513
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2023-09-24 18:41:02.159159	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.165124	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.198026	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.221083	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	5580857513
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2023-09-24 18:41:02.229274	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2023-09-24 18:41:02.26158	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	5580857513
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2023-09-24 18:41:02.800745	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	5580857513
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2023-09-24 18:41:02.275059	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	5580857513
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2023-09-24 18:41:02.28256	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	5580857513
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.297996	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.315929	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.31967	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.361222	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	5580857513
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.401624	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	5580857513
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.408974	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.413116	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	5580857513
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.44733	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	5580857513
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.451381	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	5580857513
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.476388	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.481196	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.528106	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.532109	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.566024	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2023-09-24 18:41:02.577469	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	5580857513
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-09-24 18:41:02.594619	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	5580857513
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-09-24 18:41:02.607087	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	5580857513
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.615679	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	5580857513
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.623065	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.6377	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.64753	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.650342	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	5580857513
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2023-09-24 18:41:02.821576	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.8.0	\N	\N	5580857513
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.663636	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.666668	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	5580857513
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.675602	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.714716	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.71809	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.727144	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.748136	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.75167	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.768459	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	5580857513
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.775199	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	5580857513
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2023-09-24 18:41:02.784476	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	5580857513
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2023-09-24 18:41:02.800745	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	5580857513
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2023-09-24 18:41:02.816659	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2023-09-24 18:41:02.821576	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.8.0	\N	\N	5580857513
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2023-09-24 18:40:58.144318	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	5580857513
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2023-09-24 18:40:58.158847	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	5580857513
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2023-09-24 18:40:58.234696	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	5580857513
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2023-09-24 18:40:58.24313	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2023-09-24 18:40:58.431014	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	5580857513
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2023-09-24 18:40:58.436464	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	5580857513
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2023-09-24 18:40:58.610517	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	5580857513
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2023-09-24 18:40:58.616212	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	5580857513
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2023-09-24 18:40:58.626586	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2023-09-24 18:40:58.809994	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	5580857513
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2023-09-24 18:40:58.912612	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2023-09-24 18:40:58.916867	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2023-09-24 18:40:58.964626	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:58.998869	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	5580857513
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.002662	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.00653	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	5580857513
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.010023	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	5580857513
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2023-09-24 18:40:59.103957	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	5580857513
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.180987	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	5580857513
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.189115	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.135265	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	5580857513
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.19374	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	5580857513
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.19779	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	5580857513
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2023-09-24 18:40:59.285352	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	5580857513
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2023-09-24 18:40:59.295224	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	5580857513
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2023-09-24 18:40:59.299227	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	5580857513
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2023-09-24 18:40:59.6336	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	5580857513
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2023-09-24 18:40:59.765083	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	5580857513
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2023-09-24 18:40:59.76963	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	5580857513
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2023-09-24 18:40:59.859857	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	5580857513
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2023-09-24 18:41:02.816659	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2023-09-24 18:40:59.877674	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	5580857513
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2023-09-24 18:40:59.904181	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	5580857513
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2023-09-24 18:40:59.910237	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	5580857513
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.918053	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.921261	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	5580857513
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.964776	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	5580857513
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.976145	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.985116	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2023-09-24 18:40:59.991177	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	5580857513
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2023-09-24 18:40:59.997382	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	5580857513
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.000333	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	5580857513
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.011473	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	5580857513
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.020981	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	5580857513
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:01.110615	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	5580857513
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2023-09-24 18:41:01.121379	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.144592	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.148798	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.254377	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	5580857513
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.261232	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2023-09-24 18:41:01.351144	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	5580857513
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2023-09-24 18:41:01.5781	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	5580857513
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2023-09-24 18:41:01.584905	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2023-09-24 18:41:01.59002	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	5580857513
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2023-09-24 18:41:01.617693	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.634561	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	5580857513
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.64802	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.729156	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:02.064056	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	5580857513
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2023-09-24 18:41:02.109284	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	5580857513
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2023-09-24 18:41:02.121164	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	5580857513
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-09-24 18:41:02.135543	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	5580857513
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-09-24 18:41:02.146347	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	5580857513
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2023-09-24 18:41:02.152819	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	5580857513
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2023-09-24 18:41:02.159159	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.165124	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.198026	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.221083	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	5580857513
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2023-09-24 18:41:02.229274	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2023-09-24 18:41:02.26158	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	5580857513
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2023-09-24 18:41:02.275059	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	5580857513
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2023-09-24 18:41:02.28256	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	5580857513
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.297996	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.315929	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.31967	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.361222	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	5580857513
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.401624	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	5580857513
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.408974	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.413116	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	5580857513
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.44733	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	5580857513
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.451381	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	5580857513
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.476388	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.481196	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.528106	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.532109	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.566024	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2023-09-24 18:41:02.577469	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	5580857513
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-09-24 18:41:02.594619	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	5580857513
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-09-24 18:41:02.607087	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	5580857513
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.615679	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	5580857513
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.623065	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.6377	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.64753	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.650342	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	5580857513
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.663636	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.666668	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	5580857513
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.675602	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.714716	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.71809	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.727144	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.748136	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.75167	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.768459	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	5580857513
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.775199	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	5580857513
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2023-09-24 18:41:02.784476	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	5580857513
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2023-09-24 18:40:58.144318	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	5580857513
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2023-09-24 18:40:58.158847	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	5580857513
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2023-09-24 18:40:58.234696	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	5580857513
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2023-09-24 18:40:58.24313	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2023-09-24 18:40:58.431014	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	5580857513
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2023-09-24 18:40:58.436464	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	5580857513
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2023-09-24 18:40:58.610517	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	5580857513
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2023-09-24 18:40:58.616212	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	5580857513
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2023-09-24 18:40:58.626586	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2023-09-24 18:40:58.809994	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	5580857513
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2023-09-24 18:40:58.912612	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2023-09-24 18:40:58.916867	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2023-09-24 18:40:58.964626	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:58.998869	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	5580857513
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.002662	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.00653	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	5580857513
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.010023	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	5580857513
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2023-09-24 18:40:59.103957	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	5580857513
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.180987	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	5580857513
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.189115	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.135265	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	5580857513
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.19374	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	5580857513
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.19779	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	5580857513
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2023-09-24 18:40:59.285352	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	5580857513
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2023-09-24 18:40:59.295224	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	5580857513
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2023-09-24 18:40:59.299227	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	5580857513
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2023-09-24 18:40:59.6336	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	5580857513
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2023-09-24 18:40:59.765083	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	5580857513
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2023-09-24 18:40:59.76963	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	5580857513
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2023-09-24 18:40:59.859857	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	5580857513
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2023-09-24 18:40:59.877674	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	5580857513
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2023-09-24 18:40:59.904181	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	5580857513
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2023-09-24 18:40:59.910237	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	5580857513
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.918053	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.921261	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	5580857513
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.964776	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	5580857513
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.976145	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.985116	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2023-09-24 18:40:59.991177	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	5580857513
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2023-09-24 18:40:59.997382	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	5580857513
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.000333	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	5580857513
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.011473	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	5580857513
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.020981	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	5580857513
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:01.110615	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	5580857513
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2023-09-24 18:41:01.121379	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.144592	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.148798	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.254377	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	5580857513
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.261232	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2023-09-24 18:41:01.351144	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	5580857513
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2023-09-24 18:41:01.5781	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	5580857513
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2023-09-24 18:41:01.584905	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2023-09-24 18:41:01.59002	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	5580857513
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2023-09-24 18:41:01.617693	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.634561	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	5580857513
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.64802	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.729156	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:02.064056	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	5580857513
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2023-09-24 18:41:02.109284	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	5580857513
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2023-09-24 18:41:02.121164	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	5580857513
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-09-24 18:41:02.135543	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	5580857513
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-09-24 18:41:02.146347	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	5580857513
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2023-09-24 18:41:02.152819	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	5580857513
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2023-09-24 18:41:02.159159	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.165124	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.198026	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.221083	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	5580857513
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2023-09-24 18:41:02.229274	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2023-09-24 18:41:02.26158	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	5580857513
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2023-09-24 18:41:02.800745	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	5580857513
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2023-09-24 18:41:02.275059	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	5580857513
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2023-09-24 18:41:02.28256	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	5580857513
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.297996	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.315929	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.31967	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.361222	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	5580857513
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.401624	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	5580857513
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.408974	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.413116	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	5580857513
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.44733	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	5580857513
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.451381	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	5580857513
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.476388	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.481196	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.528106	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.532109	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.566024	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2023-09-24 18:41:02.577469	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	5580857513
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-09-24 18:41:02.594619	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	5580857513
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-09-24 18:41:02.607087	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	5580857513
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.615679	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	5580857513
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.623065	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.6377	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.64753	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.650342	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	5580857513
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2023-09-24 18:41:02.821576	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.8.0	\N	\N	5580857513
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.663636	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.666668	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	5580857513
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.675602	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.714716	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.71809	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.727144	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.748136	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.75167	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.768459	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	5580857513
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.775199	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	5580857513
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2023-09-24 18:41:02.784476	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	5580857513
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2023-09-24 18:41:02.800745	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	5580857513
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2023-09-24 18:41:02.816659	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2023-09-24 18:41:02.821576	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.8.0	\N	\N	5580857513
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2023-09-24 18:40:58.144318	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	5580857513
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2023-09-24 18:40:58.158847	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	5580857513
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2023-09-24 18:40:58.234696	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	5580857513
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2023-09-24 18:40:58.24313	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2023-09-24 18:40:58.431014	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	5580857513
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2023-09-24 18:40:58.436464	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	5580857513
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2023-09-24 18:40:58.610517	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	5580857513
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2023-09-24 18:40:58.616212	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	5580857513
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2023-09-24 18:40:58.626586	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2023-09-24 18:40:58.809994	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	5580857513
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2023-09-24 18:40:58.912612	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2023-09-24 18:40:58.916867	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2023-09-24 18:40:58.964626	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:58.998869	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	5580857513
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.002662	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.00653	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	5580857513
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.010023	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	5580857513
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2023-09-24 18:40:59.103957	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	5580857513
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.180987	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	5580857513
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.189115	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.135265	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	5580857513
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.19374	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	5580857513
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.19779	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	5580857513
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2023-09-24 18:40:59.285352	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	5580857513
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2023-09-24 18:40:59.295224	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	5580857513
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2023-09-24 18:40:59.299227	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	5580857513
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2023-09-24 18:40:59.6336	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	5580857513
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2023-09-24 18:40:59.765083	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	5580857513
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2023-09-24 18:40:59.76963	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	5580857513
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2023-09-24 18:40:59.859857	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	5580857513
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2023-09-24 18:41:02.816659	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2023-09-24 18:40:59.877674	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	5580857513
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2023-09-24 18:40:59.904181	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	5580857513
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2023-09-24 18:40:59.910237	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	5580857513
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.918053	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.921261	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	5580857513
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.964776	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	5580857513
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.976145	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.985116	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2023-09-24 18:40:59.991177	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	5580857513
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2023-09-24 18:40:59.997382	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	5580857513
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.000333	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	5580857513
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.011473	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	5580857513
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.020981	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	5580857513
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:01.110615	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	5580857513
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2023-09-24 18:41:01.121379	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.144592	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.148798	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.254377	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	5580857513
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.261232	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2023-09-24 18:41:01.351144	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	5580857513
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2023-09-24 18:41:01.5781	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	5580857513
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2023-09-24 18:41:01.584905	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2023-09-24 18:41:01.59002	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	5580857513
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2023-09-24 18:41:01.617693	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.634561	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	5580857513
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.64802	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.729156	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:02.064056	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	5580857513
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2023-09-24 18:41:02.109284	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	5580857513
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2023-09-24 18:41:02.121164	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	5580857513
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-09-24 18:41:02.135543	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	5580857513
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-09-24 18:41:02.146347	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	5580857513
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2023-09-24 18:41:02.152819	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	5580857513
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2023-09-24 18:41:02.159159	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.165124	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.198026	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.221083	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	5580857513
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2023-09-24 18:41:02.229274	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2023-09-24 18:41:02.26158	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	5580857513
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2023-09-24 18:41:02.275059	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	5580857513
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2023-09-24 18:41:02.28256	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	5580857513
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.297996	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.315929	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.31967	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.361222	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	5580857513
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.401624	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	5580857513
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.408974	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.413116	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	5580857513
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.44733	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	5580857513
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.451381	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	5580857513
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.476388	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.481196	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.528106	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.532109	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.566024	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2023-09-24 18:41:02.577469	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	5580857513
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-09-24 18:41:02.594619	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	5580857513
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-09-24 18:41:02.607087	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	5580857513
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.615679	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	5580857513
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.623065	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.6377	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.64753	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.650342	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	5580857513
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.663636	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.666668	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	5580857513
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.675602	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.714716	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.71809	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.727144	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.748136	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.75167	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.768459	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	5580857513
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.775199	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	5580857513
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2023-09-24 18:41:02.784476	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	5580857513
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
a7ba7779-875b-4788-99a3-328f298d05b3	07ab3675-42f8-4b10-b192-8ccd1b2d585c	f
a7ba7779-875b-4788-99a3-328f298d05b3	fcb250d4-b039-468b-9052-c54a64fb504c	t
a7ba7779-875b-4788-99a3-328f298d05b3	6977acb4-8b54-432e-b849-816f8c20c04c	t
a7ba7779-875b-4788-99a3-328f298d05b3	43820c2a-045e-4909-a8f2-f65ed2433a7d	t
a7ba7779-875b-4788-99a3-328f298d05b3	afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	f
a7ba7779-875b-4788-99a3-328f298d05b3	5fdd6127-2f29-4a63-a405-0fea438c255a	f
a7ba7779-875b-4788-99a3-328f298d05b3	e923f6a9-0cd2-4899-a184-d866bf9756a9	t
a7ba7779-875b-4788-99a3-328f298d05b3	97183b7b-2c55-4fbd-99b3-4837cfbc0b00	t
a7ba7779-875b-4788-99a3-328f298d05b3	fa167aac-9554-424f-8b30-4c0297b499d2	f
a7ba7779-875b-4788-99a3-328f298d05b3	815a3e74-387c-4f80-b408-01309615b469	t
8eee160c-5edd-481a-b964-c368a057e598	33583b6c-e729-4916-9bf6-2a3e3b79100f	t
8eee160c-5edd-481a-b964-c368a057e598	ff02e659-87de-4b64-9207-c64548a8d463	t
8eee160c-5edd-481a-b964-c368a057e598	f8859454-c1a8-4f25-815d-8c2f38e11968	t
8eee160c-5edd-481a-b964-c368a057e598	811127fe-927b-4211-b57f-b0ded9b327ef	t
8eee160c-5edd-481a-b964-c368a057e598	b0fe611c-3950-44df-832b-14e0814a70aa	t
8eee160c-5edd-481a-b964-c368a057e598	0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	f
8eee160c-5edd-481a-b964-c368a057e598	7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	f
8eee160c-5edd-481a-b964-c368a057e598	2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.group_role_mapping (role_id, group_id) FROM stdin;
deb2c812-04b9-4b69-ad1e-9fa1883e7388	c6e58693-64c1-4c5a-809e-49da74d2ce30
ffb9fc4a-1b1c-4bce-91b3-84a8326a4dd7	497e8a1b-f1ac-4084-a672-56ff3d41de8c
0d049c11-8c7b-43d3-aacd-a355d3dded24	00bc83ff-218f-4d6f-b4c0-49560c9d3aad
3c9ec334-7a02-469f-b733-9434fa218755	a2f5c0c5-6aea-40eb-9cc5-cdd625991e95
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
c6e58693-64c1-4c5a-809e-49da74d2ce30	Administrators	 	8eee160c-5edd-481a-b964-c368a057e598
497e8a1b-f1ac-4084-a672-56ff3d41de8c	Clients	 	8eee160c-5edd-481a-b964-c368a057e598
00bc83ff-218f-4d6f-b4c0-49560c9d3aad	Managers	 	8eee160c-5edd-481a-b964-c368a057e598
a2f5c0c5-6aea-40eb-9cc5-cdd625991e95	Servicemen	 	8eee160c-5edd-481a-b964-c368a057e598
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
2390bb88-23d8-469d-8399-764197dda005	a7ba7779-875b-4788-99a3-328f298d05b3	f	${role_default-roles}	default-roles-master	a7ba7779-875b-4788-99a3-328f298d05b3	\N	\N
3346375c-ae15-476f-8a16-91310b1cf560	a7ba7779-875b-4788-99a3-328f298d05b3	f	${role_admin}	admin	a7ba7779-875b-4788-99a3-328f298d05b3	\N	\N
25f480ba-775f-41fb-85df-3edc0a045f61	a7ba7779-875b-4788-99a3-328f298d05b3	f	${role_create-realm}	create-realm	a7ba7779-875b-4788-99a3-328f298d05b3	\N	\N
6e21c771-d0fd-428d-8609-59861f12aebc	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_create-client}	create-client	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
3f193827-f731-4932-a6a1-638b88850ffd	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_view-realm}	view-realm	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
6806a7a4-5c5f-4f45-b436-de9139b6520b	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_view-users}	view-users	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
3f2b76bd-0962-4e3d-b147-6cb8f743ce71	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_view-clients}	view-clients	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
9b6d3b89-b487-47ab-b55b-77b31da54e50	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_view-events}	view-events	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
45e2a0d5-5536-4372-a063-c41246abd304	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_view-identity-providers}	view-identity-providers	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
ffa20766-3303-4fc1-a0ae-abc00662c372	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_view-authorization}	view-authorization	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
b459b4a9-0462-4757-bb83-457a3414f691	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_manage-realm}	manage-realm	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
915db407-192c-493b-9663-3fa222c62c0a	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_manage-users}	manage-users	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
a563494e-4bc8-45f3-94c2-e5c3e1229015	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_manage-clients}	manage-clients	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
d01b7b5b-3793-4370-9573-a0f5c1e8dee3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_manage-events}	manage-events	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
4a4766ef-05e3-4320-aa9a-2b28474a888c	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_manage-identity-providers}	manage-identity-providers	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
e0ec1da6-2b53-459b-b9e6-2faadbdf2063	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_manage-authorization}	manage-authorization	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
a08cfd99-f68a-45bd-9bce-ad065e374e40	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_query-users}	query-users	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
16844fb3-b621-451d-a6fa-217da6b75c0a	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_query-clients}	query-clients	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
bb5b8ca1-ceba-4e0d-998d-4ef7088d09ff	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_query-realms}	query-realms	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
c901fa80-49af-40b4-a961-9bf0b6d103c2	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_query-groups}	query-groups	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
22ea4db2-3182-4136-9d60-2308186cca48	530aa4ab-ff70-4256-8abb-0a905d775a99	t	${role_view-profile}	view-profile	a7ba7779-875b-4788-99a3-328f298d05b3	530aa4ab-ff70-4256-8abb-0a905d775a99	\N
5e5b9d0e-7035-45d5-bd68-bb345180da84	530aa4ab-ff70-4256-8abb-0a905d775a99	t	${role_manage-account}	manage-account	a7ba7779-875b-4788-99a3-328f298d05b3	530aa4ab-ff70-4256-8abb-0a905d775a99	\N
1f93d1d3-c032-4bcf-9fe0-5b94a805bb2d	530aa4ab-ff70-4256-8abb-0a905d775a99	t	${role_manage-account-links}	manage-account-links	a7ba7779-875b-4788-99a3-328f298d05b3	530aa4ab-ff70-4256-8abb-0a905d775a99	\N
63c82900-a020-4cb1-afa9-4f80ad443c9a	530aa4ab-ff70-4256-8abb-0a905d775a99	t	${role_view-applications}	view-applications	a7ba7779-875b-4788-99a3-328f298d05b3	530aa4ab-ff70-4256-8abb-0a905d775a99	\N
ab04fedb-87e5-4740-9386-352bedcea25a	530aa4ab-ff70-4256-8abb-0a905d775a99	t	${role_view-consent}	view-consent	a7ba7779-875b-4788-99a3-328f298d05b3	530aa4ab-ff70-4256-8abb-0a905d775a99	\N
24e990d7-3295-4096-a2a4-28cbef3d8ab7	530aa4ab-ff70-4256-8abb-0a905d775a99	t	${role_manage-consent}	manage-consent	a7ba7779-875b-4788-99a3-328f298d05b3	530aa4ab-ff70-4256-8abb-0a905d775a99	\N
f373c49c-043c-4333-a8e5-5b5c77b79f7e	530aa4ab-ff70-4256-8abb-0a905d775a99	t	${role_delete-account}	delete-account	a7ba7779-875b-4788-99a3-328f298d05b3	530aa4ab-ff70-4256-8abb-0a905d775a99	\N
464ed1ce-89e6-4e39-adf1-e036b6ef7639	82ccf254-bfc4-462b-97e1-50f2595b7f06	t	${role_read-token}	read-token	a7ba7779-875b-4788-99a3-328f298d05b3	82ccf254-bfc4-462b-97e1-50f2595b7f06	\N
ce0b306a-6359-4769-bf04-11f3036d8295	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_impersonation}	impersonation	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
de5a54e6-b775-4742-afa3-0572fbcfe48d	a7ba7779-875b-4788-99a3-328f298d05b3	f	${role_offline-access}	offline_access	a7ba7779-875b-4788-99a3-328f298d05b3	\N	\N
ee710467-0e78-4534-b1de-408a4d0ae728	a7ba7779-875b-4788-99a3-328f298d05b3	f	${role_uma_authorization}	uma_authorization	a7ba7779-875b-4788-99a3-328f298d05b3	\N	\N
b8430a61-318a-4536-8a67-e07515882ed2	8eee160c-5edd-481a-b964-c368a057e598	f	${role_default-roles}	default-roles-bakertech	8eee160c-5edd-481a-b964-c368a057e598	\N	\N
0a8142b2-36e1-4915-8207-8a63cc5c2e24	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_create-client}	create-client	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
46ca92e7-75ce-491c-bd7f-d4e2219fdb38	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_view-realm}	view-realm	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
f251da0b-b417-4c1d-a533-053c8b78c283	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_view-users}	view-users	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
503fd9e1-8700-4144-9c93-4a859380d5b3	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_view-clients}	view-clients	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
6d745769-0b85-4ebf-b6cb-4bbe8ee5fd1f	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_view-events}	view-events	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
f5628a59-ed46-4f58-a1da-626a992a7e75	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_view-identity-providers}	view-identity-providers	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
6b2674a9-0b18-40f1-a393-8c413445d254	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_view-authorization}	view-authorization	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
3682b022-5c48-4383-befb-31b561a753f1	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_manage-realm}	manage-realm	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
b1a99391-0947-48ab-b4ad-467cee5b42b3	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_manage-users}	manage-users	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
61660e5d-bf82-4f61-aacf-29ff00679137	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_manage-clients}	manage-clients	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
2ab5e78e-719d-4a1f-82e8-1917cb8bc2ee	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_manage-events}	manage-events	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
6c64c453-29a8-4471-b1ec-c9762c6a407f	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_manage-identity-providers}	manage-identity-providers	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
8ef0e236-f8b1-4e4c-bc30-d4adced43489	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_manage-authorization}	manage-authorization	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
53fc3309-d03d-4cbf-8476-2d58f6e84d27	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_query-users}	query-users	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
bd47289b-aea1-4c58-8488-203c762ef7a5	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_query-clients}	query-clients	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
ecfdaa35-6d98-4439-a1c6-9c93dcce981f	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_query-realms}	query-realms	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
2e38d188-20b6-4751-a465-9a241dbf23fe	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_query-groups}	query-groups	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
e873c552-e603-456e-abbf-121bc85963df	8eee160c-5edd-481a-b964-c368a057e598	f	${role_offline-access}	offline_access	8eee160c-5edd-481a-b964-c368a057e598	\N	\N
ffb9fc4a-1b1c-4bce-91b3-84a8326a4dd7	8eee160c-5edd-481a-b964-c368a057e598	f		CLIENT	8eee160c-5edd-481a-b964-c368a057e598	\N	\N
0d049c11-8c7b-43d3-aacd-a355d3dded24	8eee160c-5edd-481a-b964-c368a057e598	f		MANAGER	8eee160c-5edd-481a-b964-c368a057e598	\N	\N
8119c6da-88d5-47bc-a54f-e9c262a76b3e	8eee160c-5edd-481a-b964-c368a057e598	f	${role_uma_authorization}	uma_authorization	8eee160c-5edd-481a-b964-c368a057e598	\N	\N
deb2c812-04b9-4b69-ad1e-9fa1883e7388	8eee160c-5edd-481a-b964-c368a057e598	f		ADMINISTRATOR	8eee160c-5edd-481a-b964-c368a057e598	\N	\N
3c9ec334-7a02-469f-b733-9434fa218755	8eee160c-5edd-481a-b964-c368a057e598	f		SERVICEMAN	8eee160c-5edd-481a-b964-c368a057e598	\N	\N
ec9a25c1-c145-4f65-9a77-765ae805f9cc	39610acb-a894-4f24-811f-08d0590f7f79	t	\N	uma_protection	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
163ce16a-8982-43a5-b2a3-fb1aec2d228c	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_view-authorization}	view-authorization	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
942fab8f-595d-4882-b26a-ca721f755519	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_view-users}	view-users	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
757946dd-b8c9-4b27-859a-a9ad555e2dd4	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_query-groups}	query-groups	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
697690dd-0725-48dd-a074-488f7cd69161	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_manage-authorization}	manage-authorization	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
21a2c0c0-1237-42ab-aeb6-cd9f4751dfcb	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_view-clients}	view-clients	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
58ee82ca-f23c-4747-9984-9f20a3eeda23	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_query-users}	query-users	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
c31ae3f8-45f1-4d77-a961-e44f58722e59	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_create-client}	create-client	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
0795eafa-5831-4bb0-89bc-34c57fbcab41	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_view-realm}	view-realm	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
db2682ad-1530-4a7f-922f-9a8dea19f4d1	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_realm-admin}	realm-admin	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
10099c9a-99b6-4f7c-adc0-8e54cbbf6939	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_query-realms}	query-realms	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
edc9153b-f546-41b8-bf81-019bb8af94fd	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_manage-events}	manage-events	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
84774cb4-f335-4305-b213-02935049e7cb	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_manage-users}	manage-users	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
20f331fe-dfff-492a-8300-03a516eb6c45	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_view-events}	view-events	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
c95a2125-5ae7-4761-88cf-6214e553c63e	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_manage-clients}	manage-clients	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
2275587b-3ae1-4c93-9a3c-bd5666fcf695	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_impersonation}	impersonation	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
cf389b40-2527-40a3-93c2-570be37e0d89	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_manage-realm}	manage-realm	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
4ddcf3d2-c22e-4d0c-85aa-9749bd5a7456	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_manage-identity-providers}	manage-identity-providers	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
d532129b-594d-4f24-af53-3245693a84d4	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_view-identity-providers}	view-identity-providers	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
1197cf25-0463-47d0-ad05-bdd3370d8e10	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_query-clients}	query-clients	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
bd515d95-8cc0-4c14-b6cc-b2afc63314b1	80710076-562f-4877-bf9c-7a005d70367b	t	${role_read-token}	read-token	8eee160c-5edd-481a-b964-c368a057e598	80710076-562f-4877-bf9c-7a005d70367b	\N
868d8b6b-ed13-47fc-8c53-e90a88947754	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	t	${role_delete-account}	delete-account	8eee160c-5edd-481a-b964-c368a057e598	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	\N
ce904331-e00c-4157-a4de-e2fbe6cef12f	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	t	${role_manage-account}	manage-account	8eee160c-5edd-481a-b964-c368a057e598	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	\N
5b9d18b7-a864-4619-9c54-2eede09cb669	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	t	${role_manage-account-links}	manage-account-links	8eee160c-5edd-481a-b964-c368a057e598	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	\N
ac5b0414-ba95-4b27-950b-97e08c819f5f	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	t	${role_view-consent}	view-consent	8eee160c-5edd-481a-b964-c368a057e598	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	\N
3b370eb7-9b41-4e4e-b9b6-ed77e7d627f9	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	t	${role_view-profile}	view-profile	8eee160c-5edd-481a-b964-c368a057e598	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	\N
38bc4704-aacf-4fbb-8659-24e5a4521dd3	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	t	${role_view-applications}	view-applications	8eee160c-5edd-481a-b964-c368a057e598	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	\N
387d8dba-a69c-4c1d-8873-aca3a7b4712f	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	t	${role_manage-consent}	manage-consent	8eee160c-5edd-481a-b964-c368a057e598	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	\N
e26197fa-f330-453e-a050-e2847b9c5109	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_impersonation}	impersonation	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.migration_model (id, version, update_time) FROM stdin;
295ji	19.0.3	1695580867
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
6b444e86-bf32-4e81-9e3d-5c11e88e12c7	audience resolve	openid-connect	oidc-audience-resolve-mapper	2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	\N
49400536-4d44-47b8-8e41-4eedc54eba47	locale	openid-connect	oidc-usermodel-attribute-mapper	e1ec9699-6a5e-4408-876d-5e6e18b7bd51	\N
74d678f0-c73b-4c27-ba97-de6d0144a369	role list	saml	saml-role-list-mapper	\N	fcb250d4-b039-468b-9052-c54a64fb504c
d245dd4e-efc0-48d2-80d1-cb3e3c0b3822	full name	openid-connect	oidc-full-name-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
9f1e3a68-0acf-4c31-9966-e2bc82ffe33c	family name	openid-connect	oidc-usermodel-property-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
dce5121d-0031-41bc-abaf-0a0e5fd0fcae	given name	openid-connect	oidc-usermodel-property-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
df6495fe-8a8d-4d9b-a786-50fd55841b53	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
46218efe-c8a8-425f-a385-e43bdcec66bd	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
0cfc211e-b517-4513-ba8b-77d5552137dd	username	openid-connect	oidc-usermodel-property-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
42aa1da0-330b-4bc1-8e3c-ba6b53b34d31	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
b96cbf86-b62e-4141-9b06-f915307fefd1	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
2ddc21c1-2b42-4369-adf9-ac59805583d2	website	openid-connect	oidc-usermodel-attribute-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
085b665a-6236-4187-bce2-f6ec5be85a4d	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
4a5f94bc-4249-4982-9c3d-27e8dbe21c28	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
59b027ab-78cb-44a4-844a-b9e6bbba8c12	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
22d755ca-33d7-49f0-ab8c-107f8689a780	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
1fffd00b-314b-45eb-a9e2-405737d923dc	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
984191e4-d418-4b93-8298-aa466c458bea	email	openid-connect	oidc-usermodel-property-mapper	\N	43820c2a-045e-4909-a8f2-f65ed2433a7d
23e2a75f-5385-4ee6-b8e5-c6cfeefb0f05	email verified	openid-connect	oidc-usermodel-property-mapper	\N	43820c2a-045e-4909-a8f2-f65ed2433a7d
a5d4c0a4-e4f9-4d0b-8dbf-2a6b5cb87f9c	address	openid-connect	oidc-address-mapper	\N	afe4a7ae-f9d8-44f6-8278-f5087bcce7d5
878d6e5a-b743-4fa3-a2e7-724a1343b59d	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	5fdd6127-2f29-4a63-a405-0fea438c255a
e2a41632-ab44-41a2-b0ca-a5f34f169b1f	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	5fdd6127-2f29-4a63-a405-0fea438c255a
a923793b-a4dd-44d4-ab35-d80afda1439d	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	e923f6a9-0cd2-4899-a184-d866bf9756a9
5da2d373-6f82-4ecf-ac61-f939f5937bc6	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	e923f6a9-0cd2-4899-a184-d866bf9756a9
3df0a1a7-07cc-465d-a87c-fe5a5e694e29	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	e923f6a9-0cd2-4899-a184-d866bf9756a9
8ed69d7c-bfd5-4c53-b346-aa806ccded83	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	97183b7b-2c55-4fbd-99b3-4837cfbc0b00
75feafd3-f41f-4a14-9613-feece8257ee8	upn	openid-connect	oidc-usermodel-property-mapper	\N	fa167aac-9554-424f-8b30-4c0297b499d2
81bd3a0e-cf3a-4bf8-8c3d-e52542230e74	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	fa167aac-9554-424f-8b30-4c0297b499d2
f14cd9bf-ebd9-43a1-9255-7a849ed27b94	acr loa level	openid-connect	oidc-acr-mapper	\N	815a3e74-387c-4f80-b408-01309615b469
caf69847-24e1-4f92-b801-5a09e47a5b66	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	f8859454-c1a8-4f25-815d-8c2f38e11968
8db4e0fb-05d2-4015-9213-d2bc8800f95d	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	f8859454-c1a8-4f25-815d-8c2f38e11968
4229f990-6e15-49e1-9eeb-33b9930b267c	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	f8859454-c1a8-4f25-815d-8c2f38e11968
4f820837-62fb-45ce-9517-5580a2ec10a8	role list	saml	saml-role-list-mapper	\N	33583b6c-e729-4916-9bf6-2a3e3b79100f
76dcc67f-4e11-49e1-ae6c-cb79906aaf6e	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	811127fe-927b-4211-b57f-b0ded9b327ef
d2c969c7-ee34-4982-bc3c-7bff3c286fd7	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	2393f5e9-6f13-4fb2-b5e3-15c4185d6a98
2a906541-6bb1-4f90-9b5d-843e0391b7ac	upn	openid-connect	oidc-usermodel-property-mapper	\N	2393f5e9-6f13-4fb2-b5e3-15c4185d6a98
800432cf-3681-48dc-b79b-400b85080f07	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
ba95db0d-1548-4720-8849-00848c131b10	full name	openid-connect	oidc-full-name-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
871064ca-5938-4db0-b632-ee0d1724dede	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
593633b6-58ef-442f-95d3-fcfadfb3a379	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
113010ac-0884-49a4-8c70-816a16af3bb3	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
32ff5641-e28b-4c1e-ac01-f71acbabc820	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
23c33372-0372-4179-a314-78e26f21b4d2	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
95697b76-b208-40ef-bfc6-e3edc79ed8f7	given name	openid-connect	oidc-usermodel-property-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
0d464d63-d8dc-4c88-9e95-850839a0ee0f	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
685634ba-b026-4393-9353-9f399e63b627	website	openid-connect	oidc-usermodel-attribute-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
1871860e-d5eb-42bd-8438-082ae0cc17c0	username	openid-connect	oidc-usermodel-property-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
2b56929d-c0c6-4c17-8278-de8df834bae2	family name	openid-connect	oidc-usermodel-property-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
10cc0f04-bd0c-4a73-98ca-b86d8d1c10be	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
d5c95ac9-5e91-46ab-8608-40df46c3581f	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
6ed9504b-f3f6-4e46-8049-ebe932dffbe0	acr loa level	openid-connect	oidc-acr-mapper	\N	b0fe611c-3950-44df-832b-14e0814a70aa
21b10d47-16e4-4cc2-8d62-5de0017fc343	address	openid-connect	oidc-address-mapper	\N	7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca
bdc26eeb-d138-4ce9-9080-39e35756d35e	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	d4320bae-9ace-4165-b177-a00033b8fbdb
ae8a91e3-ca13-45d9-a20f-82b0dc7e7293	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	d4320bae-9ace-4165-b177-a00033b8fbdb
6a6cdfdd-64a1-48e1-809f-cc4ed5773ce1	email	openid-connect	oidc-usermodel-property-mapper	\N	03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3
748b4d7f-1eaf-4574-adae-571418d2f271	email verified	openid-connect	oidc-usermodel-property-mapper	\N	03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3
dcb8d992-e6f2-4f18-8f20-fbb6cae15a12	audience resolve	openid-connect	oidc-audience-resolve-mapper	74b39df6-1c8b-4e84-8251-5771ca6a6470	\N
94aa18cf-2b2c-4ded-9717-6e7075778b04	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	92f5bea7-369a-483d-a9ea-a330f05968b5	\N
a4039d27-25ac-4eab-80aa-babd3b48b709	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	92f5bea7-369a-483d-a9ea-a330f05968b5	\N
61f01bea-5724-4b08-9646-684a5f3838eb	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	92f5bea7-369a-483d-a9ea-a330f05968b5	\N
5b97a02f-cd31-403e-98db-b6f26880dc24	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	39610acb-a894-4f24-811f-08d0590f7f79	\N
f0d7c27f-d38c-446e-9349-55ec05bffd3f	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	39610acb-a894-4f24-811f-08d0590f7f79	\N
3a4da86a-2132-46d0-a825-2719d5344ca7	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	39610acb-a894-4f24-811f-08d0590f7f79	\N
40f17d1d-7a01-460a-b060-8ed4e8ae1a9e	locale	openid-connect	oidc-usermodel-attribute-mapper	1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
49400536-4d44-47b8-8e41-4eedc54eba47	true	userinfo.token.claim
49400536-4d44-47b8-8e41-4eedc54eba47	locale	user.attribute
49400536-4d44-47b8-8e41-4eedc54eba47	true	id.token.claim
49400536-4d44-47b8-8e41-4eedc54eba47	true	access.token.claim
49400536-4d44-47b8-8e41-4eedc54eba47	locale	claim.name
49400536-4d44-47b8-8e41-4eedc54eba47	String	jsonType.label
74d678f0-c73b-4c27-ba97-de6d0144a369	false	single
74d678f0-c73b-4c27-ba97-de6d0144a369	Basic	attribute.nameformat
74d678f0-c73b-4c27-ba97-de6d0144a369	Role	attribute.name
d245dd4e-efc0-48d2-80d1-cb3e3c0b3822	true	userinfo.token.claim
d245dd4e-efc0-48d2-80d1-cb3e3c0b3822	true	id.token.claim
d245dd4e-efc0-48d2-80d1-cb3e3c0b3822	true	access.token.claim
9f1e3a68-0acf-4c31-9966-e2bc82ffe33c	true	userinfo.token.claim
9f1e3a68-0acf-4c31-9966-e2bc82ffe33c	lastName	user.attribute
9f1e3a68-0acf-4c31-9966-e2bc82ffe33c	true	id.token.claim
9f1e3a68-0acf-4c31-9966-e2bc82ffe33c	true	access.token.claim
9f1e3a68-0acf-4c31-9966-e2bc82ffe33c	family_name	claim.name
9f1e3a68-0acf-4c31-9966-e2bc82ffe33c	String	jsonType.label
dce5121d-0031-41bc-abaf-0a0e5fd0fcae	true	userinfo.token.claim
dce5121d-0031-41bc-abaf-0a0e5fd0fcae	firstName	user.attribute
dce5121d-0031-41bc-abaf-0a0e5fd0fcae	true	id.token.claim
dce5121d-0031-41bc-abaf-0a0e5fd0fcae	true	access.token.claim
dce5121d-0031-41bc-abaf-0a0e5fd0fcae	given_name	claim.name
dce5121d-0031-41bc-abaf-0a0e5fd0fcae	String	jsonType.label
df6495fe-8a8d-4d9b-a786-50fd55841b53	true	userinfo.token.claim
df6495fe-8a8d-4d9b-a786-50fd55841b53	middleName	user.attribute
df6495fe-8a8d-4d9b-a786-50fd55841b53	true	id.token.claim
df6495fe-8a8d-4d9b-a786-50fd55841b53	true	access.token.claim
df6495fe-8a8d-4d9b-a786-50fd55841b53	middle_name	claim.name
df6495fe-8a8d-4d9b-a786-50fd55841b53	String	jsonType.label
46218efe-c8a8-425f-a385-e43bdcec66bd	true	userinfo.token.claim
46218efe-c8a8-425f-a385-e43bdcec66bd	nickname	user.attribute
46218efe-c8a8-425f-a385-e43bdcec66bd	true	id.token.claim
46218efe-c8a8-425f-a385-e43bdcec66bd	true	access.token.claim
46218efe-c8a8-425f-a385-e43bdcec66bd	nickname	claim.name
46218efe-c8a8-425f-a385-e43bdcec66bd	String	jsonType.label
0cfc211e-b517-4513-ba8b-77d5552137dd	true	userinfo.token.claim
0cfc211e-b517-4513-ba8b-77d5552137dd	username	user.attribute
0cfc211e-b517-4513-ba8b-77d5552137dd	true	id.token.claim
0cfc211e-b517-4513-ba8b-77d5552137dd	true	access.token.claim
0cfc211e-b517-4513-ba8b-77d5552137dd	preferred_username	claim.name
0cfc211e-b517-4513-ba8b-77d5552137dd	String	jsonType.label
42aa1da0-330b-4bc1-8e3c-ba6b53b34d31	true	userinfo.token.claim
42aa1da0-330b-4bc1-8e3c-ba6b53b34d31	profile	user.attribute
42aa1da0-330b-4bc1-8e3c-ba6b53b34d31	true	id.token.claim
42aa1da0-330b-4bc1-8e3c-ba6b53b34d31	true	access.token.claim
42aa1da0-330b-4bc1-8e3c-ba6b53b34d31	profile	claim.name
42aa1da0-330b-4bc1-8e3c-ba6b53b34d31	String	jsonType.label
b96cbf86-b62e-4141-9b06-f915307fefd1	true	userinfo.token.claim
b96cbf86-b62e-4141-9b06-f915307fefd1	picture	user.attribute
b96cbf86-b62e-4141-9b06-f915307fefd1	true	id.token.claim
b96cbf86-b62e-4141-9b06-f915307fefd1	true	access.token.claim
b96cbf86-b62e-4141-9b06-f915307fefd1	picture	claim.name
b96cbf86-b62e-4141-9b06-f915307fefd1	String	jsonType.label
2ddc21c1-2b42-4369-adf9-ac59805583d2	true	userinfo.token.claim
2ddc21c1-2b42-4369-adf9-ac59805583d2	website	user.attribute
2ddc21c1-2b42-4369-adf9-ac59805583d2	true	id.token.claim
2ddc21c1-2b42-4369-adf9-ac59805583d2	true	access.token.claim
2ddc21c1-2b42-4369-adf9-ac59805583d2	website	claim.name
2ddc21c1-2b42-4369-adf9-ac59805583d2	String	jsonType.label
085b665a-6236-4187-bce2-f6ec5be85a4d	true	userinfo.token.claim
085b665a-6236-4187-bce2-f6ec5be85a4d	gender	user.attribute
085b665a-6236-4187-bce2-f6ec5be85a4d	true	id.token.claim
085b665a-6236-4187-bce2-f6ec5be85a4d	true	access.token.claim
085b665a-6236-4187-bce2-f6ec5be85a4d	gender	claim.name
085b665a-6236-4187-bce2-f6ec5be85a4d	String	jsonType.label
4a5f94bc-4249-4982-9c3d-27e8dbe21c28	true	userinfo.token.claim
4a5f94bc-4249-4982-9c3d-27e8dbe21c28	birthdate	user.attribute
4a5f94bc-4249-4982-9c3d-27e8dbe21c28	true	id.token.claim
4a5f94bc-4249-4982-9c3d-27e8dbe21c28	true	access.token.claim
4a5f94bc-4249-4982-9c3d-27e8dbe21c28	birthdate	claim.name
4a5f94bc-4249-4982-9c3d-27e8dbe21c28	String	jsonType.label
59b027ab-78cb-44a4-844a-b9e6bbba8c12	true	userinfo.token.claim
59b027ab-78cb-44a4-844a-b9e6bbba8c12	zoneinfo	user.attribute
59b027ab-78cb-44a4-844a-b9e6bbba8c12	true	id.token.claim
59b027ab-78cb-44a4-844a-b9e6bbba8c12	true	access.token.claim
59b027ab-78cb-44a4-844a-b9e6bbba8c12	zoneinfo	claim.name
59b027ab-78cb-44a4-844a-b9e6bbba8c12	String	jsonType.label
22d755ca-33d7-49f0-ab8c-107f8689a780	true	userinfo.token.claim
22d755ca-33d7-49f0-ab8c-107f8689a780	locale	user.attribute
22d755ca-33d7-49f0-ab8c-107f8689a780	true	id.token.claim
22d755ca-33d7-49f0-ab8c-107f8689a780	true	access.token.claim
22d755ca-33d7-49f0-ab8c-107f8689a780	locale	claim.name
22d755ca-33d7-49f0-ab8c-107f8689a780	String	jsonType.label
1fffd00b-314b-45eb-a9e2-405737d923dc	true	userinfo.token.claim
1fffd00b-314b-45eb-a9e2-405737d923dc	updatedAt	user.attribute
1fffd00b-314b-45eb-a9e2-405737d923dc	true	id.token.claim
1fffd00b-314b-45eb-a9e2-405737d923dc	true	access.token.claim
1fffd00b-314b-45eb-a9e2-405737d923dc	updated_at	claim.name
1fffd00b-314b-45eb-a9e2-405737d923dc	long	jsonType.label
984191e4-d418-4b93-8298-aa466c458bea	true	userinfo.token.claim
984191e4-d418-4b93-8298-aa466c458bea	email	user.attribute
984191e4-d418-4b93-8298-aa466c458bea	true	id.token.claim
984191e4-d418-4b93-8298-aa466c458bea	true	access.token.claim
984191e4-d418-4b93-8298-aa466c458bea	email	claim.name
984191e4-d418-4b93-8298-aa466c458bea	String	jsonType.label
23e2a75f-5385-4ee6-b8e5-c6cfeefb0f05	true	userinfo.token.claim
23e2a75f-5385-4ee6-b8e5-c6cfeefb0f05	emailVerified	user.attribute
23e2a75f-5385-4ee6-b8e5-c6cfeefb0f05	true	id.token.claim
23e2a75f-5385-4ee6-b8e5-c6cfeefb0f05	true	access.token.claim
23e2a75f-5385-4ee6-b8e5-c6cfeefb0f05	email_verified	claim.name
23e2a75f-5385-4ee6-b8e5-c6cfeefb0f05	boolean	jsonType.label
a5d4c0a4-e4f9-4d0b-8dbf-2a6b5cb87f9c	formatted	user.attribute.formatted
a5d4c0a4-e4f9-4d0b-8dbf-2a6b5cb87f9c	country	user.attribute.country
a5d4c0a4-e4f9-4d0b-8dbf-2a6b5cb87f9c	postal_code	user.attribute.postal_code
a5d4c0a4-e4f9-4d0b-8dbf-2a6b5cb87f9c	true	userinfo.token.claim
a5d4c0a4-e4f9-4d0b-8dbf-2a6b5cb87f9c	street	user.attribute.street
a5d4c0a4-e4f9-4d0b-8dbf-2a6b5cb87f9c	true	id.token.claim
a5d4c0a4-e4f9-4d0b-8dbf-2a6b5cb87f9c	region	user.attribute.region
a5d4c0a4-e4f9-4d0b-8dbf-2a6b5cb87f9c	true	access.token.claim
a5d4c0a4-e4f9-4d0b-8dbf-2a6b5cb87f9c	locality	user.attribute.locality
878d6e5a-b743-4fa3-a2e7-724a1343b59d	true	userinfo.token.claim
878d6e5a-b743-4fa3-a2e7-724a1343b59d	phoneNumber	user.attribute
878d6e5a-b743-4fa3-a2e7-724a1343b59d	true	id.token.claim
878d6e5a-b743-4fa3-a2e7-724a1343b59d	true	access.token.claim
878d6e5a-b743-4fa3-a2e7-724a1343b59d	phone_number	claim.name
878d6e5a-b743-4fa3-a2e7-724a1343b59d	String	jsonType.label
e2a41632-ab44-41a2-b0ca-a5f34f169b1f	true	userinfo.token.claim
e2a41632-ab44-41a2-b0ca-a5f34f169b1f	phoneNumberVerified	user.attribute
e2a41632-ab44-41a2-b0ca-a5f34f169b1f	true	id.token.claim
e2a41632-ab44-41a2-b0ca-a5f34f169b1f	true	access.token.claim
e2a41632-ab44-41a2-b0ca-a5f34f169b1f	phone_number_verified	claim.name
e2a41632-ab44-41a2-b0ca-a5f34f169b1f	boolean	jsonType.label
a923793b-a4dd-44d4-ab35-d80afda1439d	true	multivalued
a923793b-a4dd-44d4-ab35-d80afda1439d	foo	user.attribute
a923793b-a4dd-44d4-ab35-d80afda1439d	true	access.token.claim
a923793b-a4dd-44d4-ab35-d80afda1439d	realm_access.roles	claim.name
a923793b-a4dd-44d4-ab35-d80afda1439d	String	jsonType.label
5da2d373-6f82-4ecf-ac61-f939f5937bc6	true	multivalued
5da2d373-6f82-4ecf-ac61-f939f5937bc6	foo	user.attribute
5da2d373-6f82-4ecf-ac61-f939f5937bc6	true	access.token.claim
5da2d373-6f82-4ecf-ac61-f939f5937bc6	resource_access.${client_id}.roles	claim.name
5da2d373-6f82-4ecf-ac61-f939f5937bc6	String	jsonType.label
75feafd3-f41f-4a14-9613-feece8257ee8	true	userinfo.token.claim
75feafd3-f41f-4a14-9613-feece8257ee8	username	user.attribute
75feafd3-f41f-4a14-9613-feece8257ee8	true	id.token.claim
75feafd3-f41f-4a14-9613-feece8257ee8	true	access.token.claim
75feafd3-f41f-4a14-9613-feece8257ee8	upn	claim.name
75feafd3-f41f-4a14-9613-feece8257ee8	String	jsonType.label
81bd3a0e-cf3a-4bf8-8c3d-e52542230e74	true	multivalued
81bd3a0e-cf3a-4bf8-8c3d-e52542230e74	foo	user.attribute
81bd3a0e-cf3a-4bf8-8c3d-e52542230e74	true	id.token.claim
81bd3a0e-cf3a-4bf8-8c3d-e52542230e74	true	access.token.claim
81bd3a0e-cf3a-4bf8-8c3d-e52542230e74	groups	claim.name
81bd3a0e-cf3a-4bf8-8c3d-e52542230e74	String	jsonType.label
f14cd9bf-ebd9-43a1-9255-7a849ed27b94	true	id.token.claim
f14cd9bf-ebd9-43a1-9255-7a849ed27b94	true	access.token.claim
caf69847-24e1-4f92-b801-5a09e47a5b66	foo	user.attribute
caf69847-24e1-4f92-b801-5a09e47a5b66	true	access.token.claim
caf69847-24e1-4f92-b801-5a09e47a5b66	resource_access.${client_id}.roles	claim.name
caf69847-24e1-4f92-b801-5a09e47a5b66	String	jsonType.label
caf69847-24e1-4f92-b801-5a09e47a5b66	true	multivalued
4229f990-6e15-49e1-9eeb-33b9930b267c	foo	user.attribute
4229f990-6e15-49e1-9eeb-33b9930b267c	true	access.token.claim
4229f990-6e15-49e1-9eeb-33b9930b267c	realm_access.roles	claim.name
4229f990-6e15-49e1-9eeb-33b9930b267c	String	jsonType.label
4229f990-6e15-49e1-9eeb-33b9930b267c	true	multivalued
4f820837-62fb-45ce-9517-5580a2ec10a8	false	single
4f820837-62fb-45ce-9517-5580a2ec10a8	Basic	attribute.nameformat
4f820837-62fb-45ce-9517-5580a2ec10a8	Role	attribute.name
d2c969c7-ee34-4982-bc3c-7bff3c286fd7	true	multivalued
d2c969c7-ee34-4982-bc3c-7bff3c286fd7	true	userinfo.token.claim
d2c969c7-ee34-4982-bc3c-7bff3c286fd7	foo	user.attribute
d2c969c7-ee34-4982-bc3c-7bff3c286fd7	true	id.token.claim
d2c969c7-ee34-4982-bc3c-7bff3c286fd7	true	access.token.claim
d2c969c7-ee34-4982-bc3c-7bff3c286fd7	groups	claim.name
d2c969c7-ee34-4982-bc3c-7bff3c286fd7	String	jsonType.label
2a906541-6bb1-4f90-9b5d-843e0391b7ac	true	userinfo.token.claim
2a906541-6bb1-4f90-9b5d-843e0391b7ac	username	user.attribute
2a906541-6bb1-4f90-9b5d-843e0391b7ac	true	id.token.claim
2a906541-6bb1-4f90-9b5d-843e0391b7ac	true	access.token.claim
2a906541-6bb1-4f90-9b5d-843e0391b7ac	upn	claim.name
2a906541-6bb1-4f90-9b5d-843e0391b7ac	String	jsonType.label
800432cf-3681-48dc-b79b-400b85080f07	true	userinfo.token.claim
800432cf-3681-48dc-b79b-400b85080f07	birthdate	user.attribute
800432cf-3681-48dc-b79b-400b85080f07	true	id.token.claim
800432cf-3681-48dc-b79b-400b85080f07	true	access.token.claim
800432cf-3681-48dc-b79b-400b85080f07	birthdate	claim.name
800432cf-3681-48dc-b79b-400b85080f07	String	jsonType.label
ba95db0d-1548-4720-8849-00848c131b10	true	id.token.claim
ba95db0d-1548-4720-8849-00848c131b10	true	access.token.claim
ba95db0d-1548-4720-8849-00848c131b10	true	userinfo.token.claim
871064ca-5938-4db0-b632-ee0d1724dede	true	userinfo.token.claim
871064ca-5938-4db0-b632-ee0d1724dede	locale	user.attribute
871064ca-5938-4db0-b632-ee0d1724dede	true	id.token.claim
871064ca-5938-4db0-b632-ee0d1724dede	true	access.token.claim
871064ca-5938-4db0-b632-ee0d1724dede	locale	claim.name
871064ca-5938-4db0-b632-ee0d1724dede	String	jsonType.label
593633b6-58ef-442f-95d3-fcfadfb3a379	true	userinfo.token.claim
593633b6-58ef-442f-95d3-fcfadfb3a379	middleName	user.attribute
593633b6-58ef-442f-95d3-fcfadfb3a379	true	id.token.claim
593633b6-58ef-442f-95d3-fcfadfb3a379	true	access.token.claim
593633b6-58ef-442f-95d3-fcfadfb3a379	middle_name	claim.name
593633b6-58ef-442f-95d3-fcfadfb3a379	String	jsonType.label
113010ac-0884-49a4-8c70-816a16af3bb3	true	userinfo.token.claim
113010ac-0884-49a4-8c70-816a16af3bb3	gender	user.attribute
113010ac-0884-49a4-8c70-816a16af3bb3	true	id.token.claim
113010ac-0884-49a4-8c70-816a16af3bb3	true	access.token.claim
113010ac-0884-49a4-8c70-816a16af3bb3	gender	claim.name
113010ac-0884-49a4-8c70-816a16af3bb3	String	jsonType.label
32ff5641-e28b-4c1e-ac01-f71acbabc820	true	userinfo.token.claim
32ff5641-e28b-4c1e-ac01-f71acbabc820	updatedAt	user.attribute
32ff5641-e28b-4c1e-ac01-f71acbabc820	true	id.token.claim
32ff5641-e28b-4c1e-ac01-f71acbabc820	true	access.token.claim
32ff5641-e28b-4c1e-ac01-f71acbabc820	updated_at	claim.name
32ff5641-e28b-4c1e-ac01-f71acbabc820	long	jsonType.label
23c33372-0372-4179-a314-78e26f21b4d2	true	userinfo.token.claim
23c33372-0372-4179-a314-78e26f21b4d2	zoneinfo	user.attribute
23c33372-0372-4179-a314-78e26f21b4d2	true	id.token.claim
23c33372-0372-4179-a314-78e26f21b4d2	true	access.token.claim
23c33372-0372-4179-a314-78e26f21b4d2	zoneinfo	claim.name
23c33372-0372-4179-a314-78e26f21b4d2	String	jsonType.label
95697b76-b208-40ef-bfc6-e3edc79ed8f7	true	userinfo.token.claim
95697b76-b208-40ef-bfc6-e3edc79ed8f7	firstName	user.attribute
95697b76-b208-40ef-bfc6-e3edc79ed8f7	true	id.token.claim
95697b76-b208-40ef-bfc6-e3edc79ed8f7	true	access.token.claim
95697b76-b208-40ef-bfc6-e3edc79ed8f7	given_name	claim.name
95697b76-b208-40ef-bfc6-e3edc79ed8f7	String	jsonType.label
0d464d63-d8dc-4c88-9e95-850839a0ee0f	true	userinfo.token.claim
0d464d63-d8dc-4c88-9e95-850839a0ee0f	picture	user.attribute
0d464d63-d8dc-4c88-9e95-850839a0ee0f	true	id.token.claim
0d464d63-d8dc-4c88-9e95-850839a0ee0f	true	access.token.claim
0d464d63-d8dc-4c88-9e95-850839a0ee0f	picture	claim.name
0d464d63-d8dc-4c88-9e95-850839a0ee0f	String	jsonType.label
685634ba-b026-4393-9353-9f399e63b627	true	userinfo.token.claim
685634ba-b026-4393-9353-9f399e63b627	website	user.attribute
685634ba-b026-4393-9353-9f399e63b627	true	id.token.claim
685634ba-b026-4393-9353-9f399e63b627	true	access.token.claim
685634ba-b026-4393-9353-9f399e63b627	website	claim.name
685634ba-b026-4393-9353-9f399e63b627	String	jsonType.label
1871860e-d5eb-42bd-8438-082ae0cc17c0	true	userinfo.token.claim
1871860e-d5eb-42bd-8438-082ae0cc17c0	username	user.attribute
1871860e-d5eb-42bd-8438-082ae0cc17c0	true	id.token.claim
1871860e-d5eb-42bd-8438-082ae0cc17c0	true	access.token.claim
1871860e-d5eb-42bd-8438-082ae0cc17c0	preferred_username	claim.name
1871860e-d5eb-42bd-8438-082ae0cc17c0	String	jsonType.label
2b56929d-c0c6-4c17-8278-de8df834bae2	true	userinfo.token.claim
2b56929d-c0c6-4c17-8278-de8df834bae2	lastName	user.attribute
2b56929d-c0c6-4c17-8278-de8df834bae2	true	id.token.claim
2b56929d-c0c6-4c17-8278-de8df834bae2	true	access.token.claim
2b56929d-c0c6-4c17-8278-de8df834bae2	family_name	claim.name
2b56929d-c0c6-4c17-8278-de8df834bae2	String	jsonType.label
10cc0f04-bd0c-4a73-98ca-b86d8d1c10be	true	userinfo.token.claim
10cc0f04-bd0c-4a73-98ca-b86d8d1c10be	nickname	user.attribute
10cc0f04-bd0c-4a73-98ca-b86d8d1c10be	true	id.token.claim
10cc0f04-bd0c-4a73-98ca-b86d8d1c10be	true	access.token.claim
10cc0f04-bd0c-4a73-98ca-b86d8d1c10be	nickname	claim.name
10cc0f04-bd0c-4a73-98ca-b86d8d1c10be	String	jsonType.label
d5c95ac9-5e91-46ab-8608-40df46c3581f	true	userinfo.token.claim
d5c95ac9-5e91-46ab-8608-40df46c3581f	profile	user.attribute
d5c95ac9-5e91-46ab-8608-40df46c3581f	true	id.token.claim
d5c95ac9-5e91-46ab-8608-40df46c3581f	true	access.token.claim
d5c95ac9-5e91-46ab-8608-40df46c3581f	profile	claim.name
d5c95ac9-5e91-46ab-8608-40df46c3581f	String	jsonType.label
6ed9504b-f3f6-4e46-8049-ebe932dffbe0	true	id.token.claim
6ed9504b-f3f6-4e46-8049-ebe932dffbe0	true	access.token.claim
6ed9504b-f3f6-4e46-8049-ebe932dffbe0	true	userinfo.token.claim
21b10d47-16e4-4cc2-8d62-5de0017fc343	formatted	user.attribute.formatted
21b10d47-16e4-4cc2-8d62-5de0017fc343	country	user.attribute.country
21b10d47-16e4-4cc2-8d62-5de0017fc343	postal_code	user.attribute.postal_code
21b10d47-16e4-4cc2-8d62-5de0017fc343	true	userinfo.token.claim
21b10d47-16e4-4cc2-8d62-5de0017fc343	street	user.attribute.street
21b10d47-16e4-4cc2-8d62-5de0017fc343	true	id.token.claim
21b10d47-16e4-4cc2-8d62-5de0017fc343	region	user.attribute.region
21b10d47-16e4-4cc2-8d62-5de0017fc343	true	access.token.claim
21b10d47-16e4-4cc2-8d62-5de0017fc343	locality	user.attribute.locality
bdc26eeb-d138-4ce9-9080-39e35756d35e	true	userinfo.token.claim
bdc26eeb-d138-4ce9-9080-39e35756d35e	phoneNumberVerified	user.attribute
bdc26eeb-d138-4ce9-9080-39e35756d35e	true	id.token.claim
bdc26eeb-d138-4ce9-9080-39e35756d35e	true	access.token.claim
bdc26eeb-d138-4ce9-9080-39e35756d35e	phone_number_verified	claim.name
bdc26eeb-d138-4ce9-9080-39e35756d35e	boolean	jsonType.label
ae8a91e3-ca13-45d9-a20f-82b0dc7e7293	true	userinfo.token.claim
ae8a91e3-ca13-45d9-a20f-82b0dc7e7293	phoneNumber	user.attribute
ae8a91e3-ca13-45d9-a20f-82b0dc7e7293	true	id.token.claim
ae8a91e3-ca13-45d9-a20f-82b0dc7e7293	true	access.token.claim
ae8a91e3-ca13-45d9-a20f-82b0dc7e7293	phone_number	claim.name
ae8a91e3-ca13-45d9-a20f-82b0dc7e7293	String	jsonType.label
6a6cdfdd-64a1-48e1-809f-cc4ed5773ce1	true	userinfo.token.claim
6a6cdfdd-64a1-48e1-809f-cc4ed5773ce1	email	user.attribute
6a6cdfdd-64a1-48e1-809f-cc4ed5773ce1	true	id.token.claim
6a6cdfdd-64a1-48e1-809f-cc4ed5773ce1	true	access.token.claim
6a6cdfdd-64a1-48e1-809f-cc4ed5773ce1	email	claim.name
6a6cdfdd-64a1-48e1-809f-cc4ed5773ce1	String	jsonType.label
748b4d7f-1eaf-4574-adae-571418d2f271	true	userinfo.token.claim
748b4d7f-1eaf-4574-adae-571418d2f271	emailVerified	user.attribute
748b4d7f-1eaf-4574-adae-571418d2f271	true	id.token.claim
748b4d7f-1eaf-4574-adae-571418d2f271	true	access.token.claim
748b4d7f-1eaf-4574-adae-571418d2f271	email_verified	claim.name
748b4d7f-1eaf-4574-adae-571418d2f271	boolean	jsonType.label
94aa18cf-2b2c-4ded-9717-6e7075778b04	clientHost	user.session.note
94aa18cf-2b2c-4ded-9717-6e7075778b04	true	userinfo.token.claim
94aa18cf-2b2c-4ded-9717-6e7075778b04	true	id.token.claim
94aa18cf-2b2c-4ded-9717-6e7075778b04	true	access.token.claim
94aa18cf-2b2c-4ded-9717-6e7075778b04	clientHost	claim.name
94aa18cf-2b2c-4ded-9717-6e7075778b04	String	jsonType.label
a4039d27-25ac-4eab-80aa-babd3b48b709	clientAddress	user.session.note
a4039d27-25ac-4eab-80aa-babd3b48b709	true	userinfo.token.claim
a4039d27-25ac-4eab-80aa-babd3b48b709	true	id.token.claim
a4039d27-25ac-4eab-80aa-babd3b48b709	true	access.token.claim
a4039d27-25ac-4eab-80aa-babd3b48b709	clientAddress	claim.name
a4039d27-25ac-4eab-80aa-babd3b48b709	String	jsonType.label
61f01bea-5724-4b08-9646-684a5f3838eb	clientId	user.session.note
61f01bea-5724-4b08-9646-684a5f3838eb	true	userinfo.token.claim
61f01bea-5724-4b08-9646-684a5f3838eb	true	id.token.claim
61f01bea-5724-4b08-9646-684a5f3838eb	true	access.token.claim
61f01bea-5724-4b08-9646-684a5f3838eb	clientId	claim.name
61f01bea-5724-4b08-9646-684a5f3838eb	String	jsonType.label
5b97a02f-cd31-403e-98db-b6f26880dc24	clientId	user.session.note
5b97a02f-cd31-403e-98db-b6f26880dc24	true	id.token.claim
5b97a02f-cd31-403e-98db-b6f26880dc24	true	access.token.claim
5b97a02f-cd31-403e-98db-b6f26880dc24	clientId	claim.name
5b97a02f-cd31-403e-98db-b6f26880dc24	String	jsonType.label
5b97a02f-cd31-403e-98db-b6f26880dc24	true	userinfo.token.claim
f0d7c27f-d38c-446e-9349-55ec05bffd3f	clientAddress	user.session.note
f0d7c27f-d38c-446e-9349-55ec05bffd3f	true	id.token.claim
f0d7c27f-d38c-446e-9349-55ec05bffd3f	true	access.token.claim
f0d7c27f-d38c-446e-9349-55ec05bffd3f	clientAddress	claim.name
f0d7c27f-d38c-446e-9349-55ec05bffd3f	String	jsonType.label
3a4da86a-2132-46d0-a825-2719d5344ca7	clientHost	user.session.note
3a4da86a-2132-46d0-a825-2719d5344ca7	true	id.token.claim
3a4da86a-2132-46d0-a825-2719d5344ca7	true	access.token.claim
3a4da86a-2132-46d0-a825-2719d5344ca7	clientHost	claim.name
3a4da86a-2132-46d0-a825-2719d5344ca7	String	jsonType.label
f0d7c27f-d38c-446e-9349-55ec05bffd3f	true	userinfo.token.claim
3a4da86a-2132-46d0-a825-2719d5344ca7	true	userinfo.token.claim
40f17d1d-7a01-460a-b060-8ed4e8ae1a9e	true	userinfo.token.claim
40f17d1d-7a01-460a-b060-8ed4e8ae1a9e	locale	user.attribute
40f17d1d-7a01-460a-b060-8ed4e8ae1a9e	true	id.token.claim
40f17d1d-7a01-460a-b060-8ed4e8ae1a9e	true	access.token.claim
40f17d1d-7a01-460a-b060-8ed4e8ae1a9e	locale	claim.name
40f17d1d-7a01-460a-b060-8ed4e8ae1a9e	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
a7ba7779-875b-4788-99a3-328f298d05b3	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	71de9b6a-70d7-49ad-a469-ad487e0ab7e9	bf1acb06-8db2-4020-9530-60e67daa441a	7e345b1f-eb9e-4ab0-976b-827d1c3d0bf0	4071f835-5419-4776-bad5-795f323a2927	fb6e7ae4-ceeb-4475-99ba-f63b3c73daec	2592000	f	900	t	f	8417162e-11e8-4373-ab62-e8d15a9edd61	0	f	0	0	2390bb88-23d8-469d-8399-764197dda005
8eee160c-5edd-481a-b964-c368a057e598	60	300	300	\N	\N	\N	t	f	0	\N	BakerTech	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	d0bd1619-802f-413e-bca4-31bbce9059a1	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	a6633ee8-cc41-4751-9c29-83a01f6772ef	2b3a7059-60e6-4c84-a94b-d05e5bf98d7b	859b702d-59c5-4eac-b920-5744824ac778	4a7f827d-e6be-418d-a65b-2619fb1eac91	86e02597-dbaa-4f5c-b827-97004b71f580	2592000	f	900	t	f	ecdb11a4-e6fb-4851-bf7f-1eec3e0ac6d6	0	f	0	0	b8430a61-318a-4536-8a67-e07515882ed2
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	a7ba7779-875b-4788-99a3-328f298d05b3	
_browser_header.xContentTypeOptions	a7ba7779-875b-4788-99a3-328f298d05b3	nosniff
_browser_header.xRobotsTag	a7ba7779-875b-4788-99a3-328f298d05b3	none
_browser_header.xFrameOptions	a7ba7779-875b-4788-99a3-328f298d05b3	SAMEORIGIN
_browser_header.contentSecurityPolicy	a7ba7779-875b-4788-99a3-328f298d05b3	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	a7ba7779-875b-4788-99a3-328f298d05b3	1; mode=block
_browser_header.strictTransportSecurity	a7ba7779-875b-4788-99a3-328f298d05b3	max-age=31536000; includeSubDomains
bruteForceProtected	a7ba7779-875b-4788-99a3-328f298d05b3	false
permanentLockout	a7ba7779-875b-4788-99a3-328f298d05b3	false
maxFailureWaitSeconds	a7ba7779-875b-4788-99a3-328f298d05b3	900
minimumQuickLoginWaitSeconds	a7ba7779-875b-4788-99a3-328f298d05b3	60
waitIncrementSeconds	a7ba7779-875b-4788-99a3-328f298d05b3	60
quickLoginCheckMilliSeconds	a7ba7779-875b-4788-99a3-328f298d05b3	1000
maxDeltaTimeSeconds	a7ba7779-875b-4788-99a3-328f298d05b3	43200
failureFactor	a7ba7779-875b-4788-99a3-328f298d05b3	30
displayName	a7ba7779-875b-4788-99a3-328f298d05b3	Keycloak
displayNameHtml	a7ba7779-875b-4788-99a3-328f298d05b3	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	a7ba7779-875b-4788-99a3-328f298d05b3	RS256
offlineSessionMaxLifespanEnabled	a7ba7779-875b-4788-99a3-328f298d05b3	false
offlineSessionMaxLifespan	a7ba7779-875b-4788-99a3-328f298d05b3	5184000
_browser_header.contentSecurityPolicyReportOnly	8eee160c-5edd-481a-b964-c368a057e598	
_browser_header.xContentTypeOptions	8eee160c-5edd-481a-b964-c368a057e598	nosniff
_browser_header.xRobotsTag	8eee160c-5edd-481a-b964-c368a057e598	none
_browser_header.xFrameOptions	8eee160c-5edd-481a-b964-c368a057e598	SAMEORIGIN
_browser_header.contentSecurityPolicy	8eee160c-5edd-481a-b964-c368a057e598	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	8eee160c-5edd-481a-b964-c368a057e598	1; mode=block
_browser_header.strictTransportSecurity	8eee160c-5edd-481a-b964-c368a057e598	max-age=31536000; includeSubDomains
bruteForceProtected	8eee160c-5edd-481a-b964-c368a057e598	false
permanentLockout	8eee160c-5edd-481a-b964-c368a057e598	false
maxFailureWaitSeconds	8eee160c-5edd-481a-b964-c368a057e598	900
minimumQuickLoginWaitSeconds	8eee160c-5edd-481a-b964-c368a057e598	60
waitIncrementSeconds	8eee160c-5edd-481a-b964-c368a057e598	60
quickLoginCheckMilliSeconds	8eee160c-5edd-481a-b964-c368a057e598	1000
maxDeltaTimeSeconds	8eee160c-5edd-481a-b964-c368a057e598	43200
failureFactor	8eee160c-5edd-481a-b964-c368a057e598	30
defaultSignatureAlgorithm	8eee160c-5edd-481a-b964-c368a057e598	RS256
offlineSessionMaxLifespanEnabled	8eee160c-5edd-481a-b964-c368a057e598	false
offlineSessionMaxLifespan	8eee160c-5edd-481a-b964-c368a057e598	5184000
clientSessionIdleTimeout	8eee160c-5edd-481a-b964-c368a057e598	0
clientSessionMaxLifespan	8eee160c-5edd-481a-b964-c368a057e598	0
clientOfflineSessionIdleTimeout	8eee160c-5edd-481a-b964-c368a057e598	0
clientOfflineSessionMaxLifespan	8eee160c-5edd-481a-b964-c368a057e598	0
actionTokenGeneratedByAdminLifespan	8eee160c-5edd-481a-b964-c368a057e598	43200
actionTokenGeneratedByUserLifespan	8eee160c-5edd-481a-b964-c368a057e598	300
oauth2DeviceCodeLifespan	8eee160c-5edd-481a-b964-c368a057e598	600
oauth2DevicePollingInterval	8eee160c-5edd-481a-b964-c368a057e598	5
webAuthnPolicyRpEntityName	8eee160c-5edd-481a-b964-c368a057e598	keycloak
webAuthnPolicySignatureAlgorithms	8eee160c-5edd-481a-b964-c368a057e598	ES256
webAuthnPolicyRpId	8eee160c-5edd-481a-b964-c368a057e598	
webAuthnPolicyAttestationConveyancePreference	8eee160c-5edd-481a-b964-c368a057e598	not specified
webAuthnPolicyAuthenticatorAttachment	8eee160c-5edd-481a-b964-c368a057e598	not specified
webAuthnPolicyRequireResidentKey	8eee160c-5edd-481a-b964-c368a057e598	not specified
webAuthnPolicyUserVerificationRequirement	8eee160c-5edd-481a-b964-c368a057e598	not specified
webAuthnPolicyCreateTimeout	8eee160c-5edd-481a-b964-c368a057e598	0
webAuthnPolicyAvoidSameAuthenticatorRegister	8eee160c-5edd-481a-b964-c368a057e598	false
webAuthnPolicyRpEntityNamePasswordless	8eee160c-5edd-481a-b964-c368a057e598	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	8eee160c-5edd-481a-b964-c368a057e598	ES256
webAuthnPolicyRpIdPasswordless	8eee160c-5edd-481a-b964-c368a057e598	
webAuthnPolicyAttestationConveyancePreferencePasswordless	8eee160c-5edd-481a-b964-c368a057e598	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	8eee160c-5edd-481a-b964-c368a057e598	not specified
webAuthnPolicyRequireResidentKeyPasswordless	8eee160c-5edd-481a-b964-c368a057e598	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	8eee160c-5edd-481a-b964-c368a057e598	not specified
webAuthnPolicyCreateTimeoutPasswordless	8eee160c-5edd-481a-b964-c368a057e598	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	8eee160c-5edd-481a-b964-c368a057e598	false
cibaBackchannelTokenDeliveryMode	8eee160c-5edd-481a-b964-c368a057e598	poll
cibaExpiresIn	8eee160c-5edd-481a-b964-c368a057e598	120
cibaInterval	8eee160c-5edd-481a-b964-c368a057e598	5
cibaAuthRequestedUserHint	8eee160c-5edd-481a-b964-c368a057e598	login_hint
parRequestUriLifespan	8eee160c-5edd-481a-b964-c368a057e598	60
client-policies.profiles	8eee160c-5edd-481a-b964-c368a057e598	{"profiles":[]}
client-policies.policies	8eee160c-5edd-481a-b964-c368a057e598	{"policies":[]}
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.realm_events_listeners (realm_id, value) FROM stdin;
a7ba7779-875b-4788-99a3-328f298d05b3	jboss-logging
8eee160c-5edd-481a-b964-c368a057e598	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	a7ba7779-875b-4788-99a3-328f298d05b3
password	password	t	t	8eee160c-5edd-481a-b964-c368a057e598
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.redirect_uris (client_id, value) FROM stdin;
530aa4ab-ff70-4256-8abb-0a905d775a99	/realms/master/account/*
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	/realms/master/account/*
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	/admin/master/console/*
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	/realms/BakerTech/account/*
74b39df6-1c8b-4e84-8251-5771ca6a6470	/realms/BakerTech/account/*
92f5bea7-369a-483d-a9ea-a330f05968b5	/realms/BakerTech/bakertech/*
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	/admin/BakerTech/console/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
b296e741-cc34-43fb-b27c-3d416a94528b	VERIFY_EMAIL	Verify Email	a7ba7779-875b-4788-99a3-328f298d05b3	t	f	VERIFY_EMAIL	50
1a5cfed0-59b1-4011-a8be-0bc6680b8044	UPDATE_PROFILE	Update Profile	a7ba7779-875b-4788-99a3-328f298d05b3	t	f	UPDATE_PROFILE	40
ecc2c241-70eb-429c-b7ef-2d6233c8379f	CONFIGURE_TOTP	Configure OTP	a7ba7779-875b-4788-99a3-328f298d05b3	t	f	CONFIGURE_TOTP	10
3e83a14a-542b-47a0-8865-1f825901100d	UPDATE_PASSWORD	Update Password	a7ba7779-875b-4788-99a3-328f298d05b3	t	f	UPDATE_PASSWORD	30
10dd61b1-baf3-46c4-bbcd-99056ecad387	terms_and_conditions	Terms and Conditions	a7ba7779-875b-4788-99a3-328f298d05b3	f	f	terms_and_conditions	20
f418b003-de7c-40cc-8d4a-e90981b478b3	update_user_locale	Update User Locale	a7ba7779-875b-4788-99a3-328f298d05b3	t	f	update_user_locale	1000
a552ef22-5f40-4f21-b5e2-c422ab405fa7	delete_account	Delete Account	a7ba7779-875b-4788-99a3-328f298d05b3	f	f	delete_account	60
b033bc7e-77a3-4a89-b629-a98cdc0df9a9	webauthn-register	Webauthn Register	a7ba7779-875b-4788-99a3-328f298d05b3	t	f	webauthn-register	70
62e932f1-876b-463f-866c-fa3c70f3d94f	webauthn-register-passwordless	Webauthn Register Passwordless	a7ba7779-875b-4788-99a3-328f298d05b3	t	f	webauthn-register-passwordless	80
a8320619-5533-44e4-9b02-b2eb5ee54d31	CONFIGURE_TOTP	Configure OTP	8eee160c-5edd-481a-b964-c368a057e598	t	f	CONFIGURE_TOTP	10
58630ac5-5705-482d-aec5-9700c0d1833f	terms_and_conditions	Terms and Conditions	8eee160c-5edd-481a-b964-c368a057e598	f	f	terms_and_conditions	20
c5b5c0d4-0ec6-4eef-88b8-73a5153ffcd9	UPDATE_PASSWORD	Update Password	8eee160c-5edd-481a-b964-c368a057e598	t	f	UPDATE_PASSWORD	30
90f64b81-1f94-485f-b74b-e040d6e506fd	UPDATE_PROFILE	Update Profile	8eee160c-5edd-481a-b964-c368a057e598	t	f	UPDATE_PROFILE	40
3ba49c85-673e-4b3c-aecc-4da28f9fc27f	VERIFY_EMAIL	Verify Email	8eee160c-5edd-481a-b964-c368a057e598	t	f	VERIFY_EMAIL	50
1b1d457d-a643-4dd2-8381-fd766aa8d2cf	delete_account	Delete Account	8eee160c-5edd-481a-b964-c368a057e598	f	f	delete_account	60
148d8350-b461-4d82-9dd8-ab11e9c77fd4	webauthn-register	Webauthn Register	8eee160c-5edd-481a-b964-c368a057e598	t	f	webauthn-register	70
b07e36cf-6b50-4a3c-9c81-f920471ac8a8	webauthn-register-passwordless	Webauthn Register Passwordless	8eee160c-5edd-481a-b964-c368a057e598	t	f	webauthn-register-passwordless	80
64e8e2d1-4070-41bc-8bac-2980757f0bfb	update_user_locale	Update User Locale	8eee160c-5edd-481a-b964-c368a057e598	t	f	update_user_locale	1000
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
39610acb-a894-4f24-811f-08d0590f7f79	f	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
c5c28379-d452-4d20-8816-7a101540d60f	map-role	\N	39610acb-a894-4f24-811f-08d0590f7f79	\N
d202549b-cb72-4541-a787-431d92cf6afd	map-role-client-scope	\N	39610acb-a894-4f24-811f-08d0590f7f79	\N
dce2dde4-f901-4ade-a0f4-60eb904949da	map-role-composite	\N	39610acb-a894-4f24-811f-08d0590f7f79	\N
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.scope_mapping (client_id, role_id) FROM stdin;
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	5e5b9d0e-7035-45d5-bd68-bb345180da84
74b39df6-1c8b-4e84-8251-5771ca6a6470	ce904331-e00c-4157-a4de-e2fbe6cef12f
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
fa9a03d5-2ec0-45cd-a584-6d9231ffa3bf	stary2111@gmail.com	stary2111@gmail.com	f	t	\N	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	bakertech-admin	1695232703564	\N	0
dc28b372-c259-41ce-9cf8-86abfd1f81a2	\N	ae4bd311-569f-4fc9-a647-cf8df266db72	f	t	\N	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	service-account-bakertech	1694027351461	92f5bea7-369a-483d-a9ea-a330f05968b5	0
19ca5976-ff4e-410f-bcdf-240e902d6aa8	\N	be7053c0-3602-4625-8474-fee167b81ea9	f	t	\N	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	service-account-realm-management	1694455940952	39610acb-a894-4f24-811f-08d0590f7f79	0
c2ce3624-9d13-47fa-98ea-4075b0fb180b	\N	459a0d81-32a8-4d31-86f3-76fb66b955b9	f	t	\N	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	admin	1695580876278	\N	0
c3e9b1e5-4363-4d11-b01f-7e6d77e35433	cj237@gmail.com	cj237@gmail.com	f	t	\N	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	carljohnson2137	1696185376947	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_group_membership (group_id, user_id) FROM stdin;
c6e58693-64c1-4c5a-809e-49da74d2ce30	fa9a03d5-2ec0-45cd-a584-6d9231ffa3bf
a2f5c0c5-6aea-40eb-9cc5-cdd625991e95	c3e9b1e5-4363-4d11-b01f-7e6d77e35433
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_role_mapping (role_id, user_id) FROM stdin;
b8430a61-318a-4536-8a67-e07515882ed2	dc28b372-c259-41ce-9cf8-86abfd1f81a2
163ce16a-8982-43a5-b2a3-fb1aec2d228c	dc28b372-c259-41ce-9cf8-86abfd1f81a2
58ee82ca-f23c-4747-9984-9f20a3eeda23	dc28b372-c259-41ce-9cf8-86abfd1f81a2
db2682ad-1530-4a7f-922f-9a8dea19f4d1	dc28b372-c259-41ce-9cf8-86abfd1f81a2
10099c9a-99b6-4f7c-adc0-8e54cbbf6939	dc28b372-c259-41ce-9cf8-86abfd1f81a2
2275587b-3ae1-4c93-9a3c-bd5666fcf695	dc28b372-c259-41ce-9cf8-86abfd1f81a2
942fab8f-595d-4882-b26a-ca721f755519	dc28b372-c259-41ce-9cf8-86abfd1f81a2
757946dd-b8c9-4b27-859a-a9ad555e2dd4	dc28b372-c259-41ce-9cf8-86abfd1f81a2
697690dd-0725-48dd-a074-488f7cd69161	dc28b372-c259-41ce-9cf8-86abfd1f81a2
21a2c0c0-1237-42ab-aeb6-cd9f4751dfcb	dc28b372-c259-41ce-9cf8-86abfd1f81a2
0795eafa-5831-4bb0-89bc-34c57fbcab41	dc28b372-c259-41ce-9cf8-86abfd1f81a2
c31ae3f8-45f1-4d77-a961-e44f58722e59	dc28b372-c259-41ce-9cf8-86abfd1f81a2
84774cb4-f335-4305-b213-02935049e7cb	dc28b372-c259-41ce-9cf8-86abfd1f81a2
edc9153b-f546-41b8-bf81-019bb8af94fd	dc28b372-c259-41ce-9cf8-86abfd1f81a2
20f331fe-dfff-492a-8300-03a516eb6c45	dc28b372-c259-41ce-9cf8-86abfd1f81a2
c95a2125-5ae7-4761-88cf-6214e553c63e	dc28b372-c259-41ce-9cf8-86abfd1f81a2
cf389b40-2527-40a3-93c2-570be37e0d89	dc28b372-c259-41ce-9cf8-86abfd1f81a2
bd515d95-8cc0-4c14-b6cc-b2afc63314b1	dc28b372-c259-41ce-9cf8-86abfd1f81a2
ac5b0414-ba95-4b27-950b-97e08c819f5f	dc28b372-c259-41ce-9cf8-86abfd1f81a2
38bc4704-aacf-4fbb-8659-24e5a4521dd3	dc28b372-c259-41ce-9cf8-86abfd1f81a2
868d8b6b-ed13-47fc-8c53-e90a88947754	dc28b372-c259-41ce-9cf8-86abfd1f81a2
3b370eb7-9b41-4e4e-b9b6-ed77e7d627f9	dc28b372-c259-41ce-9cf8-86abfd1f81a2
ce904331-e00c-4157-a4de-e2fbe6cef12f	dc28b372-c259-41ce-9cf8-86abfd1f81a2
5b9d18b7-a864-4619-9c54-2eede09cb669	dc28b372-c259-41ce-9cf8-86abfd1f81a2
387d8dba-a69c-4c1d-8873-aca3a7b4712f	dc28b372-c259-41ce-9cf8-86abfd1f81a2
b8430a61-318a-4536-8a67-e07515882ed2	19ca5976-ff4e-410f-bcdf-240e902d6aa8
ec9a25c1-c145-4f65-9a77-765ae805f9cc	19ca5976-ff4e-410f-bcdf-240e902d6aa8
2390bb88-23d8-469d-8399-764197dda005	c2ce3624-9d13-47fa-98ea-4075b0fb180b
3346375c-ae15-476f-8a16-91310b1cf560	c2ce3624-9d13-47fa-98ea-4075b0fb180b
b8430a61-318a-4536-8a67-e07515882ed2	c3e9b1e5-4363-4d11-b01f-7e6d77e35433
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.web_origins (client_id, value) FROM stdin;
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	+
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_admin_event_time ON keycloak.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON keycloak.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_auth_config_realm ON keycloak.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_auth_exec_flow ON keycloak.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_auth_exec_realm_flow ON keycloak.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_auth_flow_realm ON keycloak.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_cl_clscope ON keycloak.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_client_att_by_name_value ON keycloak.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_client_id; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_client_id ON keycloak.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_client_init_acc_realm ON keycloak.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_client_session_session ON keycloak.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_clscope_attrs ON keycloak.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_clscope_cl ON keycloak.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_clscope_protmap ON keycloak.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_clscope_role ON keycloak.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_compo_config_compo ON keycloak.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_component_provider_type ON keycloak.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_component_realm ON keycloak.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_composite ON keycloak.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_composite_child ON keycloak.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_defcls_realm ON keycloak.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_defcls_scope ON keycloak.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_event_time ON keycloak.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_fedidentity_feduser ON keycloak.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_fedidentity_user ON keycloak.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_fu_attribute ON keycloak.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_fu_cnsnt_ext ON keycloak.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_fu_consent ON keycloak.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_fu_consent_ru ON keycloak.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_fu_credential ON keycloak.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_fu_credential_ru ON keycloak.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_fu_group_membership ON keycloak.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_fu_group_membership_ru ON keycloak.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_fu_required_action ON keycloak.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_fu_required_action_ru ON keycloak.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_fu_role_mapping ON keycloak.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_fu_role_mapping_ru ON keycloak.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_group_attr_group ON keycloak.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_group_role_mapp_group ON keycloak.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_id_prov_mapp_realm ON keycloak.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_ident_prov_realm ON keycloak.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_keycloak_role_client ON keycloak.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_keycloak_role_realm ON keycloak.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_offline_css_preload ON keycloak.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_offline_uss_by_user ON keycloak.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_offline_uss_by_usersess ON keycloak.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_offline_uss_createdon ON keycloak.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_offline_uss_preload ON keycloak.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_protocol_mapper_client ON keycloak.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_realm_attr_realm ON keycloak.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_realm_clscope ON keycloak.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_realm_def_grp_realm ON keycloak.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_realm_evt_list_realm ON keycloak.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_realm_evt_types_realm ON keycloak.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_realm_master_adm_cli ON keycloak.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_realm_supp_local_realm ON keycloak.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_redir_uri_client ON keycloak.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_req_act_prov_realm ON keycloak.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_res_policy_policy ON keycloak.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_res_scope_scope ON keycloak.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_res_serv_pol_res_serv ON keycloak.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_res_srv_res_res_srv ON keycloak.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_res_srv_scope_res_srv ON keycloak.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_role_attribute ON keycloak.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_role_clscope ON keycloak.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_scope_mapping_role ON keycloak.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_scope_policy_policy ON keycloak.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_update_time ON keycloak.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON keycloak.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_usconsent_clscope ON keycloak.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_user_attribute ON keycloak.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_user_attribute_name ON keycloak.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_user_consent ON keycloak.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_user_credential ON keycloak.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_user_email ON keycloak.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_user_group_mapping ON keycloak.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_user_reqactions ON keycloak.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_user_role_mapping ON keycloak.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_user_service_account ON keycloak.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_usr_fed_map_fed_prv ON keycloak.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_usr_fed_map_realm ON keycloak.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_usr_fed_prv_realm ON keycloak.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: keycloak; Owner: bakertech
--

CREATE INDEX idx_web_orig_client ON keycloak.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES keycloak.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES keycloak.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES keycloak.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES keycloak.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES keycloak.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES keycloak.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES keycloak.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES keycloak.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES keycloak.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES keycloak.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES keycloak.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES keycloak.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES keycloak.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES keycloak.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES keycloak.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES keycloak.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES keycloak.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES keycloak.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES keycloak.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES keycloak.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES keycloak.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES keycloak.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: keycloak; Owner: bakertech
--

ALTER TABLE ONLY keycloak.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES keycloak.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4 (Debian 15.4-2.pgdg120+1)
-- Dumped by pg_dump version 15.4 (Debian 15.4-2.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
39610acb-a894-4f24-811f-08d0590f7f79	f	0	1
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
a7ba7779-875b-4788-99a3-328f298d05b3	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	71de9b6a-70d7-49ad-a469-ad487e0ab7e9	bf1acb06-8db2-4020-9530-60e67daa441a	7e345b1f-eb9e-4ab0-976b-827d1c3d0bf0	4071f835-5419-4776-bad5-795f323a2927	fb6e7ae4-ceeb-4475-99ba-f63b3c73daec	2592000	f	900	t	f	8417162e-11e8-4373-ab62-e8d15a9edd61	0	f	0	0	2390bb88-23d8-469d-8399-764197dda005
8eee160c-5edd-481a-b964-c368a057e598	60	300	300	\N	\N	\N	t	f	0	\N	BakerTech	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	d0bd1619-802f-413e-bca4-31bbce9059a1	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	a6633ee8-cc41-4751-9c29-83a01f6772ef	2b3a7059-60e6-4c84-a94b-d05e5bf98d7b	859b702d-59c5-4eac-b920-5744824ac778	4a7f827d-e6be-418d-a65b-2619fb1eac91	86e02597-dbaa-4f5c-b827-97004b71f580	2592000	f	900	t	f	ecdb11a4-e6fb-4851-bf7f-1eec3e0ac6d6	0	f	0	0	b8430a61-318a-4536-8a67-e07515882ed2
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
71de9b6a-70d7-49ad-a469-ad487e0ab7e9	browser	browser based authentication	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	t	t
7fd2f281-d6cd-492d-9ace-0b578ff9f8ea	forms	Username, password, otp and other auth forms.	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	f	t
4a8ed191-484f-44bd-bb9d-3310cb55f793	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	f	t
7e345b1f-eb9e-4ab0-976b-827d1c3d0bf0	direct grant	OpenID Connect Resource Owner Grant	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	t	t
12a2d04c-1793-49bf-b35d-7af54eeec565	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	f	t
bf1acb06-8db2-4020-9530-60e67daa441a	registration	registration flow	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	t	t
2569a5a2-a23f-49a8-8956-580bbb80741c	registration form	registration form	a7ba7779-875b-4788-99a3-328f298d05b3	form-flow	f	t
4071f835-5419-4776-bad5-795f323a2927	reset credentials	Reset credentials for a user if they forgot their password or something	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	t	t
3f04c543-fa3d-4463-a565-04c42db61361	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	f	t
fb6e7ae4-ceeb-4475-99ba-f63b3c73daec	clients	Base authentication for clients	a7ba7779-875b-4788-99a3-328f298d05b3	client-flow	t	t
8278d942-9827-41bc-97b8-b22b3e8575e0	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	t	t
be29d494-c389-4dc7-bc96-6de602150208	User creation or linking	Flow for the existing/non-existing user alternatives	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	f	t
771555ca-ca66-4089-8363-e8d085fb9c0e	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	f	t
44c9ee9f-1d8d-40d0-be13-1152197bfc6f	Account verification options	Method with which to verity the existing account	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	f	t
2abd1c2e-dc6f-4339-be6a-edb48f6b1580	Verify Existing Account by Re-authentication	Reauthentication of existing account	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	f	t
12d19b36-8bc8-442f-9cd6-c8643d7e8dec	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	f	t
d878b3de-edad-43fb-9a61-d50c867abdac	saml ecp	SAML ECP Profile Authentication Flow	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	t	t
8417162e-11e8-4373-ab62-e8d15a9edd61	docker auth	Used by Docker clients to authenticate against the IDP	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	t	t
ad7723b5-0ae4-439d-8321-39cefcf742f1	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	t	t
ea89be6d-8ecf-40f3-88e6-1688bafaa047	Authentication Options	Authentication options.	a7ba7779-875b-4788-99a3-328f298d05b3	basic-flow	f	t
d31d9315-ce76-4b8d-919f-9a6a2dea7664	Account verification options	Method with which to verity the existing account	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	f	t
caadfd80-82fb-4e63-8aa9-89484521f382	Authentication Options	Authentication options.	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	f	t
7e516904-307b-4e64-ab2b-716a0ef6ed3a	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	f	t
ad78ff98-5d09-4d3e-9c3c-0a7ea669f3c4	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	f	t
ff1e79dd-c2ab-4579-9500-79db600e8db4	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	f	t
2e50a0d7-485f-42e3-90fd-8cfb0f30139c	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	f	t
6aac7811-f531-4aa3-960c-b0b51c6e6100	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	f	t
1e0a7c45-e61f-4512-971a-92f44fbd635b	User creation or linking	Flow for the existing/non-existing user alternatives	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	f	t
5afb0963-7997-435e-9a8c-d3d5dad6cde9	Verify Existing Account by Re-authentication	Reauthentication of existing account	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	f	t
a6633ee8-cc41-4751-9c29-83a01f6772ef	browser	browser based authentication	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	t	t
86e02597-dbaa-4f5c-b827-97004b71f580	clients	Base authentication for clients	8eee160c-5edd-481a-b964-c368a057e598	client-flow	t	t
859b702d-59c5-4eac-b920-5744824ac778	direct grant	OpenID Connect Resource Owner Grant	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	t	t
ecdb11a4-e6fb-4851-bf7f-1eec3e0ac6d6	docker auth	Used by Docker clients to authenticate against the IDP	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	t	t
2924064d-be95-4e8e-8d99-46c50b069e84	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	t	t
d3dcdfb6-7133-4020-bace-b7954ad2edf2	forms	Username, password, otp and other auth forms.	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	f	t
5f940c08-7cff-4061-b02a-4101d7f5ae6b	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	t	t
2b3a7059-60e6-4c84-a94b-d05e5bf98d7b	registration	registration flow	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	t	t
f3daa608-8901-4617-bf36-3fbb55fae93d	registration form	registration form	8eee160c-5edd-481a-b964-c368a057e598	form-flow	f	t
4a7f827d-e6be-418d-a65b-2619fb1eac91	reset credentials	Reset credentials for a user if they forgot their password or something	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	t	t
e415d8fa-63b1-4968-8874-7401b58e1fcc	saml ecp	SAML ECP Profile Authentication Flow	8eee160c-5edd-481a-b964-c368a057e598	basic-flow	t	t
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
7ca12811-1f0d-4113-bd58-ee4f81c4c5d0	\N	auth-cookie	a7ba7779-875b-4788-99a3-328f298d05b3	71de9b6a-70d7-49ad-a469-ad487e0ab7e9	2	10	f	\N	\N
41e8cc5f-0e83-411a-b50f-62799eb712fa	\N	auth-spnego	a7ba7779-875b-4788-99a3-328f298d05b3	71de9b6a-70d7-49ad-a469-ad487e0ab7e9	3	20	f	\N	\N
e3c00794-363c-44e3-990d-f92a129d8c00	\N	identity-provider-redirector	a7ba7779-875b-4788-99a3-328f298d05b3	71de9b6a-70d7-49ad-a469-ad487e0ab7e9	2	25	f	\N	\N
f588c63e-3786-4468-9c87-879a7f64bc5e	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	71de9b6a-70d7-49ad-a469-ad487e0ab7e9	2	30	t	7fd2f281-d6cd-492d-9ace-0b578ff9f8ea	\N
fe85b166-f0c7-4153-942c-c2eb4f91011b	\N	auth-username-password-form	a7ba7779-875b-4788-99a3-328f298d05b3	7fd2f281-d6cd-492d-9ace-0b578ff9f8ea	0	10	f	\N	\N
a9a6a6f3-524c-4e3f-bc58-710d819a21a2	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	7fd2f281-d6cd-492d-9ace-0b578ff9f8ea	1	20	t	4a8ed191-484f-44bd-bb9d-3310cb55f793	\N
e086b473-5786-4c99-84b2-eeeb0f11f82c	\N	conditional-user-configured	a7ba7779-875b-4788-99a3-328f298d05b3	4a8ed191-484f-44bd-bb9d-3310cb55f793	0	10	f	\N	\N
be957207-d4c6-4ed5-8869-38ebd92b60e5	\N	auth-otp-form	a7ba7779-875b-4788-99a3-328f298d05b3	4a8ed191-484f-44bd-bb9d-3310cb55f793	0	20	f	\N	\N
5fd6a7c1-c2f1-428e-a34d-28dfa6300150	\N	direct-grant-validate-username	a7ba7779-875b-4788-99a3-328f298d05b3	7e345b1f-eb9e-4ab0-976b-827d1c3d0bf0	0	10	f	\N	\N
9e8c6af2-2c92-4a4c-a4bf-4a80918b3520	\N	direct-grant-validate-password	a7ba7779-875b-4788-99a3-328f298d05b3	7e345b1f-eb9e-4ab0-976b-827d1c3d0bf0	0	20	f	\N	\N
3dc634fd-75db-41f2-97a8-84b1c69315b9	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	7e345b1f-eb9e-4ab0-976b-827d1c3d0bf0	1	30	t	12a2d04c-1793-49bf-b35d-7af54eeec565	\N
cc61007c-7587-4bc3-b2d9-5319753e439a	\N	conditional-user-configured	a7ba7779-875b-4788-99a3-328f298d05b3	12a2d04c-1793-49bf-b35d-7af54eeec565	0	10	f	\N	\N
de125882-d7d5-4784-8b75-0083290a79c3	\N	direct-grant-validate-otp	a7ba7779-875b-4788-99a3-328f298d05b3	12a2d04c-1793-49bf-b35d-7af54eeec565	0	20	f	\N	\N
0a7dd0fa-f8ed-40fc-9d4c-8789406b5bce	\N	registration-page-form	a7ba7779-875b-4788-99a3-328f298d05b3	bf1acb06-8db2-4020-9530-60e67daa441a	0	10	t	2569a5a2-a23f-49a8-8956-580bbb80741c	\N
397e9f27-769c-41f5-9cb4-a5e885323cec	\N	registration-user-creation	a7ba7779-875b-4788-99a3-328f298d05b3	2569a5a2-a23f-49a8-8956-580bbb80741c	0	20	f	\N	\N
6f1eff32-79e6-4879-ac90-b2558d1414b4	\N	registration-profile-action	a7ba7779-875b-4788-99a3-328f298d05b3	2569a5a2-a23f-49a8-8956-580bbb80741c	0	40	f	\N	\N
cb453409-ca09-41cc-adbf-3590e9b0c725	\N	registration-password-action	a7ba7779-875b-4788-99a3-328f298d05b3	2569a5a2-a23f-49a8-8956-580bbb80741c	0	50	f	\N	\N
3d12ee09-b054-4882-bb56-710c551f901a	\N	registration-recaptcha-action	a7ba7779-875b-4788-99a3-328f298d05b3	2569a5a2-a23f-49a8-8956-580bbb80741c	3	60	f	\N	\N
8ff8e9b9-fe3f-4abe-9049-ba28032d441e	\N	reset-credentials-choose-user	a7ba7779-875b-4788-99a3-328f298d05b3	4071f835-5419-4776-bad5-795f323a2927	0	10	f	\N	\N
a7ad72c1-811b-41bd-a698-31beeba20077	\N	reset-credential-email	a7ba7779-875b-4788-99a3-328f298d05b3	4071f835-5419-4776-bad5-795f323a2927	0	20	f	\N	\N
94de7772-a4e3-4b8c-afcb-f8e97195a254	\N	reset-password	a7ba7779-875b-4788-99a3-328f298d05b3	4071f835-5419-4776-bad5-795f323a2927	0	30	f	\N	\N
b3fa6e6e-2a4c-4e3e-ba9f-be0080dfcbb3	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	4071f835-5419-4776-bad5-795f323a2927	1	40	t	3f04c543-fa3d-4463-a565-04c42db61361	\N
3e966bac-a7c1-4b3c-a1d4-b38010bd0f8a	\N	conditional-user-configured	a7ba7779-875b-4788-99a3-328f298d05b3	3f04c543-fa3d-4463-a565-04c42db61361	0	10	f	\N	\N
1b0de09b-c4d7-4263-9761-364a04437915	\N	reset-otp	a7ba7779-875b-4788-99a3-328f298d05b3	3f04c543-fa3d-4463-a565-04c42db61361	0	20	f	\N	\N
493f3091-a79c-4ddf-a2ee-b6eadccc9d4b	\N	client-secret	a7ba7779-875b-4788-99a3-328f298d05b3	fb6e7ae4-ceeb-4475-99ba-f63b3c73daec	2	10	f	\N	\N
0ca97bf2-2bce-4afb-911d-4f7241e9a688	\N	client-jwt	a7ba7779-875b-4788-99a3-328f298d05b3	fb6e7ae4-ceeb-4475-99ba-f63b3c73daec	2	20	f	\N	\N
5244161c-a395-4f31-a7ca-92ce9bcd8fc6	\N	client-secret-jwt	a7ba7779-875b-4788-99a3-328f298d05b3	fb6e7ae4-ceeb-4475-99ba-f63b3c73daec	2	30	f	\N	\N
d1ebb591-a584-4da3-817b-3160cd110b1f	\N	client-x509	a7ba7779-875b-4788-99a3-328f298d05b3	fb6e7ae4-ceeb-4475-99ba-f63b3c73daec	2	40	f	\N	\N
2b00c4cd-8678-46f0-8b88-9eeff7b983db	\N	idp-review-profile	a7ba7779-875b-4788-99a3-328f298d05b3	8278d942-9827-41bc-97b8-b22b3e8575e0	0	10	f	\N	528baae5-89f3-4c50-b700-a21388a7c3fd
67f3c1ba-1b32-4375-b270-f57a4f2ea276	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	8278d942-9827-41bc-97b8-b22b3e8575e0	0	20	t	be29d494-c389-4dc7-bc96-6de602150208	\N
41c146cc-c4c2-4b42-96db-319d6da94f8a	\N	idp-create-user-if-unique	a7ba7779-875b-4788-99a3-328f298d05b3	be29d494-c389-4dc7-bc96-6de602150208	2	10	f	\N	1b6574fc-67ef-4945-b0af-b24664cfe8bb
6a2b22ec-e3b6-45de-9121-b1389295d0b6	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	be29d494-c389-4dc7-bc96-6de602150208	2	20	t	771555ca-ca66-4089-8363-e8d085fb9c0e	\N
75ad5858-3e62-4e3f-bf02-f5403aa6fa78	\N	idp-confirm-link	a7ba7779-875b-4788-99a3-328f298d05b3	771555ca-ca66-4089-8363-e8d085fb9c0e	0	10	f	\N	\N
b45ba964-3c4c-427c-b5bf-86ee69b8eea2	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	771555ca-ca66-4089-8363-e8d085fb9c0e	0	20	t	44c9ee9f-1d8d-40d0-be13-1152197bfc6f	\N
67c87cec-ba53-425c-9458-2383eb3a5e3c	\N	idp-email-verification	a7ba7779-875b-4788-99a3-328f298d05b3	44c9ee9f-1d8d-40d0-be13-1152197bfc6f	2	10	f	\N	\N
6a01e362-de54-4573-a446-9966e439b526	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	44c9ee9f-1d8d-40d0-be13-1152197bfc6f	2	20	t	2abd1c2e-dc6f-4339-be6a-edb48f6b1580	\N
fb2c7435-971d-4d15-a1e6-24169918a6b3	\N	idp-username-password-form	a7ba7779-875b-4788-99a3-328f298d05b3	2abd1c2e-dc6f-4339-be6a-edb48f6b1580	0	10	f	\N	\N
709396fc-a24f-4646-86c3-573ec48ce8a1	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	2abd1c2e-dc6f-4339-be6a-edb48f6b1580	1	20	t	12d19b36-8bc8-442f-9cd6-c8643d7e8dec	\N
ecab43d2-922c-4bf6-9328-8fa46d3b606e	\N	conditional-user-configured	a7ba7779-875b-4788-99a3-328f298d05b3	12d19b36-8bc8-442f-9cd6-c8643d7e8dec	0	10	f	\N	\N
b1bc3fe8-0f6f-4808-840b-957b40a325a8	\N	auth-otp-form	a7ba7779-875b-4788-99a3-328f298d05b3	12d19b36-8bc8-442f-9cd6-c8643d7e8dec	0	20	f	\N	\N
2c67dd77-f0d5-4b4a-8b10-bf90c010785d	\N	http-basic-authenticator	a7ba7779-875b-4788-99a3-328f298d05b3	d878b3de-edad-43fb-9a61-d50c867abdac	0	10	f	\N	\N
3d6b9302-de6f-47dc-9917-7af88f516e17	\N	docker-http-basic-authenticator	a7ba7779-875b-4788-99a3-328f298d05b3	8417162e-11e8-4373-ab62-e8d15a9edd61	0	10	f	\N	\N
e549b13d-769f-4ce4-a568-085fee8afb8c	\N	no-cookie-redirect	a7ba7779-875b-4788-99a3-328f298d05b3	ad7723b5-0ae4-439d-8321-39cefcf742f1	0	10	f	\N	\N
1ee93b93-822e-48ca-a4f3-a272402d448a	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	ad7723b5-0ae4-439d-8321-39cefcf742f1	0	20	t	ea89be6d-8ecf-40f3-88e6-1688bafaa047	\N
237ae8ba-28a5-4013-a73b-f19d85770886	\N	basic-auth	a7ba7779-875b-4788-99a3-328f298d05b3	ea89be6d-8ecf-40f3-88e6-1688bafaa047	0	10	f	\N	\N
6cadc136-fea1-4b25-a10b-8cb96feb40be	\N	basic-auth-otp	a7ba7779-875b-4788-99a3-328f298d05b3	ea89be6d-8ecf-40f3-88e6-1688bafaa047	3	20	f	\N	\N
12e6f540-142e-41b5-86ae-ecaf76df0bdc	\N	auth-spnego	a7ba7779-875b-4788-99a3-328f298d05b3	ea89be6d-8ecf-40f3-88e6-1688bafaa047	3	30	f	\N	\N
d6b6905a-e592-43db-aad4-58240619de01	\N	idp-email-verification	8eee160c-5edd-481a-b964-c368a057e598	d31d9315-ce76-4b8d-919f-9a6a2dea7664	2	10	f	\N	\N
2441bb7e-1631-44af-a5ae-576183511fa4	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	d31d9315-ce76-4b8d-919f-9a6a2dea7664	2	20	t	5afb0963-7997-435e-9a8c-d3d5dad6cde9	\N
3c575faf-04d4-485f-82f2-d3708583cce8	\N	basic-auth	8eee160c-5edd-481a-b964-c368a057e598	caadfd80-82fb-4e63-8aa9-89484521f382	0	10	f	\N	\N
56c3f006-02da-492c-b57b-36f04930833d	\N	basic-auth-otp	8eee160c-5edd-481a-b964-c368a057e598	caadfd80-82fb-4e63-8aa9-89484521f382	3	20	f	\N	\N
b76a9633-6e25-4465-9c4a-e6db8c9c5ad3	\N	auth-spnego	8eee160c-5edd-481a-b964-c368a057e598	caadfd80-82fb-4e63-8aa9-89484521f382	3	30	f	\N	\N
c31872fb-bdf0-4401-bd6e-c328b490c1bb	\N	conditional-user-configured	8eee160c-5edd-481a-b964-c368a057e598	7e516904-307b-4e64-ab2b-716a0ef6ed3a	0	10	f	\N	\N
1f8a2849-6d98-4c0c-902a-aa93e118ea9a	\N	auth-otp-form	8eee160c-5edd-481a-b964-c368a057e598	7e516904-307b-4e64-ab2b-716a0ef6ed3a	0	20	f	\N	\N
c59a018e-8f9b-4c9b-8df8-7e612eab94aa	\N	conditional-user-configured	8eee160c-5edd-481a-b964-c368a057e598	ad78ff98-5d09-4d3e-9c3c-0a7ea669f3c4	0	10	f	\N	\N
02d28980-e575-4db7-98e8-8646f804c0b2	\N	direct-grant-validate-otp	8eee160c-5edd-481a-b964-c368a057e598	ad78ff98-5d09-4d3e-9c3c-0a7ea669f3c4	0	20	f	\N	\N
ad5616e5-7bbc-4f28-872e-8e07340820dc	\N	conditional-user-configured	8eee160c-5edd-481a-b964-c368a057e598	ff1e79dd-c2ab-4579-9500-79db600e8db4	0	10	f	\N	\N
0b1e0927-8bf4-4dd4-a6ad-833c28e9dc23	\N	auth-otp-form	8eee160c-5edd-481a-b964-c368a057e598	ff1e79dd-c2ab-4579-9500-79db600e8db4	0	20	f	\N	\N
577939ac-065f-4772-aedf-068528de8ee3	\N	idp-confirm-link	8eee160c-5edd-481a-b964-c368a057e598	2e50a0d7-485f-42e3-90fd-8cfb0f30139c	0	10	f	\N	\N
89cd1297-36ab-4fdd-9be3-46ee1b2ac616	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	2e50a0d7-485f-42e3-90fd-8cfb0f30139c	0	20	t	d31d9315-ce76-4b8d-919f-9a6a2dea7664	\N
f185f880-c4ec-4595-a44a-9654ae27e8b5	\N	conditional-user-configured	8eee160c-5edd-481a-b964-c368a057e598	6aac7811-f531-4aa3-960c-b0b51c6e6100	0	10	f	\N	\N
95b13492-ef96-400f-a6e0-ca173979ef63	\N	reset-otp	8eee160c-5edd-481a-b964-c368a057e598	6aac7811-f531-4aa3-960c-b0b51c6e6100	0	20	f	\N	\N
ee9a79dd-5e1d-40ec-b201-b89e63d70d5b	\N	idp-create-user-if-unique	8eee160c-5edd-481a-b964-c368a057e598	1e0a7c45-e61f-4512-971a-92f44fbd635b	2	10	f	\N	078d5767-6098-4d2d-9f30-db03ea3dc0b6
48797272-3c2e-4946-9f4c-6b4f99fd5d2a	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	1e0a7c45-e61f-4512-971a-92f44fbd635b	2	20	t	2e50a0d7-485f-42e3-90fd-8cfb0f30139c	\N
c033fc7e-f2e3-489c-9b70-04e188381a0e	\N	idp-username-password-form	8eee160c-5edd-481a-b964-c368a057e598	5afb0963-7997-435e-9a8c-d3d5dad6cde9	0	10	f	\N	\N
cacc7504-96f6-4219-b2c0-0756123d3468	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	5afb0963-7997-435e-9a8c-d3d5dad6cde9	1	20	t	ff1e79dd-c2ab-4579-9500-79db600e8db4	\N
4143a41c-f122-4dc4-a486-2f0fc6877d69	\N	auth-cookie	8eee160c-5edd-481a-b964-c368a057e598	a6633ee8-cc41-4751-9c29-83a01f6772ef	2	10	f	\N	\N
01adf0f2-297f-4231-8619-ad1442b8e557	\N	auth-spnego	8eee160c-5edd-481a-b964-c368a057e598	a6633ee8-cc41-4751-9c29-83a01f6772ef	3	20	f	\N	\N
ea238edc-1a36-494a-b9e5-acba804be289	\N	identity-provider-redirector	8eee160c-5edd-481a-b964-c368a057e598	a6633ee8-cc41-4751-9c29-83a01f6772ef	2	25	f	\N	\N
36cc3bdf-f510-417c-aac8-36f496e9186a	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	a6633ee8-cc41-4751-9c29-83a01f6772ef	2	30	t	d3dcdfb6-7133-4020-bace-b7954ad2edf2	\N
118c9414-9bf8-4193-9141-d7b03b0112c4	\N	client-secret	8eee160c-5edd-481a-b964-c368a057e598	86e02597-dbaa-4f5c-b827-97004b71f580	2	10	f	\N	\N
badef713-bcb2-4a6b-b204-1613e1fa6637	\N	client-jwt	8eee160c-5edd-481a-b964-c368a057e598	86e02597-dbaa-4f5c-b827-97004b71f580	2	20	f	\N	\N
822479e1-281e-4f2c-97f4-1a13ea63e315	\N	client-secret-jwt	8eee160c-5edd-481a-b964-c368a057e598	86e02597-dbaa-4f5c-b827-97004b71f580	2	30	f	\N	\N
36c4d4f3-cd12-471a-9bc1-24bb5860c32b	\N	client-x509	8eee160c-5edd-481a-b964-c368a057e598	86e02597-dbaa-4f5c-b827-97004b71f580	2	40	f	\N	\N
7ac60df8-3202-4507-85a3-0fadf18402bc	\N	direct-grant-validate-username	8eee160c-5edd-481a-b964-c368a057e598	859b702d-59c5-4eac-b920-5744824ac778	0	10	f	\N	\N
20989273-1aec-427f-9df1-3ca21d921cf4	\N	direct-grant-validate-password	8eee160c-5edd-481a-b964-c368a057e598	859b702d-59c5-4eac-b920-5744824ac778	0	20	f	\N	\N
04d9997e-a6e8-421c-8104-fa7176af5206	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	859b702d-59c5-4eac-b920-5744824ac778	1	30	t	ad78ff98-5d09-4d3e-9c3c-0a7ea669f3c4	\N
00c8f9cc-3e7b-4fa5-bf23-f2d171e8b84a	\N	docker-http-basic-authenticator	8eee160c-5edd-481a-b964-c368a057e598	ecdb11a4-e6fb-4851-bf7f-1eec3e0ac6d6	0	10	f	\N	\N
02020081-2ad1-473c-acfa-0708b427e4d5	\N	idp-review-profile	8eee160c-5edd-481a-b964-c368a057e598	2924064d-be95-4e8e-8d99-46c50b069e84	0	10	f	\N	65da87b2-5b75-4707-8d25-e18d54a736c7
bd6903ab-6a7f-4808-85da-8f96debb836b	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	2924064d-be95-4e8e-8d99-46c50b069e84	0	20	t	1e0a7c45-e61f-4512-971a-92f44fbd635b	\N
c3a3d096-3113-4122-a992-abaa964e85ef	\N	auth-username-password-form	8eee160c-5edd-481a-b964-c368a057e598	d3dcdfb6-7133-4020-bace-b7954ad2edf2	0	10	f	\N	\N
bec3f2e1-e143-4aa9-a408-dfc7d35501ab	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	d3dcdfb6-7133-4020-bace-b7954ad2edf2	1	20	t	7e516904-307b-4e64-ab2b-716a0ef6ed3a	\N
db010fe6-187d-4010-a18a-6992e6dd0752	\N	no-cookie-redirect	8eee160c-5edd-481a-b964-c368a057e598	5f940c08-7cff-4061-b02a-4101d7f5ae6b	0	10	f	\N	\N
07c6823c-4753-45b6-bb7b-98b90c2aba24	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	5f940c08-7cff-4061-b02a-4101d7f5ae6b	0	20	t	caadfd80-82fb-4e63-8aa9-89484521f382	\N
bd0d4e38-a44e-4042-b0c7-7ab66a6d32c8	\N	registration-page-form	8eee160c-5edd-481a-b964-c368a057e598	2b3a7059-60e6-4c84-a94b-d05e5bf98d7b	0	10	t	f3daa608-8901-4617-bf36-3fbb55fae93d	\N
6c8e03e2-5c60-481a-8a08-dce62af9a2f7	\N	registration-user-creation	8eee160c-5edd-481a-b964-c368a057e598	f3daa608-8901-4617-bf36-3fbb55fae93d	0	20	f	\N	\N
4ecbe0fd-ce08-4172-b273-96ed4ee4208d	\N	registration-profile-action	8eee160c-5edd-481a-b964-c368a057e598	f3daa608-8901-4617-bf36-3fbb55fae93d	0	40	f	\N	\N
d0f2e12f-7d71-491b-95a2-b08e3d98ef9a	\N	registration-password-action	8eee160c-5edd-481a-b964-c368a057e598	f3daa608-8901-4617-bf36-3fbb55fae93d	0	50	f	\N	\N
a2337d07-e663-42f6-8588-70f59da2c0bb	\N	registration-recaptcha-action	8eee160c-5edd-481a-b964-c368a057e598	f3daa608-8901-4617-bf36-3fbb55fae93d	3	60	f	\N	\N
65ab67e9-e29d-41f8-8e0c-6040da155652	\N	reset-credentials-choose-user	8eee160c-5edd-481a-b964-c368a057e598	4a7f827d-e6be-418d-a65b-2619fb1eac91	0	10	f	\N	\N
315288cd-effd-4a08-bb82-badbe02bad18	\N	reset-credential-email	8eee160c-5edd-481a-b964-c368a057e598	4a7f827d-e6be-418d-a65b-2619fb1eac91	0	20	f	\N	\N
2e9f9f25-e674-4ca3-a7b4-0f52c012f4c8	\N	reset-password	8eee160c-5edd-481a-b964-c368a057e598	4a7f827d-e6be-418d-a65b-2619fb1eac91	0	30	f	\N	\N
16901f08-d661-4483-92c0-31e296b20f79	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	4a7f827d-e6be-418d-a65b-2619fb1eac91	1	40	t	6aac7811-f531-4aa3-960c-b0b51c6e6100	\N
2e5ddb0d-f4e6-4ed4-af42-e4edc9dedc4c	\N	http-basic-authenticator	8eee160c-5edd-481a-b964-c368a057e598	e415d8fa-63b1-4968-8874-7401b58e1fcc	0	10	f	\N	\N
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.authenticator_config (id, alias, realm_id) FROM stdin;
528baae5-89f3-4c50-b700-a21388a7c3fd	review profile config	a7ba7779-875b-4788-99a3-328f298d05b3
1b6574fc-67ef-4945-b0af-b24664cfe8bb	create unique user config	a7ba7779-875b-4788-99a3-328f298d05b3
078d5767-6098-4d2d-9f30-db03ea3dc0b6	create unique user config	8eee160c-5edd-481a-b964-c368a057e598
65da87b2-5b75-4707-8d25-e18d54a736c7	review profile config	8eee160c-5edd-481a-b964-c368a057e598
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
528baae5-89f3-4c50-b700-a21388a7c3fd	missing	update.profile.on.first.login
1b6574fc-67ef-4945-b0af-b24664cfe8bb	false	require.password.update.after.registration
078d5767-6098-4d2d-9f30-db03ea3dc0b6	false	require.password.update.after.registration
65da87b2-5b75-4707-8d25-e18d54a736c7	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	f	master-realm	0	f	\N	\N	t	\N	f	a7ba7779-875b-4788-99a3-328f298d05b3	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
530aa4ab-ff70-4256-8abb-0a905d775a99	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	a7ba7779-875b-4788-99a3-328f298d05b3	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	a7ba7779-875b-4788-99a3-328f298d05b3	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
82ccf254-bfc4-462b-97e1-50f2595b7f06	t	f	broker	0	f	\N	\N	t	\N	f	a7ba7779-875b-4788-99a3-328f298d05b3	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	a7ba7779-875b-4788-99a3-328f298d05b3	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
adc7cfaa-ca92-4e9a-adb1-6eb90c9bba02	t	f	admin-cli	0	t	\N	\N	f	\N	f	a7ba7779-875b-4788-99a3-328f298d05b3	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
d0bd1619-802f-413e-bca4-31bbce9059a1	t	f	BakerTech-realm	0	f	\N	\N	t	\N	f	a7ba7779-875b-4788-99a3-328f298d05b3	\N	0	f	f	BakerTech Realm	f	client-secret	\N	\N	\N	t	f	f	f
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	t	f	account	0	t	\N	/realms/BakerTech/account/	f	\N	f	8eee160c-5edd-481a-b964-c368a057e598	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
74b39df6-1c8b-4e84-8251-5771ca6a6470	t	f	account-console	0	t	\N	/realms/BakerTech/account/	f	\N	f	8eee160c-5edd-481a-b964-c368a057e598	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
9c411dbd-4e42-431f-9093-f8c77db6966f	t	f	admin-cli	0	t	\N	\N	f	\N	f	8eee160c-5edd-481a-b964-c368a057e598	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
92f5bea7-369a-483d-a9ea-a330f05968b5	t	t	bakertech	0	f	l0pkoW2RuTFkq8ZE5HOmL07RzRJ83yax	http://localhost:9990/auth/realms/BakerTech/bakertech/	f		f	8eee160c-5edd-481a-b964-c368a057e598	openid-connect	-1	t	f		t	client-secret	${authBaseUrl}		\N	t	f	t	f
80710076-562f-4877-bf9c-7a005d70367b	t	f	broker	0	f	\N	\N	t	\N	f	8eee160c-5edd-481a-b964-c368a057e598	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
39610acb-a894-4f24-811f-08d0590f7f79	t	f	realm-management	0	f	bmMSOQNYUQVop1k2xTo9GVqIfpXedilj	\N	f	\N	f	8eee160c-5edd-481a-b964-c368a057e598	openid-connect	0	f	f	${client_realm-management}	t	client-secret	\N	\N	\N	t	f	f	f
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	t	f	security-admin-console	0	t	\N	/admin/BakerTech/console/	f	\N	f	8eee160c-5edd-481a-b964-c368a057e598	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_attributes (client_id, value, name) FROM stdin;
530aa4ab-ff70-4256-8abb-0a905d775a99	+	post.logout.redirect.uris
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	+	post.logout.redirect.uris
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	S256	pkce.code.challenge.method
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	+	post.logout.redirect.uris
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	S256	pkce.code.challenge.method
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	+	post.logout.redirect.uris
74b39df6-1c8b-4e84-8251-5771ca6a6470	+	post.logout.redirect.uris
74b39df6-1c8b-4e84-8251-5771ca6a6470	S256	pkce.code.challenge.method
9c411dbd-4e42-431f-9093-f8c77db6966f	+	post.logout.redirect.uris
92f5bea7-369a-483d-a9ea-a330f05968b5	1694025627	client.secret.creation.time
92f5bea7-369a-483d-a9ea-a330f05968b5	+	post.logout.redirect.uris
92f5bea7-369a-483d-a9ea-a330f05968b5	false	oauth2.device.authorization.grant.enabled
92f5bea7-369a-483d-a9ea-a330f05968b5	false	use.jwks.url
92f5bea7-369a-483d-a9ea-a330f05968b5	false	backchannel.logout.revoke.offline.tokens
92f5bea7-369a-483d-a9ea-a330f05968b5	true	use.refresh.tokens
92f5bea7-369a-483d-a9ea-a330f05968b5	false	tls-client-certificate-bound-access-tokens
92f5bea7-369a-483d-a9ea-a330f05968b5	false	oidc.ciba.grant.enabled
92f5bea7-369a-483d-a9ea-a330f05968b5	true	backchannel.logout.session.required
92f5bea7-369a-483d-a9ea-a330f05968b5	false	client_credentials.use_refresh_token
92f5bea7-369a-483d-a9ea-a330f05968b5	{}	acr.loa.map
92f5bea7-369a-483d-a9ea-a330f05968b5	false	require.pushed.authorization.requests
92f5bea7-369a-483d-a9ea-a330f05968b5	false	display.on.consent.screen
92f5bea7-369a-483d-a9ea-a330f05968b5	false	token.response.type.bearer.lower-case
80710076-562f-4877-bf9c-7a005d70367b	+	post.logout.redirect.uris
39610acb-a894-4f24-811f-08d0590f7f79	1695580874	client.secret.creation.time
39610acb-a894-4f24-811f-08d0590f7f79	+	post.logout.redirect.uris
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	+	post.logout.redirect.uris
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	S256	pkce.code.challenge.method
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_scope (id, name, realm_id, description, protocol) FROM stdin;
07ab3675-42f8-4b10-b192-8ccd1b2d585c	offline_access	a7ba7779-875b-4788-99a3-328f298d05b3	OpenID Connect built-in scope: offline_access	openid-connect
fcb250d4-b039-468b-9052-c54a64fb504c	role_list	a7ba7779-875b-4788-99a3-328f298d05b3	SAML role list	saml
6977acb4-8b54-432e-b849-816f8c20c04c	profile	a7ba7779-875b-4788-99a3-328f298d05b3	OpenID Connect built-in scope: profile	openid-connect
43820c2a-045e-4909-a8f2-f65ed2433a7d	email	a7ba7779-875b-4788-99a3-328f298d05b3	OpenID Connect built-in scope: email	openid-connect
afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	address	a7ba7779-875b-4788-99a3-328f298d05b3	OpenID Connect built-in scope: address	openid-connect
5fdd6127-2f29-4a63-a405-0fea438c255a	phone	a7ba7779-875b-4788-99a3-328f298d05b3	OpenID Connect built-in scope: phone	openid-connect
e923f6a9-0cd2-4899-a184-d866bf9756a9	roles	a7ba7779-875b-4788-99a3-328f298d05b3	OpenID Connect scope for add user roles to the access token	openid-connect
97183b7b-2c55-4fbd-99b3-4837cfbc0b00	web-origins	a7ba7779-875b-4788-99a3-328f298d05b3	OpenID Connect scope for add allowed web origins to the access token	openid-connect
fa167aac-9554-424f-8b30-4c0297b499d2	microprofile-jwt	a7ba7779-875b-4788-99a3-328f298d05b3	Microprofile - JWT built-in scope	openid-connect
815a3e74-387c-4f80-b408-01309615b469	acr	a7ba7779-875b-4788-99a3-328f298d05b3	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
f8859454-c1a8-4f25-815d-8c2f38e11968	roles	8eee160c-5edd-481a-b964-c368a057e598	OpenID Connect scope for add user roles to the access token	openid-connect
33583b6c-e729-4916-9bf6-2a3e3b79100f	role_list	8eee160c-5edd-481a-b964-c368a057e598	SAML role list	saml
811127fe-927b-4211-b57f-b0ded9b327ef	web-origins	8eee160c-5edd-481a-b964-c368a057e598	OpenID Connect scope for add allowed web origins to the access token	openid-connect
2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	microprofile-jwt	8eee160c-5edd-481a-b964-c368a057e598	Microprofile - JWT built-in scope	openid-connect
ff02e659-87de-4b64-9207-c64548a8d463	profile	8eee160c-5edd-481a-b964-c368a057e598	OpenID Connect built-in scope: profile	openid-connect
b0fe611c-3950-44df-832b-14e0814a70aa	acr	8eee160c-5edd-481a-b964-c368a057e598	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	address	8eee160c-5edd-481a-b964-c368a057e598	OpenID Connect built-in scope: address	openid-connect
0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	offline_access	8eee160c-5edd-481a-b964-c368a057e598	OpenID Connect built-in scope: offline_access	openid-connect
d4320bae-9ace-4165-b177-a00033b8fbdb	phone	8eee160c-5edd-481a-b964-c368a057e598	OpenID Connect built-in scope: phone	openid-connect
03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	email	8eee160c-5edd-481a-b964-c368a057e598	OpenID Connect built-in scope: email	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_scope_attributes (scope_id, value, name) FROM stdin;
07ab3675-42f8-4b10-b192-8ccd1b2d585c	true	display.on.consent.screen
07ab3675-42f8-4b10-b192-8ccd1b2d585c	${offlineAccessScopeConsentText}	consent.screen.text
fcb250d4-b039-468b-9052-c54a64fb504c	true	display.on.consent.screen
fcb250d4-b039-468b-9052-c54a64fb504c	${samlRoleListScopeConsentText}	consent.screen.text
6977acb4-8b54-432e-b849-816f8c20c04c	true	display.on.consent.screen
6977acb4-8b54-432e-b849-816f8c20c04c	${profileScopeConsentText}	consent.screen.text
6977acb4-8b54-432e-b849-816f8c20c04c	true	include.in.token.scope
43820c2a-045e-4909-a8f2-f65ed2433a7d	true	display.on.consent.screen
43820c2a-045e-4909-a8f2-f65ed2433a7d	${emailScopeConsentText}	consent.screen.text
43820c2a-045e-4909-a8f2-f65ed2433a7d	true	include.in.token.scope
afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	true	display.on.consent.screen
afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	${addressScopeConsentText}	consent.screen.text
afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	true	include.in.token.scope
5fdd6127-2f29-4a63-a405-0fea438c255a	true	display.on.consent.screen
5fdd6127-2f29-4a63-a405-0fea438c255a	${phoneScopeConsentText}	consent.screen.text
5fdd6127-2f29-4a63-a405-0fea438c255a	true	include.in.token.scope
e923f6a9-0cd2-4899-a184-d866bf9756a9	true	display.on.consent.screen
e923f6a9-0cd2-4899-a184-d866bf9756a9	${rolesScopeConsentText}	consent.screen.text
e923f6a9-0cd2-4899-a184-d866bf9756a9	false	include.in.token.scope
97183b7b-2c55-4fbd-99b3-4837cfbc0b00	false	display.on.consent.screen
97183b7b-2c55-4fbd-99b3-4837cfbc0b00		consent.screen.text
97183b7b-2c55-4fbd-99b3-4837cfbc0b00	false	include.in.token.scope
fa167aac-9554-424f-8b30-4c0297b499d2	false	display.on.consent.screen
fa167aac-9554-424f-8b30-4c0297b499d2	true	include.in.token.scope
815a3e74-387c-4f80-b408-01309615b469	false	display.on.consent.screen
815a3e74-387c-4f80-b408-01309615b469	false	include.in.token.scope
f8859454-c1a8-4f25-815d-8c2f38e11968	false	include.in.token.scope
f8859454-c1a8-4f25-815d-8c2f38e11968	true	display.on.consent.screen
f8859454-c1a8-4f25-815d-8c2f38e11968	${rolesScopeConsentText}	consent.screen.text
33583b6c-e729-4916-9bf6-2a3e3b79100f	${samlRoleListScopeConsentText}	consent.screen.text
33583b6c-e729-4916-9bf6-2a3e3b79100f	true	display.on.consent.screen
811127fe-927b-4211-b57f-b0ded9b327ef	false	include.in.token.scope
811127fe-927b-4211-b57f-b0ded9b327ef	false	display.on.consent.screen
811127fe-927b-4211-b57f-b0ded9b327ef		consent.screen.text
2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	true	include.in.token.scope
2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	false	display.on.consent.screen
ff02e659-87de-4b64-9207-c64548a8d463	true	include.in.token.scope
ff02e659-87de-4b64-9207-c64548a8d463	true	display.on.consent.screen
ff02e659-87de-4b64-9207-c64548a8d463	${profileScopeConsentText}	consent.screen.text
b0fe611c-3950-44df-832b-14e0814a70aa	false	include.in.token.scope
b0fe611c-3950-44df-832b-14e0814a70aa	false	display.on.consent.screen
7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	true	include.in.token.scope
7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	true	display.on.consent.screen
7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	${addressScopeConsentText}	consent.screen.text
0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	${offlineAccessScopeConsentText}	consent.screen.text
0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	true	display.on.consent.screen
d4320bae-9ace-4165-b177-a00033b8fbdb	true	include.in.token.scope
d4320bae-9ace-4165-b177-a00033b8fbdb	true	display.on.consent.screen
d4320bae-9ace-4165-b177-a00033b8fbdb	${phoneScopeConsentText}	consent.screen.text
03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	true	include.in.token.scope
03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	true	display.on.consent.screen
03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	${emailScopeConsentText}	consent.screen.text
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
530aa4ab-ff70-4256-8abb-0a905d775a99	e923f6a9-0cd2-4899-a184-d866bf9756a9	t
530aa4ab-ff70-4256-8abb-0a905d775a99	6977acb4-8b54-432e-b849-816f8c20c04c	t
530aa4ab-ff70-4256-8abb-0a905d775a99	815a3e74-387c-4f80-b408-01309615b469	t
530aa4ab-ff70-4256-8abb-0a905d775a99	97183b7b-2c55-4fbd-99b3-4837cfbc0b00	t
530aa4ab-ff70-4256-8abb-0a905d775a99	43820c2a-045e-4909-a8f2-f65ed2433a7d	t
530aa4ab-ff70-4256-8abb-0a905d775a99	5fdd6127-2f29-4a63-a405-0fea438c255a	f
530aa4ab-ff70-4256-8abb-0a905d775a99	afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	f
530aa4ab-ff70-4256-8abb-0a905d775a99	07ab3675-42f8-4b10-b192-8ccd1b2d585c	f
530aa4ab-ff70-4256-8abb-0a905d775a99	fa167aac-9554-424f-8b30-4c0297b499d2	f
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	e923f6a9-0cd2-4899-a184-d866bf9756a9	t
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	6977acb4-8b54-432e-b849-816f8c20c04c	t
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	815a3e74-387c-4f80-b408-01309615b469	t
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	97183b7b-2c55-4fbd-99b3-4837cfbc0b00	t
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	43820c2a-045e-4909-a8f2-f65ed2433a7d	t
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	5fdd6127-2f29-4a63-a405-0fea438c255a	f
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	f
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	07ab3675-42f8-4b10-b192-8ccd1b2d585c	f
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	fa167aac-9554-424f-8b30-4c0297b499d2	f
adc7cfaa-ca92-4e9a-adb1-6eb90c9bba02	e923f6a9-0cd2-4899-a184-d866bf9756a9	t
adc7cfaa-ca92-4e9a-adb1-6eb90c9bba02	6977acb4-8b54-432e-b849-816f8c20c04c	t
adc7cfaa-ca92-4e9a-adb1-6eb90c9bba02	815a3e74-387c-4f80-b408-01309615b469	t
adc7cfaa-ca92-4e9a-adb1-6eb90c9bba02	97183b7b-2c55-4fbd-99b3-4837cfbc0b00	t
adc7cfaa-ca92-4e9a-adb1-6eb90c9bba02	43820c2a-045e-4909-a8f2-f65ed2433a7d	t
adc7cfaa-ca92-4e9a-adb1-6eb90c9bba02	5fdd6127-2f29-4a63-a405-0fea438c255a	f
adc7cfaa-ca92-4e9a-adb1-6eb90c9bba02	afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	f
adc7cfaa-ca92-4e9a-adb1-6eb90c9bba02	07ab3675-42f8-4b10-b192-8ccd1b2d585c	f
adc7cfaa-ca92-4e9a-adb1-6eb90c9bba02	fa167aac-9554-424f-8b30-4c0297b499d2	f
82ccf254-bfc4-462b-97e1-50f2595b7f06	e923f6a9-0cd2-4899-a184-d866bf9756a9	t
82ccf254-bfc4-462b-97e1-50f2595b7f06	6977acb4-8b54-432e-b849-816f8c20c04c	t
82ccf254-bfc4-462b-97e1-50f2595b7f06	815a3e74-387c-4f80-b408-01309615b469	t
82ccf254-bfc4-462b-97e1-50f2595b7f06	97183b7b-2c55-4fbd-99b3-4837cfbc0b00	t
82ccf254-bfc4-462b-97e1-50f2595b7f06	43820c2a-045e-4909-a8f2-f65ed2433a7d	t
82ccf254-bfc4-462b-97e1-50f2595b7f06	5fdd6127-2f29-4a63-a405-0fea438c255a	f
82ccf254-bfc4-462b-97e1-50f2595b7f06	afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	f
82ccf254-bfc4-462b-97e1-50f2595b7f06	07ab3675-42f8-4b10-b192-8ccd1b2d585c	f
82ccf254-bfc4-462b-97e1-50f2595b7f06	fa167aac-9554-424f-8b30-4c0297b499d2	f
3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	e923f6a9-0cd2-4899-a184-d866bf9756a9	t
3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	6977acb4-8b54-432e-b849-816f8c20c04c	t
3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	815a3e74-387c-4f80-b408-01309615b469	t
3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	97183b7b-2c55-4fbd-99b3-4837cfbc0b00	t
3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	43820c2a-045e-4909-a8f2-f65ed2433a7d	t
3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	5fdd6127-2f29-4a63-a405-0fea438c255a	f
3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	f
3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	07ab3675-42f8-4b10-b192-8ccd1b2d585c	f
3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	fa167aac-9554-424f-8b30-4c0297b499d2	f
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	e923f6a9-0cd2-4899-a184-d866bf9756a9	t
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	6977acb4-8b54-432e-b849-816f8c20c04c	t
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	815a3e74-387c-4f80-b408-01309615b469	t
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	97183b7b-2c55-4fbd-99b3-4837cfbc0b00	t
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	43820c2a-045e-4909-a8f2-f65ed2433a7d	t
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	5fdd6127-2f29-4a63-a405-0fea438c255a	f
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	f
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	07ab3675-42f8-4b10-b192-8ccd1b2d585c	f
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	fa167aac-9554-424f-8b30-4c0297b499d2	f
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	811127fe-927b-4211-b57f-b0ded9b327ef	t
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	b0fe611c-3950-44df-832b-14e0814a70aa	t
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	f8859454-c1a8-4f25-815d-8c2f38e11968	t
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	ff02e659-87de-4b64-9207-c64548a8d463	t
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	t
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	f
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	d4320bae-9ace-4165-b177-a00033b8fbdb	f
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	f
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	f
74b39df6-1c8b-4e84-8251-5771ca6a6470	811127fe-927b-4211-b57f-b0ded9b327ef	t
74b39df6-1c8b-4e84-8251-5771ca6a6470	b0fe611c-3950-44df-832b-14e0814a70aa	t
74b39df6-1c8b-4e84-8251-5771ca6a6470	f8859454-c1a8-4f25-815d-8c2f38e11968	t
74b39df6-1c8b-4e84-8251-5771ca6a6470	ff02e659-87de-4b64-9207-c64548a8d463	t
74b39df6-1c8b-4e84-8251-5771ca6a6470	03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	t
74b39df6-1c8b-4e84-8251-5771ca6a6470	7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	f
74b39df6-1c8b-4e84-8251-5771ca6a6470	d4320bae-9ace-4165-b177-a00033b8fbdb	f
74b39df6-1c8b-4e84-8251-5771ca6a6470	0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	f
74b39df6-1c8b-4e84-8251-5771ca6a6470	2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	f
9c411dbd-4e42-431f-9093-f8c77db6966f	811127fe-927b-4211-b57f-b0ded9b327ef	t
9c411dbd-4e42-431f-9093-f8c77db6966f	b0fe611c-3950-44df-832b-14e0814a70aa	t
9c411dbd-4e42-431f-9093-f8c77db6966f	f8859454-c1a8-4f25-815d-8c2f38e11968	t
9c411dbd-4e42-431f-9093-f8c77db6966f	ff02e659-87de-4b64-9207-c64548a8d463	t
9c411dbd-4e42-431f-9093-f8c77db6966f	03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	t
9c411dbd-4e42-431f-9093-f8c77db6966f	7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	f
9c411dbd-4e42-431f-9093-f8c77db6966f	d4320bae-9ace-4165-b177-a00033b8fbdb	f
9c411dbd-4e42-431f-9093-f8c77db6966f	0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	f
9c411dbd-4e42-431f-9093-f8c77db6966f	2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	f
92f5bea7-369a-483d-a9ea-a330f05968b5	811127fe-927b-4211-b57f-b0ded9b327ef	t
92f5bea7-369a-483d-a9ea-a330f05968b5	b0fe611c-3950-44df-832b-14e0814a70aa	t
92f5bea7-369a-483d-a9ea-a330f05968b5	f8859454-c1a8-4f25-815d-8c2f38e11968	t
92f5bea7-369a-483d-a9ea-a330f05968b5	ff02e659-87de-4b64-9207-c64548a8d463	t
92f5bea7-369a-483d-a9ea-a330f05968b5	7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	f
92f5bea7-369a-483d-a9ea-a330f05968b5	0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	f
92f5bea7-369a-483d-a9ea-a330f05968b5	2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	f
80710076-562f-4877-bf9c-7a005d70367b	811127fe-927b-4211-b57f-b0ded9b327ef	t
80710076-562f-4877-bf9c-7a005d70367b	b0fe611c-3950-44df-832b-14e0814a70aa	t
80710076-562f-4877-bf9c-7a005d70367b	f8859454-c1a8-4f25-815d-8c2f38e11968	t
80710076-562f-4877-bf9c-7a005d70367b	ff02e659-87de-4b64-9207-c64548a8d463	t
80710076-562f-4877-bf9c-7a005d70367b	03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	t
80710076-562f-4877-bf9c-7a005d70367b	7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	f
80710076-562f-4877-bf9c-7a005d70367b	d4320bae-9ace-4165-b177-a00033b8fbdb	f
80710076-562f-4877-bf9c-7a005d70367b	0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	f
80710076-562f-4877-bf9c-7a005d70367b	2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	f
39610acb-a894-4f24-811f-08d0590f7f79	811127fe-927b-4211-b57f-b0ded9b327ef	t
39610acb-a894-4f24-811f-08d0590f7f79	b0fe611c-3950-44df-832b-14e0814a70aa	t
39610acb-a894-4f24-811f-08d0590f7f79	f8859454-c1a8-4f25-815d-8c2f38e11968	t
39610acb-a894-4f24-811f-08d0590f7f79	ff02e659-87de-4b64-9207-c64548a8d463	t
39610acb-a894-4f24-811f-08d0590f7f79	03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	t
39610acb-a894-4f24-811f-08d0590f7f79	7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	f
39610acb-a894-4f24-811f-08d0590f7f79	d4320bae-9ace-4165-b177-a00033b8fbdb	f
39610acb-a894-4f24-811f-08d0590f7f79	0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	f
39610acb-a894-4f24-811f-08d0590f7f79	2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	f
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	811127fe-927b-4211-b57f-b0ded9b327ef	t
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	b0fe611c-3950-44df-832b-14e0814a70aa	t
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	f8859454-c1a8-4f25-815d-8c2f38e11968	t
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	ff02e659-87de-4b64-9207-c64548a8d463	t
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	t
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	f
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	d4320bae-9ace-4165-b177-a00033b8fbdb	f
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	f
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	f
92f5bea7-369a-483d-a9ea-a330f05968b5	03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3	f
92f5bea7-369a-483d-a9ea-a330f05968b5	d4320bae-9ace-4165-b177-a00033b8fbdb	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_scope_role_mapping (scope_id, role_id) FROM stdin;
07ab3675-42f8-4b10-b192-8ccd1b2d585c	de5a54e6-b775-4742-afa3-0572fbcfe48d
0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	e873c552-e603-456e-abbf-121bc85963df
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
ab9fda5f-46a5-429a-9dc2-046a301265eb	Trusted Hosts	a7ba7779-875b-4788-99a3-328f298d05b3	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7ba7779-875b-4788-99a3-328f298d05b3	anonymous
6a2e607a-eeea-4b13-9dc4-6e28ebb6cb34	Consent Required	a7ba7779-875b-4788-99a3-328f298d05b3	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7ba7779-875b-4788-99a3-328f298d05b3	anonymous
a30ba79e-27d3-4ca7-a6a7-72092d9834d0	Full Scope Disabled	a7ba7779-875b-4788-99a3-328f298d05b3	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7ba7779-875b-4788-99a3-328f298d05b3	anonymous
ed01e19f-4333-4730-a11e-604084a6bff4	Max Clients Limit	a7ba7779-875b-4788-99a3-328f298d05b3	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7ba7779-875b-4788-99a3-328f298d05b3	anonymous
18679e9a-bf57-4262-940b-80060b0dd0a6	Allowed Protocol Mapper Types	a7ba7779-875b-4788-99a3-328f298d05b3	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7ba7779-875b-4788-99a3-328f298d05b3	anonymous
e1fcf90b-93f0-4100-8b04-abbe1cf6e517	Allowed Client Scopes	a7ba7779-875b-4788-99a3-328f298d05b3	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7ba7779-875b-4788-99a3-328f298d05b3	anonymous
26b6f7fd-046a-41a4-a8b2-ff2bdff972b0	Allowed Protocol Mapper Types	a7ba7779-875b-4788-99a3-328f298d05b3	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7ba7779-875b-4788-99a3-328f298d05b3	authenticated
0fe50638-3ae4-49c3-8806-e7cccfc22d6d	Allowed Client Scopes	a7ba7779-875b-4788-99a3-328f298d05b3	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	a7ba7779-875b-4788-99a3-328f298d05b3	authenticated
59903dbb-1555-44af-96e7-a615979dcdfb	rsa-generated	a7ba7779-875b-4788-99a3-328f298d05b3	rsa-generated	org.keycloak.keys.KeyProvider	a7ba7779-875b-4788-99a3-328f298d05b3	\N
7d3a3577-3fa4-4d7f-bc1d-f068bf54a7db	rsa-enc-generated	a7ba7779-875b-4788-99a3-328f298d05b3	rsa-enc-generated	org.keycloak.keys.KeyProvider	a7ba7779-875b-4788-99a3-328f298d05b3	\N
27ec18ee-0aa2-49ba-aedc-d40acb436850	hmac-generated	a7ba7779-875b-4788-99a3-328f298d05b3	hmac-generated	org.keycloak.keys.KeyProvider	a7ba7779-875b-4788-99a3-328f298d05b3	\N
34dff816-9350-49af-a74e-a4ca88f1c193	aes-generated	a7ba7779-875b-4788-99a3-328f298d05b3	aes-generated	org.keycloak.keys.KeyProvider	a7ba7779-875b-4788-99a3-328f298d05b3	\N
2fd66a4a-e362-4ceb-917c-46d00ee2a48b	Allowed Protocol Mapper Types	8eee160c-5edd-481a-b964-c368a057e598	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8eee160c-5edd-481a-b964-c368a057e598	anonymous
db9cc60b-3b35-43fb-9885-295ba1569a4f	Allowed Protocol Mapper Types	8eee160c-5edd-481a-b964-c368a057e598	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8eee160c-5edd-481a-b964-c368a057e598	authenticated
39f459e5-64a3-41bc-aa87-b1f81ed16008	Trusted Hosts	8eee160c-5edd-481a-b964-c368a057e598	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8eee160c-5edd-481a-b964-c368a057e598	anonymous
8e4d7c26-f257-455f-98d0-d61c5cae63d1	Allowed Client Scopes	8eee160c-5edd-481a-b964-c368a057e598	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8eee160c-5edd-481a-b964-c368a057e598	authenticated
b30f4500-a433-4eb3-87a1-48f8f582f896	Max Clients Limit	8eee160c-5edd-481a-b964-c368a057e598	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8eee160c-5edd-481a-b964-c368a057e598	anonymous
0dc1f5b0-e2f9-4596-8b2d-f6141a619239	Consent Required	8eee160c-5edd-481a-b964-c368a057e598	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8eee160c-5edd-481a-b964-c368a057e598	anonymous
741ed740-e1c2-46bc-9f8e-6e6dc6817dd0	Full Scope Disabled	8eee160c-5edd-481a-b964-c368a057e598	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8eee160c-5edd-481a-b964-c368a057e598	anonymous
48a49652-05f7-420c-93a0-c60452f1d006	Allowed Client Scopes	8eee160c-5edd-481a-b964-c368a057e598	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8eee160c-5edd-481a-b964-c368a057e598	anonymous
0b19ca7e-e573-421a-b588-370966a024a5	aes-generated	8eee160c-5edd-481a-b964-c368a057e598	aes-generated	org.keycloak.keys.KeyProvider	8eee160c-5edd-481a-b964-c368a057e598	\N
28f7555a-f8e8-4e21-8e43-5916ed429afc	hmac-generated	8eee160c-5edd-481a-b964-c368a057e598	hmac-generated	org.keycloak.keys.KeyProvider	8eee160c-5edd-481a-b964-c368a057e598	\N
e19679f4-bdea-4911-bf47-10fd78276042	rsa-generated	8eee160c-5edd-481a-b964-c368a057e598	rsa-generated	org.keycloak.keys.KeyProvider	8eee160c-5edd-481a-b964-c368a057e598	\N
55a4e627-b217-4d4b-ba34-53543be4b53c	rsa-enc-generated	8eee160c-5edd-481a-b964-c368a057e598	rsa-enc-generated	org.keycloak.keys.KeyProvider	8eee160c-5edd-481a-b964-c368a057e598	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.component_config (id, component_id, name, value) FROM stdin;
d4a60805-4be4-4bce-8fdb-02489a6a20ea	26b6f7fd-046a-41a4-a8b2-ff2bdff972b0	allowed-protocol-mapper-types	saml-role-list-mapper
2efb84a6-93f6-435d-ac62-9e09f5a9779a	26b6f7fd-046a-41a4-a8b2-ff2bdff972b0	allowed-protocol-mapper-types	oidc-address-mapper
b981a2c4-64d1-4664-b843-f4de037641b0	26b6f7fd-046a-41a4-a8b2-ff2bdff972b0	allowed-protocol-mapper-types	saml-user-attribute-mapper
e864e273-f872-43f9-b4b6-075b0dd5d652	26b6f7fd-046a-41a4-a8b2-ff2bdff972b0	allowed-protocol-mapper-types	saml-user-property-mapper
7c9ce9b5-7745-4c82-8ca2-267982687b12	26b6f7fd-046a-41a4-a8b2-ff2bdff972b0	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
18cf4ed4-504d-4f40-80b4-2575aee2906b	26b6f7fd-046a-41a4-a8b2-ff2bdff972b0	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
35211df5-78f6-49fb-a6ee-074dca7805b2	26b6f7fd-046a-41a4-a8b2-ff2bdff972b0	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
4f82fb0c-3293-45e7-a254-fa1c43a63071	26b6f7fd-046a-41a4-a8b2-ff2bdff972b0	allowed-protocol-mapper-types	oidc-full-name-mapper
eecdd5f7-8ab9-4092-913f-d4923864285f	ed01e19f-4333-4730-a11e-604084a6bff4	max-clients	200
dda9b8f9-f157-4b05-9146-df4f985cab94	18679e9a-bf57-4262-940b-80060b0dd0a6	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
17dcfff8-b0ab-4565-a344-e211646071af	18679e9a-bf57-4262-940b-80060b0dd0a6	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
b4befcfd-7173-4399-8d85-bdc533418298	18679e9a-bf57-4262-940b-80060b0dd0a6	allowed-protocol-mapper-types	saml-user-property-mapper
0504e94d-0574-4434-bc82-8ece3ac2fcb4	18679e9a-bf57-4262-940b-80060b0dd0a6	allowed-protocol-mapper-types	oidc-full-name-mapper
060b7de1-94a6-462f-91d1-8f3f0f361921	18679e9a-bf57-4262-940b-80060b0dd0a6	allowed-protocol-mapper-types	oidc-address-mapper
287950d1-b28f-4c74-aca4-117042cf1ca6	18679e9a-bf57-4262-940b-80060b0dd0a6	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
ac437d60-c1de-4f23-9d35-b69b04ad6bad	18679e9a-bf57-4262-940b-80060b0dd0a6	allowed-protocol-mapper-types	saml-role-list-mapper
86b1de1f-6f4b-4f4d-b024-49f087557fd4	18679e9a-bf57-4262-940b-80060b0dd0a6	allowed-protocol-mapper-types	saml-user-attribute-mapper
f60ffded-f120-4736-981e-cc81211845b4	0fe50638-3ae4-49c3-8806-e7cccfc22d6d	allow-default-scopes	true
7891d0ae-be64-400e-addb-b38b28e81682	ab9fda5f-46a5-429a-9dc2-046a301265eb	client-uris-must-match	true
fb8c35e8-edb0-413a-b791-c8e91766fb44	ab9fda5f-46a5-429a-9dc2-046a301265eb	host-sending-registration-request-must-match	true
ce16c3f4-978a-473c-b5e5-c645d38373bd	e1fcf90b-93f0-4100-8b04-abbe1cf6e517	allow-default-scopes	true
007c9c3e-6cfe-4c9b-a666-8df664c9ad46	34dff816-9350-49af-a74e-a4ca88f1c193	kid	fd6aa87c-2351-4dc3-9fb5-f31fd7d15caf
96f8bec6-a86f-4844-892d-0e549373fc97	34dff816-9350-49af-a74e-a4ca88f1c193	secret	mQp3WQGgaZaPbazebKNVQg
4686ebed-ce2f-461d-ae2f-26535ba9dc3c	34dff816-9350-49af-a74e-a4ca88f1c193	priority	100
de1f5950-cce5-4c79-b8da-4ae996eb311f	59903dbb-1555-44af-96e7-a615979dcdfb	keyUse	SIG
eef7fc2b-0327-4361-8516-c72c906cf240	59903dbb-1555-44af-96e7-a615979dcdfb	certificate	MIICmzCCAYMCBgGKyH7VqDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwOTI0MTgzOTMwWhcNMzMwOTI0MTg0MTEwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDEQ6WfLyLejOLlhqqQcLQlw3occUab/Slqfzw1aalHbWJUl4cwm+EajdotItEqN9hfgoTkwPlEK3J+IO1zv7PJkDblIjVM9aGRYZzfftlkh4HapoGDjIAwsIzwXO60tyfOX+/c4v08U8P7e59XDDbNQwmoRWRy0ulGJETTnGlkRGrfNu+fpbbyxaTu6dB6PSeW9DKsWc2crEeXI0Esc2VGKPPlVBK/6lFPheFfvrkvpqZ4n1YUUBAA5E2i13KZNkf6jqHS4NbKUF0J6OcUT7ZeHHkDWO2iiEadwqPZ5PTWL5EWPNdVwKzsQd0uaw+DqBeebQklf5cXGdXGpSqB0WEPAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFApnosoaz/YTS6VN2+zMjgx2qY7YPf2Dxw6pZxXcQm+5BViU9GXqElyptJxD/jsttfZLG/7w8xn4DUGaG80lfr1BeGv5JP44Wj5PnFYP3vpEtTPgCqFdUqLQYfv+JeG730PwIbyqaudgKa2pbnl4RpeHmvXviO2o1aHShKHttBevgtrAZbAMy2Q2X6Dsy7s0oKGbFmLfwQEbnh8rrfekZmP1CHisJ6ddX6KLiTHsdTwfLXNW8IvaSgVobIiCEQavvMrIJU7dxgQHD712DAn6A4dousZGY4EN4MsgZQBNuI5IHwakAkCVQSre3EZLuTeCxpGzqC8GOXxAoIXP/x+7Xs=
298675de-982a-4aec-8fd4-7f2b02c0bdd3	59903dbb-1555-44af-96e7-a615979dcdfb	priority	100
04910fb4-881a-4c32-8173-2f34ce02008e	59903dbb-1555-44af-96e7-a615979dcdfb	privateKey	MIIEpAIBAAKCAQEAxEOlny8i3ozi5YaqkHC0JcN6HHFGm/0pan88NWmpR21iVJeHMJvhGo3aLSLRKjfYX4KE5MD5RCtyfiDtc7+zyZA25SI1TPWhkWGc337ZZIeB2qaBg4yAMLCM8FzutLcnzl/v3OL9PFPD+3ufVww2zUMJqEVkctLpRiRE05xpZERq3zbvn6W28sWk7unQej0nlvQyrFnNnKxHlyNBLHNlRijz5VQSv+pRT4XhX765L6ameJ9WFFAQAORNotdymTZH+o6h0uDWylBdCejnFE+2Xhx5A1jtoohGncKj2eT01i+RFjzXVcCs7EHdLmsPg6gXnm0JJX+XFxnVxqUqgdFhDwIDAQABAoIBAFib5Agw+1C4Ee6ntJUe1S6hiR2TRNpDW7IBvNiumict6vGfMgGPtvtKpQCw0fd6HB3O6xnuR/vvk7L/QcV6/PxZOHeN0LuswGPHStCa0CJzjXx+pUWTpwKUiyUwB/OeJ4IkzUIQV12nwfll8GQYFxvoEtGedsHimEA7OrnBSdHiyU4PEn+6AI22kt/9faIXUtvWeOuiQHhAI3PI07ZqZJIoFF4OcQszXSqlSVt7AHDvnYgiXGciMMs8XG9CYOcZ1vaDHIdckkPgYrelmThVt+W1uP1G6BihymbP4Lh0NCPL8hs3ieT16tPw93TyP86pq+xjY17N6EvdPJqMV64fKb0CgYEA53TtJ5j2f887Hv4KnoLVeq+BGz5ogGOjNVCb00g4P92QpOf0y4xsXkWKfNc734ohFcIiujTlu2hR+KodyrXYGPvuXlvyETBQIAWQJgfITs0JX/YdNoCWg6hBiymlBo9lW4c0sD4M4Ip3zy8pTy368IBozcsPQj/KPbn24Z7/aG0CgYEA2RNkjw8GY/9lb4Or8sEOyPuY5O1AR9dacjSQpeO6cpWGBtJ38JfhzsUJ8x7RxA5XIVZyL+0LuKpvyYw3t/Ev+P6QmCnmDubfa6NXiiXvozxkWxaR1qxUdqFM7cn37qg+0UjrRXYN2+Vxwel9rWD+TtM8CPrHnuQpxrqfC+pleesCgYEAvdUJmRt8uLDHhZDINt+JpZkCI80Yuox91IFrfGtULxVSx92yyas/SkZw4hlJcvsATa8u+lfeP8m8yV0FGDfyp/MguuVgcTaV0N2fL4HciLzjvn/Fz+jBCfRa5X9faTT85YfL7+zEdPk8cIH2uIk2skAvNPIhbq2Q+vVmBgB47DUCgYAXy5hqVitNKuHjp3th0OfeADZyYc96EJFJk5mHlb8KcHmQpeGf7gZCtDay/93er/O9I8zAlCuEwqoeXdB9yWKI2N7gzzb4yzYShoVCD4aFTklx8rdp4NohZu0X49vZvXelWWjw5FAAmtYte3rbVpaJ7X3XPiZDtJ8fubVViQw2oQKBgQDDKyAfLzysjQXm9eAoXWHl4BmKoTxWTMZZ6+ZZqOUDo3gAGbo32XOAymGF/7V0K+M3DrviTv4dFavNYnkcl8+fpsPsBEL5zKuG9syQSTeHL7E7dAY+B1S0x7lxNFP9v+asXj5NbU5lZbN5IseMskmnoJe2iiKpeXmFVjpB7JJs6Q==
133064e5-ad86-415c-b2c3-7474eb641b71	7d3a3577-3fa4-4d7f-bc1d-f068bf54a7db	priority	100
65cef1d0-1de2-4766-a8a8-a778d95de4e8	7d3a3577-3fa4-4d7f-bc1d-f068bf54a7db	certificate	MIICmzCCAYMCBgGKyH7XtDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwOTI0MTgzOTMwWhcNMzMwOTI0MTg0MTEwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDB5f6OwzHqngbiCX7djXEttWhtBwT6e/ob11KPvWIPLOmf66TIAnuFE14g7nM9AzfcCLoA9QQtV3StuuWAtuAi6Ef/VsSXLfejYkA+O8c6ssQ5HaH2FfxKM4MDDH8d1EcIAJ7Q7Iemcycb/VHQC8MqzI27s9TanKKJpaleyPpomOvBKvIIu3nESjxZTR2iRfrKZoocEcXfFCDgyL80hmusFx6VjwRsx5Xe4UVjWtAFgiiUmBaGVFFJdOutlJqSbPiEy75VnGrmynxMa/rBTYwrP71DvvxCWBPljW/LX61Yy6+9ra6n6E2sev6feiRKxGCvJihIKWGZMVcGHYGe+G1RAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAKReuBItg5vA60EC1UKnwBxM3VZdVI7wvuAJZXtegcB2qUHAUaHof52sufpusVeBjw+1dpA3pV604GZKcucY2o5TUQA9k1nKo6X+dwMs7HO9ANDeF7un9u8JAwoGDEivyl5zAycsqrmeOMBaUzPWBrlUaQTzVLcf9sSsmWTz4MGB8odCboXRrfLFSzpaNNFhAmwWOs6RoDqaHt+PuNX8AnKvXOZxvbD6yLCtpgh9oO+dJVkqIepJGKcW4VrZSHX1Y8qwl6V3tuyEf4HyCQ7TnKcPyjETLxLrbeWRcnyHcdP7MlV0jNTnFgljrke0q8BiGDBOhbnxGdfHrTXpNa+JWkU=
b3641496-76e3-4eb4-81de-072e9541bb83	7d3a3577-3fa4-4d7f-bc1d-f068bf54a7db	privateKey	MIIEowIBAAKCAQEAweX+jsMx6p4G4gl+3Y1xLbVobQcE+nv6G9dSj71iDyzpn+ukyAJ7hRNeIO5zPQM33Ai6APUELVd0rbrlgLbgIuhH/1bEly33o2JAPjvHOrLEOR2h9hX8SjODAwx/HdRHCACe0OyHpnMnG/1R0AvDKsyNu7PU2pyiiaWpXsj6aJjrwSryCLt5xEo8WU0dokX6ymaKHBHF3xQg4Mi/NIZrrBcelY8EbMeV3uFFY1rQBYIolJgWhlRRSXTrrZSakmz4hMu+VZxq5sp8TGv6wU2MKz+9Q778QlgT5Y1vy1+tWMuvva2up+hNrHr+n3okSsRgryYoSClhmTFXBh2BnvhtUQIDAQABAoIBACD+MS/6n9JDvHkW04sAZ8s2zIOMx7iVguvc2jQSLg7V/hTTpHDSF1GAB6rD2ED//K/InlnOVz0d3gE3xZh+xam665FTotT0oegfrj3IrzBaPdBYLfhxKkI3/Kl2pWSee82tSVjUfoqAmp2FH7guYDG2p8FSKrxeHbwdP7IcsZs9aey4eqRliADOiMBCRWisSQvdNLf3x+HthFk9zXpu7nE/EM6iShZBd09oI6irEgLGu5D4h1lEF6EaIAsaoPqfJoK5aKHlVhfxEyCTugPvyMSR2pudbexa5oLPrhg9esbtc2lSMPUcKTWeDsc4EB5zKRQJ7FrLwCEbLNnItZ88ro8CgYEA9K18VuyJ67Nq9STwzgkE8DiMNOyII6XaUrkSIoRyhldQsvKpJ32tMio9W3p6ndJ9E/KkY1MtiUncQp3c+xLa0K7ARTjFgJrP1DCQDy+Inm4N5IIJe0LB47q80j7Rl7WncRW/CQsN3MPJOnrtnOxrDTz/Sp5zZ97VpgEYRHNtR+cCgYEAyt727BSr27hcweCsBhHxlWhUhGFgVpmQtmOgX6QS0dkzJDbCQ4mKxZKEO27MjXpi3Jo8gscVuhgBOWJMrZOQJ8UmkKuqF8GAV7M0GBzj+/PXCblFiE2zTNXKegl+jdQUaI6TCEvHjUzBgVsV/CASp1AnM4EBp0tVUnCGTYciGgcCgYApO2MMsue7FI0dqo/56IMwiBb4hDOc7kIQVqe7sV4rTWOIBGSFByS8o2mblNQ87E+voOAa7NVroUrA3yFyHgdJy2kTQTHnLi9/rn9YT8ZSDHHC5Db80o8h9UIEnBlt22rQH74FpBs97LBobnbETwLrRDAxPuprwp12UBDq2Bi+WQKBgAsn/8Qzzs+ib9dpl4wt6G8i8aLmB/o7L64YBHW9/Br2Ks3PBRfZtHvw9ryd9znAhTdEdBdtA1DciRSyxyy0dLT7Loe+KPhtd7Va8X5x+EeevTCXs68vNrD/AMd9RixegVDOpl9Ka4rlsa5/Z9IZoWz6B23ZplGg3uxNq9UPnVx5AoGBAOBpZHD8XU/JPMpsRpQB2oFQvZk35uijzCEiO1ea8trWP8i67pTW5QV5DVw25MUjcEoQQ0Tf8M0jY/QmUNvdr3hv8yZaVzAnwtg9lW2My/LwDjp3ikH9tnrf6XGPmvav2Gp1RQ+4CM+EXEDTXtPN4fnDDfrHzeJYzU7yJJaifip6
445fe9b9-ab26-47ef-b2fa-65a62b3f8a97	7d3a3577-3fa4-4d7f-bc1d-f068bf54a7db	keyUse	ENC
04e92a43-5cb1-4b65-b911-00087968e76e	7d3a3577-3fa4-4d7f-bc1d-f068bf54a7db	algorithm	RSA-OAEP
e13b9134-ee22-4627-b0e2-5cb23dde3dc5	27ec18ee-0aa2-49ba-aedc-d40acb436850	kid	868ffdb3-dfe0-46a4-8cd7-46f76a6e6b4b
12d0cd9f-eb29-4c79-84e8-df2f5834768c	27ec18ee-0aa2-49ba-aedc-d40acb436850	priority	100
7508f61e-f673-40ab-be2c-ae20920938eb	27ec18ee-0aa2-49ba-aedc-d40acb436850	algorithm	HS256
b36b13db-5ed0-4165-89e1-1c02def3f8f7	27ec18ee-0aa2-49ba-aedc-d40acb436850	secret	Qr75g1-EUGB0JANUNtwwawQtS2Io0E3-Th14wbx_AQL-zD1KnUqkcymT7NnPH-28FOShoWObwLIAtqgtwcFVYw
38c82620-38d5-49ac-beac-b6e0c341273d	2fd66a4a-e362-4ceb-917c-46d00ee2a48b	allowed-protocol-mapper-types	saml-user-property-mapper
fb11ef8e-e33e-4be3-8ac2-f6db5259dd05	2fd66a4a-e362-4ceb-917c-46d00ee2a48b	allowed-protocol-mapper-types	saml-role-list-mapper
ea496a56-658d-4ebb-95ec-edc24b94deca	2fd66a4a-e362-4ceb-917c-46d00ee2a48b	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
e778be78-d22d-40bf-8072-687f8072417c	2fd66a4a-e362-4ceb-917c-46d00ee2a48b	allowed-protocol-mapper-types	saml-user-attribute-mapper
16303877-7e56-4d50-8095-c86583fee94d	2fd66a4a-e362-4ceb-917c-46d00ee2a48b	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
da5a8200-19f0-4922-a057-d21391840e76	2fd66a4a-e362-4ceb-917c-46d00ee2a48b	allowed-protocol-mapper-types	oidc-address-mapper
5b0b1b59-c97c-49a4-8a18-cf93266381bd	2fd66a4a-e362-4ceb-917c-46d00ee2a48b	allowed-protocol-mapper-types	oidc-full-name-mapper
18cd456a-e3e3-48cc-bcd3-91dcd318ac31	2fd66a4a-e362-4ceb-917c-46d00ee2a48b	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
a518d9af-8432-4fdc-b201-8b7042337b5f	db9cc60b-3b35-43fb-9885-295ba1569a4f	allowed-protocol-mapper-types	saml-user-attribute-mapper
c195ec53-ec3f-4b92-b27d-e965a58ba769	db9cc60b-3b35-43fb-9885-295ba1569a4f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
9c0b0141-da01-4071-8eb5-fcf5dc6e17a1	db9cc60b-3b35-43fb-9885-295ba1569a4f	allowed-protocol-mapper-types	oidc-address-mapper
03ae4f81-6783-4d4a-a511-fa8cc5e03ad7	db9cc60b-3b35-43fb-9885-295ba1569a4f	allowed-protocol-mapper-types	oidc-full-name-mapper
44d6dc56-9e20-474d-a199-f6aed5d2ca4e	db9cc60b-3b35-43fb-9885-295ba1569a4f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
bb81ec44-b178-446d-9b62-685e92e3bffd	db9cc60b-3b35-43fb-9885-295ba1569a4f	allowed-protocol-mapper-types	saml-user-property-mapper
57077729-f396-4c67-baff-5cc07dd7bd17	db9cc60b-3b35-43fb-9885-295ba1569a4f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
23d28de2-ab2b-4680-8c06-7a452456bd1e	db9cc60b-3b35-43fb-9885-295ba1569a4f	allowed-protocol-mapper-types	saml-role-list-mapper
f106a378-4d51-4182-a501-1c6e8825e140	0b19ca7e-e573-421a-b588-370966a024a5	secret	zpFK4sLXf-XeJe5hx_N1DA
11a94e01-c4fa-465b-9e30-e0e1e24af323	0b19ca7e-e573-421a-b588-370966a024a5	kid	df80de53-a98f-42f2-ac3f-ff111b0555e1
cdda8768-991e-49e4-9c2c-43a33b51a991	0b19ca7e-e573-421a-b588-370966a024a5	priority	100
cfb726f5-f794-4dbb-8e16-6d729f3fca3b	28f7555a-f8e8-4e21-8e43-5916ed429afc	secret	-imKUS6QkmUWnO5C8bX_nljXsnF0YJSMgCQx8nZw5k7doUbcKElIOqjlKylPGm9CwxaEBGYlmfhTvTIqxxgdqg
93ebc3c5-778a-425d-b7ef-3d56ef249fe4	28f7555a-f8e8-4e21-8e43-5916ed429afc	algorithm	HS256
16042f1b-bb97-4c72-a004-00f0a54e81d8	28f7555a-f8e8-4e21-8e43-5916ed429afc	kid	a0d8415f-a008-4291-aa8a-4a6351e1d61e
0d6ee24b-9dd8-43d4-8d72-73704c219d18	28f7555a-f8e8-4e21-8e43-5916ed429afc	priority	100
454d2ff1-4e2d-46b8-a7ad-b337aed2ad25	39f459e5-64a3-41bc-aa87-b1f81ed16008	host-sending-registration-request-must-match	true
e304ab45-aef8-4d62-b7ed-ae85542f91b4	39f459e5-64a3-41bc-aa87-b1f81ed16008	client-uris-must-match	true
409f6569-655a-40d7-a8cb-e357be98cf03	8e4d7c26-f257-455f-98d0-d61c5cae63d1	allow-default-scopes	true
5915c63e-f059-43f2-bdad-ee138f5a0f36	e19679f4-bdea-4911-bf47-10fd78276042	priority	100
45ee13a4-052e-4634-acf8-6ee361ae45d0	e19679f4-bdea-4911-bf47-10fd78276042	certificate	MIICoTCCAYkCBgGKyH7pQjANBgkqhkiG9w0BAQsFADAUMRIwEAYDVQQDDAlCYWtlclRlY2gwHhcNMjMwOTI0MTgzOTM1WhcNMzMwOTI0MTg0MTE1WjAUMRIwEAYDVQQDDAlCYWtlclRlY2gwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCk0p8Ggy3HQ29dGXluJAK3ynW8xGaMFsQwmAlQIS44MRfaWXdONBbZiPoThhQF+RNQxNs62WOMyCtdsUsyGg0ckPKTc11QrFglu9pljQ95fld1XpPoJyxTdhxEgY9ZMV0OZDKJPh5819/HuxoxEa2zmcNbvphPBpWd3EJoUEQ87akMQi7YMNnYo8ZmWiTo8ycYm366rCfpowVeTQ5MEqnsuY+qwDIM82lbYyXptLRidp5VJiRfJDGfz2R0WA84+6qY3MTzM9if6mY87gVCGa8nJIvcyD1em4K9xR6EBepUPVNt9fX/LNdSNnDZp9q6AIWHzG/+F7tA04zG+8g1lNHjAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAPk2bdKbZy3t3vX+BYAYZJwuOnlEgPqcWqPxJ9kGPim4UANR6g9VGl6QJJjbTJhfu2JHZh++4dt4WUNu9cLViwYzH+tPwvcrwqOeKct8ovg9x0sN3BIw/5VR61CUBGTZjfx/HJuX0PuG7PityJ9ckkqhGdiClQRcPwgg0w5m688pBzktOY6yyL1/zrP9C7itQZTg5K6Fc0VrezWAD7YgRC+0uzW4AsIdCmssx6hqPPUQ/kW6rB08kUQ1Em0iX57TDY5CCFFjVlrdI8DmZmo499nVAb0xs5MZpFb4RZwzhiS0r4zZcBSnPLJCHt8ySp/vSuX0ozIgRG0pbL9oxbfIFg=
eadffed8-3018-490f-ae56-61b62fd5bb72	e19679f4-bdea-4911-bf47-10fd78276042	privateKey	MIIEowIBAAKCAQEApNKfBoMtx0NvXRl5biQCt8p1vMRmjBbEMJgJUCEuODEX2ll3TjQW2Yj6E4YUBfkTUMTbOtljjMgrXbFLMhoNHJDyk3NdUKxYJbvaZY0PeX5XdV6T6CcsU3YcRIGPWTFdDmQyiT4efNffx7saMRGts5nDW76YTwaVndxCaFBEPO2pDEIu2DDZ2KPGZlok6PMnGJt+uqwn6aMFXk0OTBKp7LmPqsAyDPNpW2Ml6bS0YnaeVSYkXyQxn89kdFgPOPuqmNzE8zPYn+pmPO4FQhmvJySL3Mg9XpuCvcUehAXqVD1TbfX1/yzXUjZw2afaugCFh8xv/he7QNOMxvvINZTR4wIDAQABAoIBAD5z4jblALUWu71CmEzgDzmV2OvoXVTqkXc6PJkkoW9ARuIA8WBsA1Z0/RDlxnOG78c0eD9BvONMu4XaVnxK+7ndwFSXq32UeCgAGJ5PB1SJR1ldN10JbtXHFKnuj6MDvddkpvNy2rmCULRNFH0QTkmV0zzRqMOU4p84pN8CvwB4jjch5Uw26MMYf2jZzIRkA10Rdp8dFe++r1LHCXNMwVFwS5IWVVsErxoA2844JdvLxq7YY0XZsSB6+TTJPLHreFkRvIUeL6Pp3ll2TNbBYDn6Z+oNxE2znJtgC9CSdXCZ41MUQ47i5pP+yiNgREBgYYNL5cF7wvk17ZGF654qslkCgYEA6BuVj3bL24wih9nlxX6ZCsQP9HHEwSW6gAphClk6UPB9W+rjPkF5lGaFkUjE9rYHDykUFC14vyA+Mi3/aUKqvlaV+GOQtnX/PjbpZ0n6wEKs3LdBNNWdJDI0eCKNX6gAIuhd0omuxP6kObcWQkPqLMyIhaBFeoZgR6kKmO7gdzkCgYEAtcn3vtkGI8xMb6G3AwyjF1MJXZbJbBDdP0SMIjEkBSZh9DCqes3PfRsXjOqq3X47+mFM+8jmJGZxZBc4DRujbcQk6tnDMni/LidsTCVDFQWlWWwDjYxZoI830JByTKcfUdyaGIegZWCdDdHZhUefeU5sTP1MG0P0JAvEcR06VfsCgYBoicvxopKsXlBLGXOoYJ1zQNzivr7cMy7tbj9Ilulx/O6pEICq0Hh+wzITPlAfwdoqFNlLQTOp+U6p8RehA/q84WiIR+esljaQgdDbyXEbWKxceFjw/+jXnZkOJpm/5H2zOy7OnV5OsVWr/O8Uh1wYM0Kl1IqWZaFFhTgVqzkD2QKBgQC1ORteSVHCnCbS3l7ojk+DsAbVIr23mnRFXxtn9p8W9zWNTnqVI9klub1XgJVHa1F1gExTcOpk/S8q/a6l+piIk5HOAbqC9TZ5V1mx6y+dpFw68d/02yZ6Vmvo4ibf3Xbuj8GalJJEnfTTUxDKuiTztEdo1NZrE+otiQGTVfTSwwKBgFT09ej1Hifh0Dgbo4qa8UguLrYkQZIMjAmfk/tjxcRRMyJbLW/+RmfHGwyV2eidRxXz4OANyXvBYSCFbZ5gIi/JaX0cq4vOvuk9JerzbseiXGiN/m++wzib2jaczEqCIUe1FcmqQPGtxf7nwyjMAPhKWf6ppbuAkqoO2XPuFWMb
b5ed7a72-a3ac-4da9-a610-9058352d832f	b30f4500-a433-4eb3-87a1-48f8f582f896	max-clients	200
b5dcbc9a-10b3-4963-b67f-6e4dbb653d83	48a49652-05f7-420c-93a0-c60452f1d006	allow-default-scopes	true
6117738d-40c7-45aa-90ee-b4ca1d247126	55a4e627-b217-4d4b-ba34-53543be4b53c	algorithm	RSA-OAEP
b4132e63-6150-4296-b169-4c31a2ec37f6	55a4e627-b217-4d4b-ba34-53543be4b53c	privateKey	MIIEoAIBAAKCAQEAlDFZnu7XDOkP/FEh7XGYUCkmnoXMYSQ6vRNBk4B3g+sxDr0u78l4X9NR2lHJN9qo8Z/7mM5sNrL84+xjsvB7yqmqMFi/wYAKVJGUstRV3iqi9tPIHQuldBFnWEu/JRQLP4AlUExfvfmITFAWc1CRlYw4BpbVrOQicVZN7bNRbQ0ACUhTJuFbSN1sZattk+450t4iKcCFEUfUehRyaz/dp46U2BwlqL59TZw47k1L9ll7octKZZpcttgxmVx/iD5l77mpWB2huFsWPIpz5H2O4QOCfFbM9NfNS3XkzfoeJY3TwlIoTT0Mm2eEfCKruaostOe6z4V2RlQC47NHLZicMQIDAQABAoH/bLseMVQMyuw1+RY4+SmKbUZu5ODxlFTWGY8yDjJe0+vnkr48MgkgyS5uYEFMjNlixpEbiS1BOOEbAXXwW4UXTxuC7kuFEUoLn6vb7q+HpqVMl3h224OFYiQNhOYO2VBbmxFAT3+6FSmBV9IV/DChS5jA2BTTsocGE80UYH5cFXuBEffs/laM+GU2cAHwwD4phpvhpg7JV+Qn4e38GOdd4IdxDN+p3Slx9L2IgOmRFZU/xxx0xOrTCMmh/Wj0hk1OXRDzL/jrbfcmHacdjsHRPOt/sbkDz0W2bdqwxVstmbRXxfbTpHkMW2guZmpsBAJmDm5LeS22tPFXItWAO0yZAoGBAMk5PImPOykFA7y6oMNrYrTeAKyj5VrPNjO2b6QmoR7l6WAowPeecq19b4Ka3um/+W+l+tnNRtrhRuTUu45gIoVQ43yN/IgcRT/rOzc0l6m68IA4IMI7Uy874uRB7Q7BJ+9204QY0h3IiZyWjloEBCMisnSVdTMGhWMTQ5uHeyHlAoGBALyIh9FeDCCUyje7jP0rs9f0ftz67BALFUN8bcnqXZoHheD8KHXzXVXmLsVwlK0tT+s8hAZzeRY686ful+5K94llUGjdxS9SpRAhbHOZIR/83RQOTSdNOsNELqpJNG1D2SKQlayw8V+5CFS9A6OT5YeM/SS9KpWiZ6kFH/sQA1xdAoGAX/of6NDbe+47YRp3MZ6XvwMguTeXXt/0z2eWCmqucQlibg4iNDlsI1nwBRCPgFijxeAaLSafRCktYlohd4BdFs+FIdSrfdRWJ22wmd1I9ZkHu3CKF3qqa54Z05uqUV5KCQrZSml4VuJe2MRq83505rlW+wqKkyLqHl6C4b0WOw0CgYAnwm9KIxhRoq9Gs6HXHmlOCLzcY3p3I683TT1mEKvuuNluCh+KSGmNnP6OGuDv6JdrF5cMOTv3CTWrW7DkyyCK9DfR9bsI8Nfon/PcKRYIRe5ltWJmAG59EZr5xHhu9pkLJgy6n5I3yrDMFhR3YdBNFtmn7tDVP6u2xGLrMoRS7QKBgEIXJ23PpmBJ5LWsdsWe95cpNkW9aSuM5mD3uuIMz0ma7HOjubK89Wh92KR7oFFt8zTZtKfWZ7o9EXHunBKgDzQYHXQoKA+zxSk8/XBIalfAYl5ps+rhfYi8+/Hrh282C93L0kHWXmCOoncXk2hBNJUAqxfSNQ+SE1tGOIYQbhTe
0438a6fe-1087-45da-9693-6459c6050710	55a4e627-b217-4d4b-ba34-53543be4b53c	certificate	MIICoTCCAYkCBgGKyH7qozANBgkqhkiG9w0BAQsFADAUMRIwEAYDVQQDDAlCYWtlclRlY2gwHhcNMjMwOTI0MTgzOTM1WhcNMzMwOTI0MTg0MTE1WjAUMRIwEAYDVQQDDAlCYWtlclRlY2gwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUMVme7tcM6Q/8USHtcZhQKSaehcxhJDq9E0GTgHeD6zEOvS7vyXhf01HaUck32qjxn/uYzmw2svzj7GOy8HvKqaowWL/BgApUkZSy1FXeKqL208gdC6V0EWdYS78lFAs/gCVQTF+9+YhMUBZzUJGVjDgGltWs5CJxVk3ts1FtDQAJSFMm4VtI3Wxlq22T7jnS3iIpwIURR9R6FHJrP92njpTYHCWovn1NnDjuTUv2WXuhy0plmly22DGZXH+IPmXvualYHaG4WxY8inPkfY7hA4J8Vsz0181LdeTN+h4ljdPCUihNPQybZ4R8Iqu5qiy057rPhXZGVALjs0ctmJwxAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAe/0SVvcc4WjvTl0BM67aYtPQ+8LcmUjAiLU7HMQ9HfmPW93bho6/1DylyO79EjzdBsGS7Wpam04uDdD7s9SaNGY4JaAYWWRh/vLeIDBrhiC1UgbGFqJ6zgFOTtkwr6FmhYldRTRNOxEFAmIw+0gAEWYre9tMa+0X4750Yp+lNfAW+b2UJra+HGAvxV8eQBqmmCzFHRQSz/1vm0gYC2BN2aq0RgefX0uDdlZppKRrV4omxy+1l41YzPIqbZ5MidK5zDhzpBd3TxlD2eXamh9m/aNSg8M7X/UHgmlefBo1MWtqJ1vJLK6sublzkMUlkrIlUaEOu4K6cJWYF/brxWX3o=
e4b97aef-02df-4686-82ed-0f1d72877c17	55a4e627-b217-4d4b-ba34-53543be4b53c	priority	100
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
2390bb88-23d8-469d-8399-764197dda005	a7ba7779-875b-4788-99a3-328f298d05b3	f	${role_default-roles}	default-roles-master	a7ba7779-875b-4788-99a3-328f298d05b3	\N	\N
3346375c-ae15-476f-8a16-91310b1cf560	a7ba7779-875b-4788-99a3-328f298d05b3	f	${role_admin}	admin	a7ba7779-875b-4788-99a3-328f298d05b3	\N	\N
25f480ba-775f-41fb-85df-3edc0a045f61	a7ba7779-875b-4788-99a3-328f298d05b3	f	${role_create-realm}	create-realm	a7ba7779-875b-4788-99a3-328f298d05b3	\N	\N
6e21c771-d0fd-428d-8609-59861f12aebc	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_create-client}	create-client	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
3f193827-f731-4932-a6a1-638b88850ffd	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_view-realm}	view-realm	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
6806a7a4-5c5f-4f45-b436-de9139b6520b	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_view-users}	view-users	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
3f2b76bd-0962-4e3d-b147-6cb8f743ce71	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_view-clients}	view-clients	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
9b6d3b89-b487-47ab-b55b-77b31da54e50	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_view-events}	view-events	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
45e2a0d5-5536-4372-a063-c41246abd304	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_view-identity-providers}	view-identity-providers	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
ffa20766-3303-4fc1-a0ae-abc00662c372	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_view-authorization}	view-authorization	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
b459b4a9-0462-4757-bb83-457a3414f691	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_manage-realm}	manage-realm	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
915db407-192c-493b-9663-3fa222c62c0a	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_manage-users}	manage-users	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
a563494e-4bc8-45f3-94c2-e5c3e1229015	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_manage-clients}	manage-clients	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
d01b7b5b-3793-4370-9573-a0f5c1e8dee3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_manage-events}	manage-events	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
4a4766ef-05e3-4320-aa9a-2b28474a888c	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_manage-identity-providers}	manage-identity-providers	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
e0ec1da6-2b53-459b-b9e6-2faadbdf2063	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_manage-authorization}	manage-authorization	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
a08cfd99-f68a-45bd-9bce-ad065e374e40	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_query-users}	query-users	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
16844fb3-b621-451d-a6fa-217da6b75c0a	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_query-clients}	query-clients	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
bb5b8ca1-ceba-4e0d-998d-4ef7088d09ff	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_query-realms}	query-realms	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
c901fa80-49af-40b4-a961-9bf0b6d103c2	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_query-groups}	query-groups	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
22ea4db2-3182-4136-9d60-2308186cca48	530aa4ab-ff70-4256-8abb-0a905d775a99	t	${role_view-profile}	view-profile	a7ba7779-875b-4788-99a3-328f298d05b3	530aa4ab-ff70-4256-8abb-0a905d775a99	\N
5e5b9d0e-7035-45d5-bd68-bb345180da84	530aa4ab-ff70-4256-8abb-0a905d775a99	t	${role_manage-account}	manage-account	a7ba7779-875b-4788-99a3-328f298d05b3	530aa4ab-ff70-4256-8abb-0a905d775a99	\N
1f93d1d3-c032-4bcf-9fe0-5b94a805bb2d	530aa4ab-ff70-4256-8abb-0a905d775a99	t	${role_manage-account-links}	manage-account-links	a7ba7779-875b-4788-99a3-328f298d05b3	530aa4ab-ff70-4256-8abb-0a905d775a99	\N
63c82900-a020-4cb1-afa9-4f80ad443c9a	530aa4ab-ff70-4256-8abb-0a905d775a99	t	${role_view-applications}	view-applications	a7ba7779-875b-4788-99a3-328f298d05b3	530aa4ab-ff70-4256-8abb-0a905d775a99	\N
ab04fedb-87e5-4740-9386-352bedcea25a	530aa4ab-ff70-4256-8abb-0a905d775a99	t	${role_view-consent}	view-consent	a7ba7779-875b-4788-99a3-328f298d05b3	530aa4ab-ff70-4256-8abb-0a905d775a99	\N
24e990d7-3295-4096-a2a4-28cbef3d8ab7	530aa4ab-ff70-4256-8abb-0a905d775a99	t	${role_manage-consent}	manage-consent	a7ba7779-875b-4788-99a3-328f298d05b3	530aa4ab-ff70-4256-8abb-0a905d775a99	\N
f373c49c-043c-4333-a8e5-5b5c77b79f7e	530aa4ab-ff70-4256-8abb-0a905d775a99	t	${role_delete-account}	delete-account	a7ba7779-875b-4788-99a3-328f298d05b3	530aa4ab-ff70-4256-8abb-0a905d775a99	\N
464ed1ce-89e6-4e39-adf1-e036b6ef7639	82ccf254-bfc4-462b-97e1-50f2595b7f06	t	${role_read-token}	read-token	a7ba7779-875b-4788-99a3-328f298d05b3	82ccf254-bfc4-462b-97e1-50f2595b7f06	\N
ce0b306a-6359-4769-bf04-11f3036d8295	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	t	${role_impersonation}	impersonation	a7ba7779-875b-4788-99a3-328f298d05b3	3a3b521b-ec1e-4db8-9d84-f73c0ca096cf	\N
de5a54e6-b775-4742-afa3-0572fbcfe48d	a7ba7779-875b-4788-99a3-328f298d05b3	f	${role_offline-access}	offline_access	a7ba7779-875b-4788-99a3-328f298d05b3	\N	\N
ee710467-0e78-4534-b1de-408a4d0ae728	a7ba7779-875b-4788-99a3-328f298d05b3	f	${role_uma_authorization}	uma_authorization	a7ba7779-875b-4788-99a3-328f298d05b3	\N	\N
b8430a61-318a-4536-8a67-e07515882ed2	8eee160c-5edd-481a-b964-c368a057e598	f	${role_default-roles}	default-roles-bakertech	8eee160c-5edd-481a-b964-c368a057e598	\N	\N
0a8142b2-36e1-4915-8207-8a63cc5c2e24	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_create-client}	create-client	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
46ca92e7-75ce-491c-bd7f-d4e2219fdb38	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_view-realm}	view-realm	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
f251da0b-b417-4c1d-a533-053c8b78c283	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_view-users}	view-users	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
503fd9e1-8700-4144-9c93-4a859380d5b3	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_view-clients}	view-clients	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
6d745769-0b85-4ebf-b6cb-4bbe8ee5fd1f	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_view-events}	view-events	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
f5628a59-ed46-4f58-a1da-626a992a7e75	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_view-identity-providers}	view-identity-providers	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
6b2674a9-0b18-40f1-a393-8c413445d254	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_view-authorization}	view-authorization	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
3682b022-5c48-4383-befb-31b561a753f1	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_manage-realm}	manage-realm	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
b1a99391-0947-48ab-b4ad-467cee5b42b3	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_manage-users}	manage-users	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
61660e5d-bf82-4f61-aacf-29ff00679137	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_manage-clients}	manage-clients	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
2ab5e78e-719d-4a1f-82e8-1917cb8bc2ee	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_manage-events}	manage-events	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
6c64c453-29a8-4471-b1ec-c9762c6a407f	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_manage-identity-providers}	manage-identity-providers	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
8ef0e236-f8b1-4e4c-bc30-d4adced43489	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_manage-authorization}	manage-authorization	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
53fc3309-d03d-4cbf-8476-2d58f6e84d27	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_query-users}	query-users	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
bd47289b-aea1-4c58-8488-203c762ef7a5	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_query-clients}	query-clients	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
ecfdaa35-6d98-4439-a1c6-9c93dcce981f	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_query-realms}	query-realms	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
2e38d188-20b6-4751-a465-9a241dbf23fe	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_query-groups}	query-groups	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
e873c552-e603-456e-abbf-121bc85963df	8eee160c-5edd-481a-b964-c368a057e598	f	${role_offline-access}	offline_access	8eee160c-5edd-481a-b964-c368a057e598	\N	\N
ffb9fc4a-1b1c-4bce-91b3-84a8326a4dd7	8eee160c-5edd-481a-b964-c368a057e598	f		CLIENT	8eee160c-5edd-481a-b964-c368a057e598	\N	\N
0d049c11-8c7b-43d3-aacd-a355d3dded24	8eee160c-5edd-481a-b964-c368a057e598	f		MANAGER	8eee160c-5edd-481a-b964-c368a057e598	\N	\N
8119c6da-88d5-47bc-a54f-e9c262a76b3e	8eee160c-5edd-481a-b964-c368a057e598	f	${role_uma_authorization}	uma_authorization	8eee160c-5edd-481a-b964-c368a057e598	\N	\N
deb2c812-04b9-4b69-ad1e-9fa1883e7388	8eee160c-5edd-481a-b964-c368a057e598	f		ADMINISTRATOR	8eee160c-5edd-481a-b964-c368a057e598	\N	\N
3c9ec334-7a02-469f-b733-9434fa218755	8eee160c-5edd-481a-b964-c368a057e598	f		SERVICEMAN	8eee160c-5edd-481a-b964-c368a057e598	\N	\N
ec9a25c1-c145-4f65-9a77-765ae805f9cc	39610acb-a894-4f24-811f-08d0590f7f79	t	\N	uma_protection	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
163ce16a-8982-43a5-b2a3-fb1aec2d228c	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_view-authorization}	view-authorization	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
942fab8f-595d-4882-b26a-ca721f755519	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_view-users}	view-users	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
757946dd-b8c9-4b27-859a-a9ad555e2dd4	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_query-groups}	query-groups	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
697690dd-0725-48dd-a074-488f7cd69161	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_manage-authorization}	manage-authorization	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
21a2c0c0-1237-42ab-aeb6-cd9f4751dfcb	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_view-clients}	view-clients	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
58ee82ca-f23c-4747-9984-9f20a3eeda23	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_query-users}	query-users	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
c31ae3f8-45f1-4d77-a961-e44f58722e59	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_create-client}	create-client	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
0795eafa-5831-4bb0-89bc-34c57fbcab41	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_view-realm}	view-realm	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
db2682ad-1530-4a7f-922f-9a8dea19f4d1	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_realm-admin}	realm-admin	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
10099c9a-99b6-4f7c-adc0-8e54cbbf6939	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_query-realms}	query-realms	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
edc9153b-f546-41b8-bf81-019bb8af94fd	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_manage-events}	manage-events	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
84774cb4-f335-4305-b213-02935049e7cb	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_manage-users}	manage-users	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
20f331fe-dfff-492a-8300-03a516eb6c45	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_view-events}	view-events	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
c95a2125-5ae7-4761-88cf-6214e553c63e	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_manage-clients}	manage-clients	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
2275587b-3ae1-4c93-9a3c-bd5666fcf695	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_impersonation}	impersonation	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
cf389b40-2527-40a3-93c2-570be37e0d89	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_manage-realm}	manage-realm	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
4ddcf3d2-c22e-4d0c-85aa-9749bd5a7456	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_manage-identity-providers}	manage-identity-providers	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
d532129b-594d-4f24-af53-3245693a84d4	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_view-identity-providers}	view-identity-providers	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
1197cf25-0463-47d0-ad05-bdd3370d8e10	39610acb-a894-4f24-811f-08d0590f7f79	t	${role_query-clients}	query-clients	8eee160c-5edd-481a-b964-c368a057e598	39610acb-a894-4f24-811f-08d0590f7f79	\N
bd515d95-8cc0-4c14-b6cc-b2afc63314b1	80710076-562f-4877-bf9c-7a005d70367b	t	${role_read-token}	read-token	8eee160c-5edd-481a-b964-c368a057e598	80710076-562f-4877-bf9c-7a005d70367b	\N
868d8b6b-ed13-47fc-8c53-e90a88947754	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	t	${role_delete-account}	delete-account	8eee160c-5edd-481a-b964-c368a057e598	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	\N
ce904331-e00c-4157-a4de-e2fbe6cef12f	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	t	${role_manage-account}	manage-account	8eee160c-5edd-481a-b964-c368a057e598	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	\N
5b9d18b7-a864-4619-9c54-2eede09cb669	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	t	${role_manage-account-links}	manage-account-links	8eee160c-5edd-481a-b964-c368a057e598	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	\N
ac5b0414-ba95-4b27-950b-97e08c819f5f	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	t	${role_view-consent}	view-consent	8eee160c-5edd-481a-b964-c368a057e598	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	\N
3b370eb7-9b41-4e4e-b9b6-ed77e7d627f9	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	t	${role_view-profile}	view-profile	8eee160c-5edd-481a-b964-c368a057e598	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	\N
38bc4704-aacf-4fbb-8659-24e5a4521dd3	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	t	${role_view-applications}	view-applications	8eee160c-5edd-481a-b964-c368a057e598	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	\N
387d8dba-a69c-4c1d-8873-aca3a7b4712f	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	t	${role_manage-consent}	manage-consent	8eee160c-5edd-481a-b964-c368a057e598	40a9b368-e495-46bc-b21f-bbbe63d9d7c3	\N
e26197fa-f330-453e-a050-e2847b9c5109	d0bd1619-802f-413e-bca4-31bbce9059a1	t	${role_impersonation}	impersonation	a7ba7779-875b-4788-99a3-328f298d05b3	d0bd1619-802f-413e-bca4-31bbce9059a1	\N
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.composite_role (composite, child_role) FROM stdin;
3346375c-ae15-476f-8a16-91310b1cf560	25f480ba-775f-41fb-85df-3edc0a045f61
3346375c-ae15-476f-8a16-91310b1cf560	6e21c771-d0fd-428d-8609-59861f12aebc
3346375c-ae15-476f-8a16-91310b1cf560	3f193827-f731-4932-a6a1-638b88850ffd
3346375c-ae15-476f-8a16-91310b1cf560	6806a7a4-5c5f-4f45-b436-de9139b6520b
3346375c-ae15-476f-8a16-91310b1cf560	3f2b76bd-0962-4e3d-b147-6cb8f743ce71
3346375c-ae15-476f-8a16-91310b1cf560	9b6d3b89-b487-47ab-b55b-77b31da54e50
3346375c-ae15-476f-8a16-91310b1cf560	45e2a0d5-5536-4372-a063-c41246abd304
3346375c-ae15-476f-8a16-91310b1cf560	ffa20766-3303-4fc1-a0ae-abc00662c372
3346375c-ae15-476f-8a16-91310b1cf560	b459b4a9-0462-4757-bb83-457a3414f691
3346375c-ae15-476f-8a16-91310b1cf560	915db407-192c-493b-9663-3fa222c62c0a
3346375c-ae15-476f-8a16-91310b1cf560	a563494e-4bc8-45f3-94c2-e5c3e1229015
3346375c-ae15-476f-8a16-91310b1cf560	d01b7b5b-3793-4370-9573-a0f5c1e8dee3
3346375c-ae15-476f-8a16-91310b1cf560	4a4766ef-05e3-4320-aa9a-2b28474a888c
3346375c-ae15-476f-8a16-91310b1cf560	e0ec1da6-2b53-459b-b9e6-2faadbdf2063
3346375c-ae15-476f-8a16-91310b1cf560	a08cfd99-f68a-45bd-9bce-ad065e374e40
3346375c-ae15-476f-8a16-91310b1cf560	16844fb3-b621-451d-a6fa-217da6b75c0a
3346375c-ae15-476f-8a16-91310b1cf560	bb5b8ca1-ceba-4e0d-998d-4ef7088d09ff
3346375c-ae15-476f-8a16-91310b1cf560	c901fa80-49af-40b4-a961-9bf0b6d103c2
3f2b76bd-0962-4e3d-b147-6cb8f743ce71	16844fb3-b621-451d-a6fa-217da6b75c0a
6806a7a4-5c5f-4f45-b436-de9139b6520b	a08cfd99-f68a-45bd-9bce-ad065e374e40
6806a7a4-5c5f-4f45-b436-de9139b6520b	c901fa80-49af-40b4-a961-9bf0b6d103c2
2390bb88-23d8-469d-8399-764197dda005	22ea4db2-3182-4136-9d60-2308186cca48
2390bb88-23d8-469d-8399-764197dda005	5e5b9d0e-7035-45d5-bd68-bb345180da84
5e5b9d0e-7035-45d5-bd68-bb345180da84	1f93d1d3-c032-4bcf-9fe0-5b94a805bb2d
24e990d7-3295-4096-a2a4-28cbef3d8ab7	ab04fedb-87e5-4740-9386-352bedcea25a
3346375c-ae15-476f-8a16-91310b1cf560	ce0b306a-6359-4769-bf04-11f3036d8295
2390bb88-23d8-469d-8399-764197dda005	de5a54e6-b775-4742-afa3-0572fbcfe48d
2390bb88-23d8-469d-8399-764197dda005	ee710467-0e78-4534-b1de-408a4d0ae728
3346375c-ae15-476f-8a16-91310b1cf560	0a8142b2-36e1-4915-8207-8a63cc5c2e24
3346375c-ae15-476f-8a16-91310b1cf560	46ca92e7-75ce-491c-bd7f-d4e2219fdb38
3346375c-ae15-476f-8a16-91310b1cf560	f251da0b-b417-4c1d-a533-053c8b78c283
3346375c-ae15-476f-8a16-91310b1cf560	503fd9e1-8700-4144-9c93-4a859380d5b3
3346375c-ae15-476f-8a16-91310b1cf560	6d745769-0b85-4ebf-b6cb-4bbe8ee5fd1f
3346375c-ae15-476f-8a16-91310b1cf560	f5628a59-ed46-4f58-a1da-626a992a7e75
3346375c-ae15-476f-8a16-91310b1cf560	6b2674a9-0b18-40f1-a393-8c413445d254
3346375c-ae15-476f-8a16-91310b1cf560	3682b022-5c48-4383-befb-31b561a753f1
3346375c-ae15-476f-8a16-91310b1cf560	b1a99391-0947-48ab-b4ad-467cee5b42b3
3346375c-ae15-476f-8a16-91310b1cf560	61660e5d-bf82-4f61-aacf-29ff00679137
3346375c-ae15-476f-8a16-91310b1cf560	2ab5e78e-719d-4a1f-82e8-1917cb8bc2ee
3346375c-ae15-476f-8a16-91310b1cf560	6c64c453-29a8-4471-b1ec-c9762c6a407f
3346375c-ae15-476f-8a16-91310b1cf560	8ef0e236-f8b1-4e4c-bc30-d4adced43489
3346375c-ae15-476f-8a16-91310b1cf560	53fc3309-d03d-4cbf-8476-2d58f6e84d27
3346375c-ae15-476f-8a16-91310b1cf560	bd47289b-aea1-4c58-8488-203c762ef7a5
3346375c-ae15-476f-8a16-91310b1cf560	ecfdaa35-6d98-4439-a1c6-9c93dcce981f
3346375c-ae15-476f-8a16-91310b1cf560	2e38d188-20b6-4751-a465-9a241dbf23fe
503fd9e1-8700-4144-9c93-4a859380d5b3	bd47289b-aea1-4c58-8488-203c762ef7a5
f251da0b-b417-4c1d-a533-053c8b78c283	53fc3309-d03d-4cbf-8476-2d58f6e84d27
f251da0b-b417-4c1d-a533-053c8b78c283	2e38d188-20b6-4751-a465-9a241dbf23fe
b8430a61-318a-4536-8a67-e07515882ed2	e873c552-e603-456e-abbf-121bc85963df
b8430a61-318a-4536-8a67-e07515882ed2	ce904331-e00c-4157-a4de-e2fbe6cef12f
b8430a61-318a-4536-8a67-e07515882ed2	8119c6da-88d5-47bc-a54f-e9c262a76b3e
b8430a61-318a-4536-8a67-e07515882ed2	3b370eb7-9b41-4e4e-b9b6-ed77e7d627f9
942fab8f-595d-4882-b26a-ca721f755519	757946dd-b8c9-4b27-859a-a9ad555e2dd4
942fab8f-595d-4882-b26a-ca721f755519	58ee82ca-f23c-4747-9984-9f20a3eeda23
21a2c0c0-1237-42ab-aeb6-cd9f4751dfcb	1197cf25-0463-47d0-ad05-bdd3370d8e10
db2682ad-1530-4a7f-922f-9a8dea19f4d1	163ce16a-8982-43a5-b2a3-fb1aec2d228c
db2682ad-1530-4a7f-922f-9a8dea19f4d1	942fab8f-595d-4882-b26a-ca721f755519
db2682ad-1530-4a7f-922f-9a8dea19f4d1	757946dd-b8c9-4b27-859a-a9ad555e2dd4
db2682ad-1530-4a7f-922f-9a8dea19f4d1	697690dd-0725-48dd-a074-488f7cd69161
db2682ad-1530-4a7f-922f-9a8dea19f4d1	21a2c0c0-1237-42ab-aeb6-cd9f4751dfcb
db2682ad-1530-4a7f-922f-9a8dea19f4d1	58ee82ca-f23c-4747-9984-9f20a3eeda23
db2682ad-1530-4a7f-922f-9a8dea19f4d1	c31ae3f8-45f1-4d77-a961-e44f58722e59
db2682ad-1530-4a7f-922f-9a8dea19f4d1	0795eafa-5831-4bb0-89bc-34c57fbcab41
db2682ad-1530-4a7f-922f-9a8dea19f4d1	10099c9a-99b6-4f7c-adc0-8e54cbbf6939
db2682ad-1530-4a7f-922f-9a8dea19f4d1	edc9153b-f546-41b8-bf81-019bb8af94fd
db2682ad-1530-4a7f-922f-9a8dea19f4d1	84774cb4-f335-4305-b213-02935049e7cb
db2682ad-1530-4a7f-922f-9a8dea19f4d1	20f331fe-dfff-492a-8300-03a516eb6c45
db2682ad-1530-4a7f-922f-9a8dea19f4d1	c95a2125-5ae7-4761-88cf-6214e553c63e
db2682ad-1530-4a7f-922f-9a8dea19f4d1	2275587b-3ae1-4c93-9a3c-bd5666fcf695
db2682ad-1530-4a7f-922f-9a8dea19f4d1	cf389b40-2527-40a3-93c2-570be37e0d89
db2682ad-1530-4a7f-922f-9a8dea19f4d1	4ddcf3d2-c22e-4d0c-85aa-9749bd5a7456
db2682ad-1530-4a7f-922f-9a8dea19f4d1	d532129b-594d-4f24-af53-3245693a84d4
db2682ad-1530-4a7f-922f-9a8dea19f4d1	1197cf25-0463-47d0-ad05-bdd3370d8e10
ce904331-e00c-4157-a4de-e2fbe6cef12f	5b9d18b7-a864-4619-9c54-2eede09cb669
387d8dba-a69c-4c1d-8873-aca3a7b4712f	ac5b0414-ba95-4b27-950b-97e08c819f5f
3346375c-ae15-476f-8a16-91310b1cf560	e26197fa-f330-453e-a050-e2847b9c5109
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
fa9a03d5-2ec0-45cd-a584-6d9231ffa3bf	stary2111@gmail.com	stary2111@gmail.com	f	t	\N	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	bakertech-admin	1695232703564	\N	0
dc28b372-c259-41ce-9cf8-86abfd1f81a2	\N	ae4bd311-569f-4fc9-a647-cf8df266db72	f	t	\N	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	service-account-bakertech	1694027351461	92f5bea7-369a-483d-a9ea-a330f05968b5	0
19ca5976-ff4e-410f-bcdf-240e902d6aa8	\N	be7053c0-3602-4625-8474-fee167b81ea9	f	t	\N	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	service-account-realm-management	1694455940952	39610acb-a894-4f24-811f-08d0590f7f79	0
c2ce3624-9d13-47fa-98ea-4075b0fb180b	\N	459a0d81-32a8-4d31-86f3-76fb66b955b9	f	t	\N	\N	\N	a7ba7779-875b-4788-99a3-328f298d05b3	admin	1695580876278	\N	0
c3e9b1e5-4363-4d11-b01f-7e6d77e35433	cj237@gmail.com	cj237@gmail.com	f	t	\N	\N	\N	8eee160c-5edd-481a-b964-c368a057e598	carljohnson2137	1696185376947	\N	0
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
335d3518-c9fd-470e-89a5-1729f77743a1	\N	password	c2ce3624-9d13-47fa-98ea-4075b0fb180b	1695580876312	\N	{"value":"4Oedu2DPLN1jdB533EBoZC/6SvSqAOEBtZNhoFAiUd5Ha0DUBlgDg1Wv4bFY6+//0WNX0SM4MMhkUj8yKlsBow==","salt":"h6KjdVHnQCg0zkvlGbkrJQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
6b6befb1-d9fb-43ba-bdc8-a73ecf0c8118	\N	password	fa9a03d5-2ec0-45cd-a584-6d9231ffa3bf	1695581049823	My password	{"value":"4mTkIrU1azofsR6SCJvNQ/Cyh4LfMkCCeTW6oWSTF0Om3uXNzCz30bNu8TEkdlCFTiU/uX68RZPz4R9n6Y3e2w==","salt":"jFezE6le7T4U92BCA6BjwQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
9c3798f6-e8b5-4752-9c97-23b4a4d57a2f	\N	password	c3e9b1e5-4363-4d11-b01f-7e6d77e35433	1696185377325	\N	{"value":"fkalX/ewF59NTtlNvguVtPO+1HAQlTyM/zEgBlmMN2mEeMEfVjr6mV5ywI5XmXWHtxLnGFEH3IJQjzjST3IcIA==","salt":"VqY/i3p1nkpgrl+AIHQxKA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2023-09-24 18:40:58.144318	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	5580857513
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2023-09-24 18:40:58.158847	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	5580857513
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2023-09-24 18:40:58.234696	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	5580857513
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2023-09-24 18:40:58.24313	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2023-09-24 18:40:58.431014	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	5580857513
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2023-09-24 18:40:58.436464	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	5580857513
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2023-09-24 18:40:58.610517	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	5580857513
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2023-09-24 18:40:58.616212	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	5580857513
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2023-09-24 18:40:58.626586	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2023-09-24 18:40:58.809994	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	5580857513
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2023-09-24 18:40:58.912612	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2023-09-24 18:40:58.916867	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2023-09-24 18:40:58.964626	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:58.998869	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	5580857513
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.002662	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.00653	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	5580857513
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.010023	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	5580857513
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2023-09-24 18:40:59.103957	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	5580857513
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.180987	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	5580857513
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.189115	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.135265	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	5580857513
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.19374	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	5580857513
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.19779	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	5580857513
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2023-09-24 18:40:59.285352	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	5580857513
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2023-09-24 18:40:59.295224	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	5580857513
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2023-09-24 18:40:59.299227	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	5580857513
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2023-09-24 18:40:59.6336	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	5580857513
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2023-09-24 18:40:59.765083	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	5580857513
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2023-09-24 18:40:59.76963	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	5580857513
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2023-09-24 18:40:59.859857	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	5580857513
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2023-09-24 18:40:59.877674	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	5580857513
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2023-09-24 18:40:59.904181	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	5580857513
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2023-09-24 18:40:59.910237	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	5580857513
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.918053	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.921261	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	5580857513
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.964776	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	5580857513
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.976145	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.985116	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2023-09-24 18:40:59.991177	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	5580857513
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2023-09-24 18:40:59.997382	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	5580857513
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.000333	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	5580857513
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.011473	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	5580857513
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.020981	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	5580857513
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:01.110615	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	5580857513
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2023-09-24 18:41:01.121379	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.144592	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.148798	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.254377	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	5580857513
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.261232	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2023-09-24 18:41:01.351144	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	5580857513
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2023-09-24 18:41:01.5781	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	5580857513
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2023-09-24 18:41:01.584905	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2023-09-24 18:41:01.59002	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	5580857513
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2023-09-24 18:41:01.617693	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.634561	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	5580857513
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.64802	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.729156	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:02.064056	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	5580857513
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2023-09-24 18:41:02.109284	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	5580857513
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2023-09-24 18:41:02.121164	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	5580857513
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-09-24 18:41:02.135543	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	5580857513
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-09-24 18:41:02.146347	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	5580857513
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2023-09-24 18:41:02.152819	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	5580857513
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2023-09-24 18:41:02.159159	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.165124	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.198026	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.221083	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	5580857513
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2023-09-24 18:41:02.229274	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2023-09-24 18:41:02.26158	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	5580857513
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2023-09-24 18:41:02.800745	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	5580857513
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2023-09-24 18:41:02.275059	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	5580857513
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2023-09-24 18:41:02.28256	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	5580857513
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.297996	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.315929	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.31967	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.361222	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	5580857513
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.401624	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	5580857513
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.408974	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.413116	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	5580857513
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.44733	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	5580857513
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.451381	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	5580857513
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.476388	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.481196	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.528106	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.532109	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.566024	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2023-09-24 18:41:02.577469	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	5580857513
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-09-24 18:41:02.594619	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	5580857513
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-09-24 18:41:02.607087	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	5580857513
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.615679	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	5580857513
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.623065	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.6377	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.64753	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.650342	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	5580857513
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2023-09-24 18:41:02.821576	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.8.0	\N	\N	5580857513
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.663636	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.666668	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	5580857513
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.675602	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.714716	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.71809	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.727144	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.748136	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.75167	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.768459	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	5580857513
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.775199	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	5580857513
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2023-09-24 18:41:02.784476	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	5580857513
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2023-09-24 18:41:02.800745	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	5580857513
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2023-09-24 18:41:02.816659	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2023-09-24 18:41:02.821576	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.8.0	\N	\N	5580857513
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2023-09-24 18:40:58.144318	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	5580857513
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2023-09-24 18:40:58.158847	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	5580857513
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2023-09-24 18:40:58.234696	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	5580857513
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2023-09-24 18:40:58.24313	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2023-09-24 18:40:58.431014	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	5580857513
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2023-09-24 18:40:58.436464	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	5580857513
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2023-09-24 18:40:58.610517	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	5580857513
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2023-09-24 18:40:58.616212	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	5580857513
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2023-09-24 18:40:58.626586	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2023-09-24 18:40:58.809994	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	5580857513
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2023-09-24 18:40:58.912612	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2023-09-24 18:40:58.916867	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2023-09-24 18:40:58.964626	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:58.998869	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	5580857513
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.002662	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.00653	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	5580857513
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.010023	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	5580857513
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2023-09-24 18:40:59.103957	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	5580857513
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.180987	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	5580857513
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.189115	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.135265	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	5580857513
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.19374	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	5580857513
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.19779	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	5580857513
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2023-09-24 18:40:59.285352	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	5580857513
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2023-09-24 18:40:59.295224	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	5580857513
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2023-09-24 18:40:59.299227	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	5580857513
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2023-09-24 18:40:59.6336	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	5580857513
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2023-09-24 18:40:59.765083	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	5580857513
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2023-09-24 18:40:59.76963	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	5580857513
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2023-09-24 18:40:59.859857	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	5580857513
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2023-09-24 18:41:02.816659	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2023-09-24 18:40:59.877674	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	5580857513
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2023-09-24 18:40:59.904181	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	5580857513
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2023-09-24 18:40:59.910237	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	5580857513
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.918053	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.921261	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	5580857513
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.964776	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	5580857513
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.976145	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.985116	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2023-09-24 18:40:59.991177	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	5580857513
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2023-09-24 18:40:59.997382	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	5580857513
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.000333	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	5580857513
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.011473	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	5580857513
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.020981	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	5580857513
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:01.110615	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	5580857513
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2023-09-24 18:41:01.121379	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.144592	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.148798	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.254377	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	5580857513
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.261232	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2023-09-24 18:41:01.351144	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	5580857513
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2023-09-24 18:41:01.5781	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	5580857513
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2023-09-24 18:41:01.584905	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2023-09-24 18:41:01.59002	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	5580857513
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2023-09-24 18:41:01.617693	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.634561	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	5580857513
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.64802	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.729156	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:02.064056	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	5580857513
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2023-09-24 18:41:02.109284	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	5580857513
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2023-09-24 18:41:02.121164	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	5580857513
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-09-24 18:41:02.135543	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	5580857513
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-09-24 18:41:02.146347	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	5580857513
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2023-09-24 18:41:02.152819	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	5580857513
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2023-09-24 18:41:02.159159	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.165124	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.198026	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.221083	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	5580857513
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2023-09-24 18:41:02.229274	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2023-09-24 18:41:02.26158	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	5580857513
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2023-09-24 18:41:02.275059	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	5580857513
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2023-09-24 18:41:02.28256	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	5580857513
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.297996	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.315929	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.31967	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.361222	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	5580857513
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.401624	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	5580857513
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.408974	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.413116	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	5580857513
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.44733	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	5580857513
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.451381	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	5580857513
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.476388	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.481196	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.528106	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.532109	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.566024	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2023-09-24 18:41:02.577469	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	5580857513
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-09-24 18:41:02.594619	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	5580857513
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-09-24 18:41:02.607087	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	5580857513
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.615679	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	5580857513
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.623065	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.6377	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.64753	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.650342	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	5580857513
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.663636	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.666668	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	5580857513
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.675602	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.714716	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.71809	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.727144	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.748136	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.75167	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.768459	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	5580857513
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.775199	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	5580857513
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2023-09-24 18:41:02.784476	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	5580857513
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2023-09-24 18:40:58.144318	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	5580857513
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2023-09-24 18:40:58.158847	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	5580857513
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2023-09-24 18:40:58.234696	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	5580857513
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2023-09-24 18:40:58.24313	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2023-09-24 18:40:58.431014	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	5580857513
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2023-09-24 18:40:58.436464	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	5580857513
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2023-09-24 18:40:58.610517	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	5580857513
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2023-09-24 18:40:58.616212	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	5580857513
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2023-09-24 18:40:58.626586	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2023-09-24 18:40:58.809994	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	5580857513
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2023-09-24 18:40:58.912612	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2023-09-24 18:40:58.916867	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2023-09-24 18:40:58.964626	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:58.998869	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	5580857513
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.002662	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.00653	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	5580857513
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.010023	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	5580857513
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2023-09-24 18:40:59.103957	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	5580857513
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.180987	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	5580857513
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.189115	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.135265	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	5580857513
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.19374	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	5580857513
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.19779	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	5580857513
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2023-09-24 18:40:59.285352	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	5580857513
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2023-09-24 18:40:59.295224	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	5580857513
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2023-09-24 18:40:59.299227	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	5580857513
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2023-09-24 18:40:59.6336	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	5580857513
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2023-09-24 18:40:59.765083	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	5580857513
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2023-09-24 18:40:59.76963	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	5580857513
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2023-09-24 18:40:59.859857	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	5580857513
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2023-09-24 18:40:59.877674	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	5580857513
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2023-09-24 18:40:59.904181	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	5580857513
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2023-09-24 18:40:59.910237	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	5580857513
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.918053	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.921261	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	5580857513
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.964776	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	5580857513
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.976145	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.985116	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2023-09-24 18:40:59.991177	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	5580857513
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2023-09-24 18:40:59.997382	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	5580857513
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.000333	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	5580857513
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.011473	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	5580857513
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.020981	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	5580857513
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:01.110615	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	5580857513
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2023-09-24 18:41:01.121379	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.144592	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.148798	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.254377	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	5580857513
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.261232	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2023-09-24 18:41:01.351144	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	5580857513
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2023-09-24 18:41:01.5781	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	5580857513
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2023-09-24 18:41:01.584905	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2023-09-24 18:41:01.59002	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	5580857513
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2023-09-24 18:41:01.617693	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.634561	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	5580857513
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.64802	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.729156	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:02.064056	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	5580857513
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2023-09-24 18:41:02.109284	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	5580857513
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2023-09-24 18:41:02.121164	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	5580857513
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-09-24 18:41:02.135543	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	5580857513
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-09-24 18:41:02.146347	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	5580857513
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2023-09-24 18:41:02.152819	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	5580857513
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2023-09-24 18:41:02.159159	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.165124	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.198026	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.221083	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	5580857513
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2023-09-24 18:41:02.229274	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2023-09-24 18:41:02.26158	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	5580857513
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2023-09-24 18:41:02.800745	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	5580857513
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2023-09-24 18:41:02.275059	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	5580857513
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2023-09-24 18:41:02.28256	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	5580857513
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.297996	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.315929	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.31967	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.361222	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	5580857513
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.401624	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	5580857513
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.408974	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.413116	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	5580857513
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.44733	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	5580857513
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.451381	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	5580857513
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.476388	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.481196	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.528106	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.532109	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.566024	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2023-09-24 18:41:02.577469	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	5580857513
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-09-24 18:41:02.594619	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	5580857513
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-09-24 18:41:02.607087	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	5580857513
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.615679	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	5580857513
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.623065	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.6377	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.64753	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.650342	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	5580857513
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2023-09-24 18:41:02.821576	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.8.0	\N	\N	5580857513
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.663636	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.666668	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	5580857513
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.675602	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.714716	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.71809	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.727144	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.748136	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.75167	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.768459	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	5580857513
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.775199	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	5580857513
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2023-09-24 18:41:02.784476	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	5580857513
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2023-09-24 18:41:02.800745	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	5580857513
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2023-09-24 18:41:02.816659	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2023-09-24 18:41:02.821576	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.8.0	\N	\N	5580857513
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2023-09-24 18:40:58.144318	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	5580857513
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2023-09-24 18:40:58.158847	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	5580857513
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2023-09-24 18:40:58.234696	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	5580857513
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2023-09-24 18:40:58.24313	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2023-09-24 18:40:58.431014	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	5580857513
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2023-09-24 18:40:58.436464	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	5580857513
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2023-09-24 18:40:58.610517	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	5580857513
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2023-09-24 18:40:58.616212	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	5580857513
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2023-09-24 18:40:58.626586	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2023-09-24 18:40:58.809994	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	5580857513
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2023-09-24 18:40:58.912612	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2023-09-24 18:40:58.916867	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2023-09-24 18:40:58.964626	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	5580857513
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:58.998869	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	5580857513
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.002662	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.00653	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	5580857513
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-24 18:40:59.010023	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	5580857513
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2023-09-24 18:40:59.103957	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	5580857513
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.180987	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	5580857513
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.189115	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.135265	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	5580857513
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.19374	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	5580857513
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2023-09-24 18:40:59.19779	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	5580857513
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2023-09-24 18:40:59.285352	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	5580857513
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2023-09-24 18:40:59.295224	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	5580857513
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2023-09-24 18:40:59.299227	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	5580857513
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2023-09-24 18:40:59.6336	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	5580857513
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2023-09-24 18:40:59.765083	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	5580857513
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2023-09-24 18:40:59.76963	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	5580857513
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2023-09-24 18:40:59.859857	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	5580857513
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2023-09-24 18:41:02.816659	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2023-09-24 18:40:59.877674	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	5580857513
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2023-09-24 18:40:59.904181	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	5580857513
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2023-09-24 18:40:59.910237	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	5580857513
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.918053	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.921261	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	5580857513
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.964776	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	5580857513
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.976145	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-24 18:40:59.985116	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2023-09-24 18:40:59.991177	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	5580857513
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2023-09-24 18:40:59.997382	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	5580857513
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.000333	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	5580857513
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.011473	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	5580857513
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:00.020981	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	5580857513
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-24 18:41:01.110615	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	5580857513
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2023-09-24 18:41:01.121379	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.144592	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.148798	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	5580857513
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.254377	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	5580857513
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-24 18:41:01.261232	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2023-09-24 18:41:01.351144	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	5580857513
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2023-09-24 18:41:01.5781	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	5580857513
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2023-09-24 18:41:01.584905	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2023-09-24 18:41:01.59002	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	5580857513
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2023-09-24 18:41:01.617693	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.634561	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	5580857513
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.64802	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:01.729156	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	5580857513
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-24 18:41:02.064056	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	5580857513
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2023-09-24 18:41:02.109284	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	5580857513
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2023-09-24 18:41:02.121164	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	5580857513
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-09-24 18:41:02.135543	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	5580857513
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-09-24 18:41:02.146347	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	5580857513
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2023-09-24 18:41:02.152819	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	5580857513
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2023-09-24 18:41:02.159159	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.165124	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.198026	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	5580857513
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2023-09-24 18:41:02.221083	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	5580857513
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2023-09-24 18:41:02.229274	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	5580857513
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2023-09-24 18:41:02.26158	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	5580857513
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2023-09-24 18:41:02.275059	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	5580857513
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2023-09-24 18:41:02.28256	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	5580857513
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.297996	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.315929	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.31967	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	5580857513
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.361222	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	5580857513
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-24 18:41:02.401624	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	5580857513
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.408974	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.413116	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	5580857513
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.44733	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	5580857513
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-24 18:41:02.451381	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	5580857513
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.476388	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.481196	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.528106	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.532109	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	5580857513
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-24 18:41:02.566024	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	5580857513
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2023-09-24 18:41:02.577469	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	5580857513
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-09-24 18:41:02.594619	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	5580857513
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-09-24 18:41:02.607087	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	5580857513
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.615679	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	5580857513
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.623065	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.6377	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.64753	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.650342	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	5580857513
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.663636	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	5580857513
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.666668	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	5580857513
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-24 18:41:02.675602	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.714716	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.71809	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.727144	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.748136	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.75167	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	5580857513
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.768459	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	5580857513
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-24 18:41:02.775199	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	5580857513
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2023-09-24 18:41:02.784476	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	5580857513
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
a7ba7779-875b-4788-99a3-328f298d05b3	07ab3675-42f8-4b10-b192-8ccd1b2d585c	f
a7ba7779-875b-4788-99a3-328f298d05b3	fcb250d4-b039-468b-9052-c54a64fb504c	t
a7ba7779-875b-4788-99a3-328f298d05b3	6977acb4-8b54-432e-b849-816f8c20c04c	t
a7ba7779-875b-4788-99a3-328f298d05b3	43820c2a-045e-4909-a8f2-f65ed2433a7d	t
a7ba7779-875b-4788-99a3-328f298d05b3	afe4a7ae-f9d8-44f6-8278-f5087bcce7d5	f
a7ba7779-875b-4788-99a3-328f298d05b3	5fdd6127-2f29-4a63-a405-0fea438c255a	f
a7ba7779-875b-4788-99a3-328f298d05b3	e923f6a9-0cd2-4899-a184-d866bf9756a9	t
a7ba7779-875b-4788-99a3-328f298d05b3	97183b7b-2c55-4fbd-99b3-4837cfbc0b00	t
a7ba7779-875b-4788-99a3-328f298d05b3	fa167aac-9554-424f-8b30-4c0297b499d2	f
a7ba7779-875b-4788-99a3-328f298d05b3	815a3e74-387c-4f80-b408-01309615b469	t
8eee160c-5edd-481a-b964-c368a057e598	33583b6c-e729-4916-9bf6-2a3e3b79100f	t
8eee160c-5edd-481a-b964-c368a057e598	ff02e659-87de-4b64-9207-c64548a8d463	t
8eee160c-5edd-481a-b964-c368a057e598	f8859454-c1a8-4f25-815d-8c2f38e11968	t
8eee160c-5edd-481a-b964-c368a057e598	811127fe-927b-4211-b57f-b0ded9b327ef	t
8eee160c-5edd-481a-b964-c368a057e598	b0fe611c-3950-44df-832b-14e0814a70aa	t
8eee160c-5edd-481a-b964-c368a057e598	0bb23a50-5ddb-4dbd-8a00-0d587cc7af17	f
8eee160c-5edd-481a-b964-c368a057e598	7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca	f
8eee160c-5edd-481a-b964-c368a057e598	2393f5e9-6f13-4fb2-b5e3-15c4185d6a98	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
c6e58693-64c1-4c5a-809e-49da74d2ce30	Administrators	 	8eee160c-5edd-481a-b964-c368a057e598
497e8a1b-f1ac-4084-a672-56ff3d41de8c	Clients	 	8eee160c-5edd-481a-b964-c368a057e598
00bc83ff-218f-4d6f-b4c0-49560c9d3aad	Managers	 	8eee160c-5edd-481a-b964-c368a057e598
a2f5c0c5-6aea-40eb-9cc5-cdd625991e95	Servicemen	 	8eee160c-5edd-481a-b964-c368a057e598
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.group_role_mapping (role_id, group_id) FROM stdin;
deb2c812-04b9-4b69-ad1e-9fa1883e7388	c6e58693-64c1-4c5a-809e-49da74d2ce30
ffb9fc4a-1b1c-4bce-91b3-84a8326a4dd7	497e8a1b-f1ac-4084-a672-56ff3d41de8c
0d049c11-8c7b-43d3-aacd-a355d3dded24	00bc83ff-218f-4d6f-b4c0-49560c9d3aad
3c9ec334-7a02-469f-b733-9434fa218755	a2f5c0c5-6aea-40eb-9cc5-cdd625991e95
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.migration_model (id, version, update_time) FROM stdin;
295ji	19.0.3	1695580867
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
6b444e86-bf32-4e81-9e3d-5c11e88e12c7	audience resolve	openid-connect	oidc-audience-resolve-mapper	2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	\N
49400536-4d44-47b8-8e41-4eedc54eba47	locale	openid-connect	oidc-usermodel-attribute-mapper	e1ec9699-6a5e-4408-876d-5e6e18b7bd51	\N
74d678f0-c73b-4c27-ba97-de6d0144a369	role list	saml	saml-role-list-mapper	\N	fcb250d4-b039-468b-9052-c54a64fb504c
d245dd4e-efc0-48d2-80d1-cb3e3c0b3822	full name	openid-connect	oidc-full-name-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
9f1e3a68-0acf-4c31-9966-e2bc82ffe33c	family name	openid-connect	oidc-usermodel-property-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
dce5121d-0031-41bc-abaf-0a0e5fd0fcae	given name	openid-connect	oidc-usermodel-property-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
df6495fe-8a8d-4d9b-a786-50fd55841b53	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
46218efe-c8a8-425f-a385-e43bdcec66bd	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
0cfc211e-b517-4513-ba8b-77d5552137dd	username	openid-connect	oidc-usermodel-property-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
42aa1da0-330b-4bc1-8e3c-ba6b53b34d31	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
b96cbf86-b62e-4141-9b06-f915307fefd1	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
2ddc21c1-2b42-4369-adf9-ac59805583d2	website	openid-connect	oidc-usermodel-attribute-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
085b665a-6236-4187-bce2-f6ec5be85a4d	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
4a5f94bc-4249-4982-9c3d-27e8dbe21c28	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
59b027ab-78cb-44a4-844a-b9e6bbba8c12	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
22d755ca-33d7-49f0-ab8c-107f8689a780	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
1fffd00b-314b-45eb-a9e2-405737d923dc	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	6977acb4-8b54-432e-b849-816f8c20c04c
984191e4-d418-4b93-8298-aa466c458bea	email	openid-connect	oidc-usermodel-property-mapper	\N	43820c2a-045e-4909-a8f2-f65ed2433a7d
23e2a75f-5385-4ee6-b8e5-c6cfeefb0f05	email verified	openid-connect	oidc-usermodel-property-mapper	\N	43820c2a-045e-4909-a8f2-f65ed2433a7d
a5d4c0a4-e4f9-4d0b-8dbf-2a6b5cb87f9c	address	openid-connect	oidc-address-mapper	\N	afe4a7ae-f9d8-44f6-8278-f5087bcce7d5
878d6e5a-b743-4fa3-a2e7-724a1343b59d	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	5fdd6127-2f29-4a63-a405-0fea438c255a
e2a41632-ab44-41a2-b0ca-a5f34f169b1f	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	5fdd6127-2f29-4a63-a405-0fea438c255a
a923793b-a4dd-44d4-ab35-d80afda1439d	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	e923f6a9-0cd2-4899-a184-d866bf9756a9
5da2d373-6f82-4ecf-ac61-f939f5937bc6	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	e923f6a9-0cd2-4899-a184-d866bf9756a9
3df0a1a7-07cc-465d-a87c-fe5a5e694e29	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	e923f6a9-0cd2-4899-a184-d866bf9756a9
8ed69d7c-bfd5-4c53-b346-aa806ccded83	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	97183b7b-2c55-4fbd-99b3-4837cfbc0b00
75feafd3-f41f-4a14-9613-feece8257ee8	upn	openid-connect	oidc-usermodel-property-mapper	\N	fa167aac-9554-424f-8b30-4c0297b499d2
81bd3a0e-cf3a-4bf8-8c3d-e52542230e74	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	fa167aac-9554-424f-8b30-4c0297b499d2
f14cd9bf-ebd9-43a1-9255-7a849ed27b94	acr loa level	openid-connect	oidc-acr-mapper	\N	815a3e74-387c-4f80-b408-01309615b469
caf69847-24e1-4f92-b801-5a09e47a5b66	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	f8859454-c1a8-4f25-815d-8c2f38e11968
8db4e0fb-05d2-4015-9213-d2bc8800f95d	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	f8859454-c1a8-4f25-815d-8c2f38e11968
4229f990-6e15-49e1-9eeb-33b9930b267c	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	f8859454-c1a8-4f25-815d-8c2f38e11968
4f820837-62fb-45ce-9517-5580a2ec10a8	role list	saml	saml-role-list-mapper	\N	33583b6c-e729-4916-9bf6-2a3e3b79100f
76dcc67f-4e11-49e1-ae6c-cb79906aaf6e	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	811127fe-927b-4211-b57f-b0ded9b327ef
d2c969c7-ee34-4982-bc3c-7bff3c286fd7	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	2393f5e9-6f13-4fb2-b5e3-15c4185d6a98
2a906541-6bb1-4f90-9b5d-843e0391b7ac	upn	openid-connect	oidc-usermodel-property-mapper	\N	2393f5e9-6f13-4fb2-b5e3-15c4185d6a98
800432cf-3681-48dc-b79b-400b85080f07	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
ba95db0d-1548-4720-8849-00848c131b10	full name	openid-connect	oidc-full-name-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
871064ca-5938-4db0-b632-ee0d1724dede	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
593633b6-58ef-442f-95d3-fcfadfb3a379	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
113010ac-0884-49a4-8c70-816a16af3bb3	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
32ff5641-e28b-4c1e-ac01-f71acbabc820	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
23c33372-0372-4179-a314-78e26f21b4d2	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
95697b76-b208-40ef-bfc6-e3edc79ed8f7	given name	openid-connect	oidc-usermodel-property-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
0d464d63-d8dc-4c88-9e95-850839a0ee0f	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
685634ba-b026-4393-9353-9f399e63b627	website	openid-connect	oidc-usermodel-attribute-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
1871860e-d5eb-42bd-8438-082ae0cc17c0	username	openid-connect	oidc-usermodel-property-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
2b56929d-c0c6-4c17-8278-de8df834bae2	family name	openid-connect	oidc-usermodel-property-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
10cc0f04-bd0c-4a73-98ca-b86d8d1c10be	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
d5c95ac9-5e91-46ab-8608-40df46c3581f	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	ff02e659-87de-4b64-9207-c64548a8d463
6ed9504b-f3f6-4e46-8049-ebe932dffbe0	acr loa level	openid-connect	oidc-acr-mapper	\N	b0fe611c-3950-44df-832b-14e0814a70aa
21b10d47-16e4-4cc2-8d62-5de0017fc343	address	openid-connect	oidc-address-mapper	\N	7fbb1e63-2ad1-4894-8ae6-e7ed40a164ca
bdc26eeb-d138-4ce9-9080-39e35756d35e	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	d4320bae-9ace-4165-b177-a00033b8fbdb
ae8a91e3-ca13-45d9-a20f-82b0dc7e7293	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	d4320bae-9ace-4165-b177-a00033b8fbdb
6a6cdfdd-64a1-48e1-809f-cc4ed5773ce1	email	openid-connect	oidc-usermodel-property-mapper	\N	03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3
748b4d7f-1eaf-4574-adae-571418d2f271	email verified	openid-connect	oidc-usermodel-property-mapper	\N	03bc1d5f-6c1d-4474-8a05-cddf43e5a4c3
dcb8d992-e6f2-4f18-8f20-fbb6cae15a12	audience resolve	openid-connect	oidc-audience-resolve-mapper	74b39df6-1c8b-4e84-8251-5771ca6a6470	\N
94aa18cf-2b2c-4ded-9717-6e7075778b04	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	92f5bea7-369a-483d-a9ea-a330f05968b5	\N
a4039d27-25ac-4eab-80aa-babd3b48b709	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	92f5bea7-369a-483d-a9ea-a330f05968b5	\N
61f01bea-5724-4b08-9646-684a5f3838eb	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	92f5bea7-369a-483d-a9ea-a330f05968b5	\N
5b97a02f-cd31-403e-98db-b6f26880dc24	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	39610acb-a894-4f24-811f-08d0590f7f79	\N
f0d7c27f-d38c-446e-9349-55ec05bffd3f	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	39610acb-a894-4f24-811f-08d0590f7f79	\N
3a4da86a-2132-46d0-a825-2719d5344ca7	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	39610acb-a894-4f24-811f-08d0590f7f79	\N
40f17d1d-7a01-460a-b060-8ed4e8ae1a9e	locale	openid-connect	oidc-usermodel-attribute-mapper	1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
49400536-4d44-47b8-8e41-4eedc54eba47	true	userinfo.token.claim
49400536-4d44-47b8-8e41-4eedc54eba47	locale	user.attribute
49400536-4d44-47b8-8e41-4eedc54eba47	true	id.token.claim
49400536-4d44-47b8-8e41-4eedc54eba47	true	access.token.claim
49400536-4d44-47b8-8e41-4eedc54eba47	locale	claim.name
49400536-4d44-47b8-8e41-4eedc54eba47	String	jsonType.label
74d678f0-c73b-4c27-ba97-de6d0144a369	false	single
74d678f0-c73b-4c27-ba97-de6d0144a369	Basic	attribute.nameformat
74d678f0-c73b-4c27-ba97-de6d0144a369	Role	attribute.name
d245dd4e-efc0-48d2-80d1-cb3e3c0b3822	true	userinfo.token.claim
d245dd4e-efc0-48d2-80d1-cb3e3c0b3822	true	id.token.claim
d245dd4e-efc0-48d2-80d1-cb3e3c0b3822	true	access.token.claim
9f1e3a68-0acf-4c31-9966-e2bc82ffe33c	true	userinfo.token.claim
9f1e3a68-0acf-4c31-9966-e2bc82ffe33c	lastName	user.attribute
9f1e3a68-0acf-4c31-9966-e2bc82ffe33c	true	id.token.claim
9f1e3a68-0acf-4c31-9966-e2bc82ffe33c	true	access.token.claim
9f1e3a68-0acf-4c31-9966-e2bc82ffe33c	family_name	claim.name
9f1e3a68-0acf-4c31-9966-e2bc82ffe33c	String	jsonType.label
dce5121d-0031-41bc-abaf-0a0e5fd0fcae	true	userinfo.token.claim
dce5121d-0031-41bc-abaf-0a0e5fd0fcae	firstName	user.attribute
dce5121d-0031-41bc-abaf-0a0e5fd0fcae	true	id.token.claim
dce5121d-0031-41bc-abaf-0a0e5fd0fcae	true	access.token.claim
dce5121d-0031-41bc-abaf-0a0e5fd0fcae	given_name	claim.name
dce5121d-0031-41bc-abaf-0a0e5fd0fcae	String	jsonType.label
df6495fe-8a8d-4d9b-a786-50fd55841b53	true	userinfo.token.claim
df6495fe-8a8d-4d9b-a786-50fd55841b53	middleName	user.attribute
df6495fe-8a8d-4d9b-a786-50fd55841b53	true	id.token.claim
df6495fe-8a8d-4d9b-a786-50fd55841b53	true	access.token.claim
df6495fe-8a8d-4d9b-a786-50fd55841b53	middle_name	claim.name
df6495fe-8a8d-4d9b-a786-50fd55841b53	String	jsonType.label
46218efe-c8a8-425f-a385-e43bdcec66bd	true	userinfo.token.claim
46218efe-c8a8-425f-a385-e43bdcec66bd	nickname	user.attribute
46218efe-c8a8-425f-a385-e43bdcec66bd	true	id.token.claim
46218efe-c8a8-425f-a385-e43bdcec66bd	true	access.token.claim
46218efe-c8a8-425f-a385-e43bdcec66bd	nickname	claim.name
46218efe-c8a8-425f-a385-e43bdcec66bd	String	jsonType.label
0cfc211e-b517-4513-ba8b-77d5552137dd	true	userinfo.token.claim
0cfc211e-b517-4513-ba8b-77d5552137dd	username	user.attribute
0cfc211e-b517-4513-ba8b-77d5552137dd	true	id.token.claim
0cfc211e-b517-4513-ba8b-77d5552137dd	true	access.token.claim
0cfc211e-b517-4513-ba8b-77d5552137dd	preferred_username	claim.name
0cfc211e-b517-4513-ba8b-77d5552137dd	String	jsonType.label
42aa1da0-330b-4bc1-8e3c-ba6b53b34d31	true	userinfo.token.claim
42aa1da0-330b-4bc1-8e3c-ba6b53b34d31	profile	user.attribute
42aa1da0-330b-4bc1-8e3c-ba6b53b34d31	true	id.token.claim
42aa1da0-330b-4bc1-8e3c-ba6b53b34d31	true	access.token.claim
42aa1da0-330b-4bc1-8e3c-ba6b53b34d31	profile	claim.name
42aa1da0-330b-4bc1-8e3c-ba6b53b34d31	String	jsonType.label
b96cbf86-b62e-4141-9b06-f915307fefd1	true	userinfo.token.claim
b96cbf86-b62e-4141-9b06-f915307fefd1	picture	user.attribute
b96cbf86-b62e-4141-9b06-f915307fefd1	true	id.token.claim
b96cbf86-b62e-4141-9b06-f915307fefd1	true	access.token.claim
b96cbf86-b62e-4141-9b06-f915307fefd1	picture	claim.name
b96cbf86-b62e-4141-9b06-f915307fefd1	String	jsonType.label
2ddc21c1-2b42-4369-adf9-ac59805583d2	true	userinfo.token.claim
2ddc21c1-2b42-4369-adf9-ac59805583d2	website	user.attribute
2ddc21c1-2b42-4369-adf9-ac59805583d2	true	id.token.claim
2ddc21c1-2b42-4369-adf9-ac59805583d2	true	access.token.claim
2ddc21c1-2b42-4369-adf9-ac59805583d2	website	claim.name
2ddc21c1-2b42-4369-adf9-ac59805583d2	String	jsonType.label
085b665a-6236-4187-bce2-f6ec5be85a4d	true	userinfo.token.claim
085b665a-6236-4187-bce2-f6ec5be85a4d	gender	user.attribute
085b665a-6236-4187-bce2-f6ec5be85a4d	true	id.token.claim
085b665a-6236-4187-bce2-f6ec5be85a4d	true	access.token.claim
085b665a-6236-4187-bce2-f6ec5be85a4d	gender	claim.name
085b665a-6236-4187-bce2-f6ec5be85a4d	String	jsonType.label
4a5f94bc-4249-4982-9c3d-27e8dbe21c28	true	userinfo.token.claim
4a5f94bc-4249-4982-9c3d-27e8dbe21c28	birthdate	user.attribute
4a5f94bc-4249-4982-9c3d-27e8dbe21c28	true	id.token.claim
4a5f94bc-4249-4982-9c3d-27e8dbe21c28	true	access.token.claim
4a5f94bc-4249-4982-9c3d-27e8dbe21c28	birthdate	claim.name
4a5f94bc-4249-4982-9c3d-27e8dbe21c28	String	jsonType.label
59b027ab-78cb-44a4-844a-b9e6bbba8c12	true	userinfo.token.claim
59b027ab-78cb-44a4-844a-b9e6bbba8c12	zoneinfo	user.attribute
59b027ab-78cb-44a4-844a-b9e6bbba8c12	true	id.token.claim
59b027ab-78cb-44a4-844a-b9e6bbba8c12	true	access.token.claim
59b027ab-78cb-44a4-844a-b9e6bbba8c12	zoneinfo	claim.name
59b027ab-78cb-44a4-844a-b9e6bbba8c12	String	jsonType.label
22d755ca-33d7-49f0-ab8c-107f8689a780	true	userinfo.token.claim
22d755ca-33d7-49f0-ab8c-107f8689a780	locale	user.attribute
22d755ca-33d7-49f0-ab8c-107f8689a780	true	id.token.claim
22d755ca-33d7-49f0-ab8c-107f8689a780	true	access.token.claim
22d755ca-33d7-49f0-ab8c-107f8689a780	locale	claim.name
22d755ca-33d7-49f0-ab8c-107f8689a780	String	jsonType.label
1fffd00b-314b-45eb-a9e2-405737d923dc	true	userinfo.token.claim
1fffd00b-314b-45eb-a9e2-405737d923dc	updatedAt	user.attribute
1fffd00b-314b-45eb-a9e2-405737d923dc	true	id.token.claim
1fffd00b-314b-45eb-a9e2-405737d923dc	true	access.token.claim
1fffd00b-314b-45eb-a9e2-405737d923dc	updated_at	claim.name
1fffd00b-314b-45eb-a9e2-405737d923dc	long	jsonType.label
984191e4-d418-4b93-8298-aa466c458bea	true	userinfo.token.claim
984191e4-d418-4b93-8298-aa466c458bea	email	user.attribute
984191e4-d418-4b93-8298-aa466c458bea	true	id.token.claim
984191e4-d418-4b93-8298-aa466c458bea	true	access.token.claim
984191e4-d418-4b93-8298-aa466c458bea	email	claim.name
984191e4-d418-4b93-8298-aa466c458bea	String	jsonType.label
23e2a75f-5385-4ee6-b8e5-c6cfeefb0f05	true	userinfo.token.claim
23e2a75f-5385-4ee6-b8e5-c6cfeefb0f05	emailVerified	user.attribute
23e2a75f-5385-4ee6-b8e5-c6cfeefb0f05	true	id.token.claim
23e2a75f-5385-4ee6-b8e5-c6cfeefb0f05	true	access.token.claim
23e2a75f-5385-4ee6-b8e5-c6cfeefb0f05	email_verified	claim.name
23e2a75f-5385-4ee6-b8e5-c6cfeefb0f05	boolean	jsonType.label
a5d4c0a4-e4f9-4d0b-8dbf-2a6b5cb87f9c	formatted	user.attribute.formatted
a5d4c0a4-e4f9-4d0b-8dbf-2a6b5cb87f9c	country	user.attribute.country
a5d4c0a4-e4f9-4d0b-8dbf-2a6b5cb87f9c	postal_code	user.attribute.postal_code
a5d4c0a4-e4f9-4d0b-8dbf-2a6b5cb87f9c	true	userinfo.token.claim
a5d4c0a4-e4f9-4d0b-8dbf-2a6b5cb87f9c	street	user.attribute.street
a5d4c0a4-e4f9-4d0b-8dbf-2a6b5cb87f9c	true	id.token.claim
a5d4c0a4-e4f9-4d0b-8dbf-2a6b5cb87f9c	region	user.attribute.region
a5d4c0a4-e4f9-4d0b-8dbf-2a6b5cb87f9c	true	access.token.claim
a5d4c0a4-e4f9-4d0b-8dbf-2a6b5cb87f9c	locality	user.attribute.locality
878d6e5a-b743-4fa3-a2e7-724a1343b59d	true	userinfo.token.claim
878d6e5a-b743-4fa3-a2e7-724a1343b59d	phoneNumber	user.attribute
878d6e5a-b743-4fa3-a2e7-724a1343b59d	true	id.token.claim
878d6e5a-b743-4fa3-a2e7-724a1343b59d	true	access.token.claim
878d6e5a-b743-4fa3-a2e7-724a1343b59d	phone_number	claim.name
878d6e5a-b743-4fa3-a2e7-724a1343b59d	String	jsonType.label
e2a41632-ab44-41a2-b0ca-a5f34f169b1f	true	userinfo.token.claim
e2a41632-ab44-41a2-b0ca-a5f34f169b1f	phoneNumberVerified	user.attribute
e2a41632-ab44-41a2-b0ca-a5f34f169b1f	true	id.token.claim
e2a41632-ab44-41a2-b0ca-a5f34f169b1f	true	access.token.claim
e2a41632-ab44-41a2-b0ca-a5f34f169b1f	phone_number_verified	claim.name
e2a41632-ab44-41a2-b0ca-a5f34f169b1f	boolean	jsonType.label
a923793b-a4dd-44d4-ab35-d80afda1439d	true	multivalued
a923793b-a4dd-44d4-ab35-d80afda1439d	foo	user.attribute
a923793b-a4dd-44d4-ab35-d80afda1439d	true	access.token.claim
a923793b-a4dd-44d4-ab35-d80afda1439d	realm_access.roles	claim.name
a923793b-a4dd-44d4-ab35-d80afda1439d	String	jsonType.label
5da2d373-6f82-4ecf-ac61-f939f5937bc6	true	multivalued
5da2d373-6f82-4ecf-ac61-f939f5937bc6	foo	user.attribute
5da2d373-6f82-4ecf-ac61-f939f5937bc6	true	access.token.claim
5da2d373-6f82-4ecf-ac61-f939f5937bc6	resource_access.${client_id}.roles	claim.name
5da2d373-6f82-4ecf-ac61-f939f5937bc6	String	jsonType.label
75feafd3-f41f-4a14-9613-feece8257ee8	true	userinfo.token.claim
75feafd3-f41f-4a14-9613-feece8257ee8	username	user.attribute
75feafd3-f41f-4a14-9613-feece8257ee8	true	id.token.claim
75feafd3-f41f-4a14-9613-feece8257ee8	true	access.token.claim
75feafd3-f41f-4a14-9613-feece8257ee8	upn	claim.name
75feafd3-f41f-4a14-9613-feece8257ee8	String	jsonType.label
81bd3a0e-cf3a-4bf8-8c3d-e52542230e74	true	multivalued
81bd3a0e-cf3a-4bf8-8c3d-e52542230e74	foo	user.attribute
81bd3a0e-cf3a-4bf8-8c3d-e52542230e74	true	id.token.claim
81bd3a0e-cf3a-4bf8-8c3d-e52542230e74	true	access.token.claim
81bd3a0e-cf3a-4bf8-8c3d-e52542230e74	groups	claim.name
81bd3a0e-cf3a-4bf8-8c3d-e52542230e74	String	jsonType.label
f14cd9bf-ebd9-43a1-9255-7a849ed27b94	true	id.token.claim
f14cd9bf-ebd9-43a1-9255-7a849ed27b94	true	access.token.claim
caf69847-24e1-4f92-b801-5a09e47a5b66	foo	user.attribute
caf69847-24e1-4f92-b801-5a09e47a5b66	true	access.token.claim
caf69847-24e1-4f92-b801-5a09e47a5b66	resource_access.${client_id}.roles	claim.name
caf69847-24e1-4f92-b801-5a09e47a5b66	String	jsonType.label
caf69847-24e1-4f92-b801-5a09e47a5b66	true	multivalued
4229f990-6e15-49e1-9eeb-33b9930b267c	foo	user.attribute
4229f990-6e15-49e1-9eeb-33b9930b267c	true	access.token.claim
4229f990-6e15-49e1-9eeb-33b9930b267c	realm_access.roles	claim.name
4229f990-6e15-49e1-9eeb-33b9930b267c	String	jsonType.label
4229f990-6e15-49e1-9eeb-33b9930b267c	true	multivalued
4f820837-62fb-45ce-9517-5580a2ec10a8	false	single
4f820837-62fb-45ce-9517-5580a2ec10a8	Basic	attribute.nameformat
4f820837-62fb-45ce-9517-5580a2ec10a8	Role	attribute.name
d2c969c7-ee34-4982-bc3c-7bff3c286fd7	true	multivalued
d2c969c7-ee34-4982-bc3c-7bff3c286fd7	true	userinfo.token.claim
d2c969c7-ee34-4982-bc3c-7bff3c286fd7	foo	user.attribute
d2c969c7-ee34-4982-bc3c-7bff3c286fd7	true	id.token.claim
d2c969c7-ee34-4982-bc3c-7bff3c286fd7	true	access.token.claim
d2c969c7-ee34-4982-bc3c-7bff3c286fd7	groups	claim.name
d2c969c7-ee34-4982-bc3c-7bff3c286fd7	String	jsonType.label
2a906541-6bb1-4f90-9b5d-843e0391b7ac	true	userinfo.token.claim
2a906541-6bb1-4f90-9b5d-843e0391b7ac	username	user.attribute
2a906541-6bb1-4f90-9b5d-843e0391b7ac	true	id.token.claim
2a906541-6bb1-4f90-9b5d-843e0391b7ac	true	access.token.claim
2a906541-6bb1-4f90-9b5d-843e0391b7ac	upn	claim.name
2a906541-6bb1-4f90-9b5d-843e0391b7ac	String	jsonType.label
800432cf-3681-48dc-b79b-400b85080f07	true	userinfo.token.claim
800432cf-3681-48dc-b79b-400b85080f07	birthdate	user.attribute
800432cf-3681-48dc-b79b-400b85080f07	true	id.token.claim
800432cf-3681-48dc-b79b-400b85080f07	true	access.token.claim
800432cf-3681-48dc-b79b-400b85080f07	birthdate	claim.name
800432cf-3681-48dc-b79b-400b85080f07	String	jsonType.label
ba95db0d-1548-4720-8849-00848c131b10	true	id.token.claim
ba95db0d-1548-4720-8849-00848c131b10	true	access.token.claim
ba95db0d-1548-4720-8849-00848c131b10	true	userinfo.token.claim
871064ca-5938-4db0-b632-ee0d1724dede	true	userinfo.token.claim
871064ca-5938-4db0-b632-ee0d1724dede	locale	user.attribute
871064ca-5938-4db0-b632-ee0d1724dede	true	id.token.claim
871064ca-5938-4db0-b632-ee0d1724dede	true	access.token.claim
871064ca-5938-4db0-b632-ee0d1724dede	locale	claim.name
871064ca-5938-4db0-b632-ee0d1724dede	String	jsonType.label
593633b6-58ef-442f-95d3-fcfadfb3a379	true	userinfo.token.claim
593633b6-58ef-442f-95d3-fcfadfb3a379	middleName	user.attribute
593633b6-58ef-442f-95d3-fcfadfb3a379	true	id.token.claim
593633b6-58ef-442f-95d3-fcfadfb3a379	true	access.token.claim
593633b6-58ef-442f-95d3-fcfadfb3a379	middle_name	claim.name
593633b6-58ef-442f-95d3-fcfadfb3a379	String	jsonType.label
113010ac-0884-49a4-8c70-816a16af3bb3	true	userinfo.token.claim
113010ac-0884-49a4-8c70-816a16af3bb3	gender	user.attribute
113010ac-0884-49a4-8c70-816a16af3bb3	true	id.token.claim
113010ac-0884-49a4-8c70-816a16af3bb3	true	access.token.claim
113010ac-0884-49a4-8c70-816a16af3bb3	gender	claim.name
113010ac-0884-49a4-8c70-816a16af3bb3	String	jsonType.label
32ff5641-e28b-4c1e-ac01-f71acbabc820	true	userinfo.token.claim
32ff5641-e28b-4c1e-ac01-f71acbabc820	updatedAt	user.attribute
32ff5641-e28b-4c1e-ac01-f71acbabc820	true	id.token.claim
32ff5641-e28b-4c1e-ac01-f71acbabc820	true	access.token.claim
32ff5641-e28b-4c1e-ac01-f71acbabc820	updated_at	claim.name
32ff5641-e28b-4c1e-ac01-f71acbabc820	long	jsonType.label
23c33372-0372-4179-a314-78e26f21b4d2	true	userinfo.token.claim
23c33372-0372-4179-a314-78e26f21b4d2	zoneinfo	user.attribute
23c33372-0372-4179-a314-78e26f21b4d2	true	id.token.claim
23c33372-0372-4179-a314-78e26f21b4d2	true	access.token.claim
23c33372-0372-4179-a314-78e26f21b4d2	zoneinfo	claim.name
23c33372-0372-4179-a314-78e26f21b4d2	String	jsonType.label
95697b76-b208-40ef-bfc6-e3edc79ed8f7	true	userinfo.token.claim
95697b76-b208-40ef-bfc6-e3edc79ed8f7	firstName	user.attribute
95697b76-b208-40ef-bfc6-e3edc79ed8f7	true	id.token.claim
95697b76-b208-40ef-bfc6-e3edc79ed8f7	true	access.token.claim
95697b76-b208-40ef-bfc6-e3edc79ed8f7	given_name	claim.name
95697b76-b208-40ef-bfc6-e3edc79ed8f7	String	jsonType.label
0d464d63-d8dc-4c88-9e95-850839a0ee0f	true	userinfo.token.claim
0d464d63-d8dc-4c88-9e95-850839a0ee0f	picture	user.attribute
0d464d63-d8dc-4c88-9e95-850839a0ee0f	true	id.token.claim
0d464d63-d8dc-4c88-9e95-850839a0ee0f	true	access.token.claim
0d464d63-d8dc-4c88-9e95-850839a0ee0f	picture	claim.name
0d464d63-d8dc-4c88-9e95-850839a0ee0f	String	jsonType.label
685634ba-b026-4393-9353-9f399e63b627	true	userinfo.token.claim
685634ba-b026-4393-9353-9f399e63b627	website	user.attribute
685634ba-b026-4393-9353-9f399e63b627	true	id.token.claim
685634ba-b026-4393-9353-9f399e63b627	true	access.token.claim
685634ba-b026-4393-9353-9f399e63b627	website	claim.name
685634ba-b026-4393-9353-9f399e63b627	String	jsonType.label
1871860e-d5eb-42bd-8438-082ae0cc17c0	true	userinfo.token.claim
1871860e-d5eb-42bd-8438-082ae0cc17c0	username	user.attribute
1871860e-d5eb-42bd-8438-082ae0cc17c0	true	id.token.claim
1871860e-d5eb-42bd-8438-082ae0cc17c0	true	access.token.claim
1871860e-d5eb-42bd-8438-082ae0cc17c0	preferred_username	claim.name
1871860e-d5eb-42bd-8438-082ae0cc17c0	String	jsonType.label
2b56929d-c0c6-4c17-8278-de8df834bae2	true	userinfo.token.claim
2b56929d-c0c6-4c17-8278-de8df834bae2	lastName	user.attribute
2b56929d-c0c6-4c17-8278-de8df834bae2	true	id.token.claim
2b56929d-c0c6-4c17-8278-de8df834bae2	true	access.token.claim
2b56929d-c0c6-4c17-8278-de8df834bae2	family_name	claim.name
2b56929d-c0c6-4c17-8278-de8df834bae2	String	jsonType.label
10cc0f04-bd0c-4a73-98ca-b86d8d1c10be	true	userinfo.token.claim
10cc0f04-bd0c-4a73-98ca-b86d8d1c10be	nickname	user.attribute
10cc0f04-bd0c-4a73-98ca-b86d8d1c10be	true	id.token.claim
10cc0f04-bd0c-4a73-98ca-b86d8d1c10be	true	access.token.claim
10cc0f04-bd0c-4a73-98ca-b86d8d1c10be	nickname	claim.name
10cc0f04-bd0c-4a73-98ca-b86d8d1c10be	String	jsonType.label
d5c95ac9-5e91-46ab-8608-40df46c3581f	true	userinfo.token.claim
d5c95ac9-5e91-46ab-8608-40df46c3581f	profile	user.attribute
d5c95ac9-5e91-46ab-8608-40df46c3581f	true	id.token.claim
d5c95ac9-5e91-46ab-8608-40df46c3581f	true	access.token.claim
d5c95ac9-5e91-46ab-8608-40df46c3581f	profile	claim.name
d5c95ac9-5e91-46ab-8608-40df46c3581f	String	jsonType.label
6ed9504b-f3f6-4e46-8049-ebe932dffbe0	true	id.token.claim
6ed9504b-f3f6-4e46-8049-ebe932dffbe0	true	access.token.claim
6ed9504b-f3f6-4e46-8049-ebe932dffbe0	true	userinfo.token.claim
21b10d47-16e4-4cc2-8d62-5de0017fc343	formatted	user.attribute.formatted
21b10d47-16e4-4cc2-8d62-5de0017fc343	country	user.attribute.country
21b10d47-16e4-4cc2-8d62-5de0017fc343	postal_code	user.attribute.postal_code
21b10d47-16e4-4cc2-8d62-5de0017fc343	true	userinfo.token.claim
21b10d47-16e4-4cc2-8d62-5de0017fc343	street	user.attribute.street
21b10d47-16e4-4cc2-8d62-5de0017fc343	true	id.token.claim
21b10d47-16e4-4cc2-8d62-5de0017fc343	region	user.attribute.region
21b10d47-16e4-4cc2-8d62-5de0017fc343	true	access.token.claim
21b10d47-16e4-4cc2-8d62-5de0017fc343	locality	user.attribute.locality
bdc26eeb-d138-4ce9-9080-39e35756d35e	true	userinfo.token.claim
bdc26eeb-d138-4ce9-9080-39e35756d35e	phoneNumberVerified	user.attribute
bdc26eeb-d138-4ce9-9080-39e35756d35e	true	id.token.claim
bdc26eeb-d138-4ce9-9080-39e35756d35e	true	access.token.claim
bdc26eeb-d138-4ce9-9080-39e35756d35e	phone_number_verified	claim.name
bdc26eeb-d138-4ce9-9080-39e35756d35e	boolean	jsonType.label
ae8a91e3-ca13-45d9-a20f-82b0dc7e7293	true	userinfo.token.claim
ae8a91e3-ca13-45d9-a20f-82b0dc7e7293	phoneNumber	user.attribute
ae8a91e3-ca13-45d9-a20f-82b0dc7e7293	true	id.token.claim
ae8a91e3-ca13-45d9-a20f-82b0dc7e7293	true	access.token.claim
ae8a91e3-ca13-45d9-a20f-82b0dc7e7293	phone_number	claim.name
ae8a91e3-ca13-45d9-a20f-82b0dc7e7293	String	jsonType.label
6a6cdfdd-64a1-48e1-809f-cc4ed5773ce1	true	userinfo.token.claim
6a6cdfdd-64a1-48e1-809f-cc4ed5773ce1	email	user.attribute
6a6cdfdd-64a1-48e1-809f-cc4ed5773ce1	true	id.token.claim
6a6cdfdd-64a1-48e1-809f-cc4ed5773ce1	true	access.token.claim
6a6cdfdd-64a1-48e1-809f-cc4ed5773ce1	email	claim.name
6a6cdfdd-64a1-48e1-809f-cc4ed5773ce1	String	jsonType.label
748b4d7f-1eaf-4574-adae-571418d2f271	true	userinfo.token.claim
748b4d7f-1eaf-4574-adae-571418d2f271	emailVerified	user.attribute
748b4d7f-1eaf-4574-adae-571418d2f271	true	id.token.claim
748b4d7f-1eaf-4574-adae-571418d2f271	true	access.token.claim
748b4d7f-1eaf-4574-adae-571418d2f271	email_verified	claim.name
748b4d7f-1eaf-4574-adae-571418d2f271	boolean	jsonType.label
94aa18cf-2b2c-4ded-9717-6e7075778b04	clientHost	user.session.note
94aa18cf-2b2c-4ded-9717-6e7075778b04	true	userinfo.token.claim
94aa18cf-2b2c-4ded-9717-6e7075778b04	true	id.token.claim
94aa18cf-2b2c-4ded-9717-6e7075778b04	true	access.token.claim
94aa18cf-2b2c-4ded-9717-6e7075778b04	clientHost	claim.name
94aa18cf-2b2c-4ded-9717-6e7075778b04	String	jsonType.label
a4039d27-25ac-4eab-80aa-babd3b48b709	clientAddress	user.session.note
a4039d27-25ac-4eab-80aa-babd3b48b709	true	userinfo.token.claim
a4039d27-25ac-4eab-80aa-babd3b48b709	true	id.token.claim
a4039d27-25ac-4eab-80aa-babd3b48b709	true	access.token.claim
a4039d27-25ac-4eab-80aa-babd3b48b709	clientAddress	claim.name
a4039d27-25ac-4eab-80aa-babd3b48b709	String	jsonType.label
61f01bea-5724-4b08-9646-684a5f3838eb	clientId	user.session.note
61f01bea-5724-4b08-9646-684a5f3838eb	true	userinfo.token.claim
61f01bea-5724-4b08-9646-684a5f3838eb	true	id.token.claim
61f01bea-5724-4b08-9646-684a5f3838eb	true	access.token.claim
61f01bea-5724-4b08-9646-684a5f3838eb	clientId	claim.name
61f01bea-5724-4b08-9646-684a5f3838eb	String	jsonType.label
5b97a02f-cd31-403e-98db-b6f26880dc24	clientId	user.session.note
5b97a02f-cd31-403e-98db-b6f26880dc24	true	id.token.claim
5b97a02f-cd31-403e-98db-b6f26880dc24	true	access.token.claim
5b97a02f-cd31-403e-98db-b6f26880dc24	clientId	claim.name
5b97a02f-cd31-403e-98db-b6f26880dc24	String	jsonType.label
5b97a02f-cd31-403e-98db-b6f26880dc24	true	userinfo.token.claim
f0d7c27f-d38c-446e-9349-55ec05bffd3f	clientAddress	user.session.note
f0d7c27f-d38c-446e-9349-55ec05bffd3f	true	id.token.claim
f0d7c27f-d38c-446e-9349-55ec05bffd3f	true	access.token.claim
f0d7c27f-d38c-446e-9349-55ec05bffd3f	clientAddress	claim.name
f0d7c27f-d38c-446e-9349-55ec05bffd3f	String	jsonType.label
3a4da86a-2132-46d0-a825-2719d5344ca7	clientHost	user.session.note
3a4da86a-2132-46d0-a825-2719d5344ca7	true	id.token.claim
3a4da86a-2132-46d0-a825-2719d5344ca7	true	access.token.claim
3a4da86a-2132-46d0-a825-2719d5344ca7	clientHost	claim.name
3a4da86a-2132-46d0-a825-2719d5344ca7	String	jsonType.label
f0d7c27f-d38c-446e-9349-55ec05bffd3f	true	userinfo.token.claim
3a4da86a-2132-46d0-a825-2719d5344ca7	true	userinfo.token.claim
40f17d1d-7a01-460a-b060-8ed4e8ae1a9e	true	userinfo.token.claim
40f17d1d-7a01-460a-b060-8ed4e8ae1a9e	locale	user.attribute
40f17d1d-7a01-460a-b060-8ed4e8ae1a9e	true	id.token.claim
40f17d1d-7a01-460a-b060-8ed4e8ae1a9e	true	access.token.claim
40f17d1d-7a01-460a-b060-8ed4e8ae1a9e	locale	claim.name
40f17d1d-7a01-460a-b060-8ed4e8ae1a9e	String	jsonType.label
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	a7ba7779-875b-4788-99a3-328f298d05b3	
_browser_header.xContentTypeOptions	a7ba7779-875b-4788-99a3-328f298d05b3	nosniff
_browser_header.xRobotsTag	a7ba7779-875b-4788-99a3-328f298d05b3	none
_browser_header.xFrameOptions	a7ba7779-875b-4788-99a3-328f298d05b3	SAMEORIGIN
_browser_header.contentSecurityPolicy	a7ba7779-875b-4788-99a3-328f298d05b3	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	a7ba7779-875b-4788-99a3-328f298d05b3	1; mode=block
_browser_header.strictTransportSecurity	a7ba7779-875b-4788-99a3-328f298d05b3	max-age=31536000; includeSubDomains
bruteForceProtected	a7ba7779-875b-4788-99a3-328f298d05b3	false
permanentLockout	a7ba7779-875b-4788-99a3-328f298d05b3	false
maxFailureWaitSeconds	a7ba7779-875b-4788-99a3-328f298d05b3	900
minimumQuickLoginWaitSeconds	a7ba7779-875b-4788-99a3-328f298d05b3	60
waitIncrementSeconds	a7ba7779-875b-4788-99a3-328f298d05b3	60
quickLoginCheckMilliSeconds	a7ba7779-875b-4788-99a3-328f298d05b3	1000
maxDeltaTimeSeconds	a7ba7779-875b-4788-99a3-328f298d05b3	43200
failureFactor	a7ba7779-875b-4788-99a3-328f298d05b3	30
displayName	a7ba7779-875b-4788-99a3-328f298d05b3	Keycloak
displayNameHtml	a7ba7779-875b-4788-99a3-328f298d05b3	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	a7ba7779-875b-4788-99a3-328f298d05b3	RS256
offlineSessionMaxLifespanEnabled	a7ba7779-875b-4788-99a3-328f298d05b3	false
offlineSessionMaxLifespan	a7ba7779-875b-4788-99a3-328f298d05b3	5184000
_browser_header.contentSecurityPolicyReportOnly	8eee160c-5edd-481a-b964-c368a057e598	
_browser_header.xContentTypeOptions	8eee160c-5edd-481a-b964-c368a057e598	nosniff
_browser_header.xRobotsTag	8eee160c-5edd-481a-b964-c368a057e598	none
_browser_header.xFrameOptions	8eee160c-5edd-481a-b964-c368a057e598	SAMEORIGIN
_browser_header.contentSecurityPolicy	8eee160c-5edd-481a-b964-c368a057e598	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	8eee160c-5edd-481a-b964-c368a057e598	1; mode=block
_browser_header.strictTransportSecurity	8eee160c-5edd-481a-b964-c368a057e598	max-age=31536000; includeSubDomains
bruteForceProtected	8eee160c-5edd-481a-b964-c368a057e598	false
permanentLockout	8eee160c-5edd-481a-b964-c368a057e598	false
maxFailureWaitSeconds	8eee160c-5edd-481a-b964-c368a057e598	900
minimumQuickLoginWaitSeconds	8eee160c-5edd-481a-b964-c368a057e598	60
waitIncrementSeconds	8eee160c-5edd-481a-b964-c368a057e598	60
quickLoginCheckMilliSeconds	8eee160c-5edd-481a-b964-c368a057e598	1000
maxDeltaTimeSeconds	8eee160c-5edd-481a-b964-c368a057e598	43200
failureFactor	8eee160c-5edd-481a-b964-c368a057e598	30
defaultSignatureAlgorithm	8eee160c-5edd-481a-b964-c368a057e598	RS256
offlineSessionMaxLifespanEnabled	8eee160c-5edd-481a-b964-c368a057e598	false
offlineSessionMaxLifespan	8eee160c-5edd-481a-b964-c368a057e598	5184000
clientSessionIdleTimeout	8eee160c-5edd-481a-b964-c368a057e598	0
clientSessionMaxLifespan	8eee160c-5edd-481a-b964-c368a057e598	0
clientOfflineSessionIdleTimeout	8eee160c-5edd-481a-b964-c368a057e598	0
clientOfflineSessionMaxLifespan	8eee160c-5edd-481a-b964-c368a057e598	0
actionTokenGeneratedByAdminLifespan	8eee160c-5edd-481a-b964-c368a057e598	43200
actionTokenGeneratedByUserLifespan	8eee160c-5edd-481a-b964-c368a057e598	300
oauth2DeviceCodeLifespan	8eee160c-5edd-481a-b964-c368a057e598	600
oauth2DevicePollingInterval	8eee160c-5edd-481a-b964-c368a057e598	5
webAuthnPolicyRpEntityName	8eee160c-5edd-481a-b964-c368a057e598	keycloak
webAuthnPolicySignatureAlgorithms	8eee160c-5edd-481a-b964-c368a057e598	ES256
webAuthnPolicyRpId	8eee160c-5edd-481a-b964-c368a057e598	
webAuthnPolicyAttestationConveyancePreference	8eee160c-5edd-481a-b964-c368a057e598	not specified
webAuthnPolicyAuthenticatorAttachment	8eee160c-5edd-481a-b964-c368a057e598	not specified
webAuthnPolicyRequireResidentKey	8eee160c-5edd-481a-b964-c368a057e598	not specified
webAuthnPolicyUserVerificationRequirement	8eee160c-5edd-481a-b964-c368a057e598	not specified
webAuthnPolicyCreateTimeout	8eee160c-5edd-481a-b964-c368a057e598	0
webAuthnPolicyAvoidSameAuthenticatorRegister	8eee160c-5edd-481a-b964-c368a057e598	false
webAuthnPolicyRpEntityNamePasswordless	8eee160c-5edd-481a-b964-c368a057e598	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	8eee160c-5edd-481a-b964-c368a057e598	ES256
webAuthnPolicyRpIdPasswordless	8eee160c-5edd-481a-b964-c368a057e598	
webAuthnPolicyAttestationConveyancePreferencePasswordless	8eee160c-5edd-481a-b964-c368a057e598	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	8eee160c-5edd-481a-b964-c368a057e598	not specified
webAuthnPolicyRequireResidentKeyPasswordless	8eee160c-5edd-481a-b964-c368a057e598	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	8eee160c-5edd-481a-b964-c368a057e598	not specified
webAuthnPolicyCreateTimeoutPasswordless	8eee160c-5edd-481a-b964-c368a057e598	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	8eee160c-5edd-481a-b964-c368a057e598	false
cibaBackchannelTokenDeliveryMode	8eee160c-5edd-481a-b964-c368a057e598	poll
cibaExpiresIn	8eee160c-5edd-481a-b964-c368a057e598	120
cibaInterval	8eee160c-5edd-481a-b964-c368a057e598	5
cibaAuthRequestedUserHint	8eee160c-5edd-481a-b964-c368a057e598	login_hint
parRequestUriLifespan	8eee160c-5edd-481a-b964-c368a057e598	60
client-policies.profiles	8eee160c-5edd-481a-b964-c368a057e598	{"profiles":[]}
client-policies.policies	8eee160c-5edd-481a-b964-c368a057e598	{"policies":[]}
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.realm_events_listeners (realm_id, value) FROM stdin;
a7ba7779-875b-4788-99a3-328f298d05b3	jboss-logging
8eee160c-5edd-481a-b964-c368a057e598	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	a7ba7779-875b-4788-99a3-328f298d05b3
password	password	t	t	8eee160c-5edd-481a-b964-c368a057e598
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.redirect_uris (client_id, value) FROM stdin;
530aa4ab-ff70-4256-8abb-0a905d775a99	/realms/master/account/*
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	/realms/master/account/*
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	/admin/master/console/*
40a9b368-e495-46bc-b21f-bbbe63d9d7c3	/realms/BakerTech/account/*
74b39df6-1c8b-4e84-8251-5771ca6a6470	/realms/BakerTech/account/*
92f5bea7-369a-483d-a9ea-a330f05968b5	/realms/BakerTech/bakertech/*
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	/admin/BakerTech/console/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
b296e741-cc34-43fb-b27c-3d416a94528b	VERIFY_EMAIL	Verify Email	a7ba7779-875b-4788-99a3-328f298d05b3	t	f	VERIFY_EMAIL	50
1a5cfed0-59b1-4011-a8be-0bc6680b8044	UPDATE_PROFILE	Update Profile	a7ba7779-875b-4788-99a3-328f298d05b3	t	f	UPDATE_PROFILE	40
ecc2c241-70eb-429c-b7ef-2d6233c8379f	CONFIGURE_TOTP	Configure OTP	a7ba7779-875b-4788-99a3-328f298d05b3	t	f	CONFIGURE_TOTP	10
3e83a14a-542b-47a0-8865-1f825901100d	UPDATE_PASSWORD	Update Password	a7ba7779-875b-4788-99a3-328f298d05b3	t	f	UPDATE_PASSWORD	30
10dd61b1-baf3-46c4-bbcd-99056ecad387	terms_and_conditions	Terms and Conditions	a7ba7779-875b-4788-99a3-328f298d05b3	f	f	terms_and_conditions	20
f418b003-de7c-40cc-8d4a-e90981b478b3	update_user_locale	Update User Locale	a7ba7779-875b-4788-99a3-328f298d05b3	t	f	update_user_locale	1000
a552ef22-5f40-4f21-b5e2-c422ab405fa7	delete_account	Delete Account	a7ba7779-875b-4788-99a3-328f298d05b3	f	f	delete_account	60
b033bc7e-77a3-4a89-b629-a98cdc0df9a9	webauthn-register	Webauthn Register	a7ba7779-875b-4788-99a3-328f298d05b3	t	f	webauthn-register	70
62e932f1-876b-463f-866c-fa3c70f3d94f	webauthn-register-passwordless	Webauthn Register Passwordless	a7ba7779-875b-4788-99a3-328f298d05b3	t	f	webauthn-register-passwordless	80
a8320619-5533-44e4-9b02-b2eb5ee54d31	CONFIGURE_TOTP	Configure OTP	8eee160c-5edd-481a-b964-c368a057e598	t	f	CONFIGURE_TOTP	10
58630ac5-5705-482d-aec5-9700c0d1833f	terms_and_conditions	Terms and Conditions	8eee160c-5edd-481a-b964-c368a057e598	f	f	terms_and_conditions	20
c5b5c0d4-0ec6-4eef-88b8-73a5153ffcd9	UPDATE_PASSWORD	Update Password	8eee160c-5edd-481a-b964-c368a057e598	t	f	UPDATE_PASSWORD	30
90f64b81-1f94-485f-b74b-e040d6e506fd	UPDATE_PROFILE	Update Profile	8eee160c-5edd-481a-b964-c368a057e598	t	f	UPDATE_PROFILE	40
3ba49c85-673e-4b3c-aecc-4da28f9fc27f	VERIFY_EMAIL	Verify Email	8eee160c-5edd-481a-b964-c368a057e598	t	f	VERIFY_EMAIL	50
1b1d457d-a643-4dd2-8381-fd766aa8d2cf	delete_account	Delete Account	8eee160c-5edd-481a-b964-c368a057e598	f	f	delete_account	60
148d8350-b461-4d82-9dd8-ab11e9c77fd4	webauthn-register	Webauthn Register	8eee160c-5edd-481a-b964-c368a057e598	t	f	webauthn-register	70
b07e36cf-6b50-4a3c-9c81-f920471ac8a8	webauthn-register-passwordless	Webauthn Register Passwordless	8eee160c-5edd-481a-b964-c368a057e598	t	f	webauthn-register-passwordless	80
64e8e2d1-4070-41bc-8bac-2980757f0bfb	update_user_locale	Update User Locale	8eee160c-5edd-481a-b964-c368a057e598	t	f	update_user_locale	1000
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
c5c28379-d452-4d20-8816-7a101540d60f	map-role	\N	39610acb-a894-4f24-811f-08d0590f7f79	\N
d202549b-cb72-4541-a787-431d92cf6afd	map-role-client-scope	\N	39610acb-a894-4f24-811f-08d0590f7f79	\N
dce2dde4-f901-4ade-a0f4-60eb904949da	map-role-composite	\N	39610acb-a894-4f24-811f-08d0590f7f79	\N
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.scope_mapping (client_id, role_id) FROM stdin;
2df8f7f6-f9a4-4f9d-82e7-c1d66f14d1b7	5e5b9d0e-7035-45d5-bd68-bb345180da84
74b39df6-1c8b-4e84-8251-5771ca6a6470	ce904331-e00c-4157-a4de-e2fbe6cef12f
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_group_membership (group_id, user_id) FROM stdin;
c6e58693-64c1-4c5a-809e-49da74d2ce30	fa9a03d5-2ec0-45cd-a584-6d9231ffa3bf
a2f5c0c5-6aea-40eb-9cc5-cdd625991e95	c3e9b1e5-4363-4d11-b01f-7e6d77e35433
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_role_mapping (role_id, user_id) FROM stdin;
b8430a61-318a-4536-8a67-e07515882ed2	dc28b372-c259-41ce-9cf8-86abfd1f81a2
163ce16a-8982-43a5-b2a3-fb1aec2d228c	dc28b372-c259-41ce-9cf8-86abfd1f81a2
58ee82ca-f23c-4747-9984-9f20a3eeda23	dc28b372-c259-41ce-9cf8-86abfd1f81a2
db2682ad-1530-4a7f-922f-9a8dea19f4d1	dc28b372-c259-41ce-9cf8-86abfd1f81a2
10099c9a-99b6-4f7c-adc0-8e54cbbf6939	dc28b372-c259-41ce-9cf8-86abfd1f81a2
2275587b-3ae1-4c93-9a3c-bd5666fcf695	dc28b372-c259-41ce-9cf8-86abfd1f81a2
942fab8f-595d-4882-b26a-ca721f755519	dc28b372-c259-41ce-9cf8-86abfd1f81a2
757946dd-b8c9-4b27-859a-a9ad555e2dd4	dc28b372-c259-41ce-9cf8-86abfd1f81a2
697690dd-0725-48dd-a074-488f7cd69161	dc28b372-c259-41ce-9cf8-86abfd1f81a2
21a2c0c0-1237-42ab-aeb6-cd9f4751dfcb	dc28b372-c259-41ce-9cf8-86abfd1f81a2
0795eafa-5831-4bb0-89bc-34c57fbcab41	dc28b372-c259-41ce-9cf8-86abfd1f81a2
c31ae3f8-45f1-4d77-a961-e44f58722e59	dc28b372-c259-41ce-9cf8-86abfd1f81a2
84774cb4-f335-4305-b213-02935049e7cb	dc28b372-c259-41ce-9cf8-86abfd1f81a2
edc9153b-f546-41b8-bf81-019bb8af94fd	dc28b372-c259-41ce-9cf8-86abfd1f81a2
20f331fe-dfff-492a-8300-03a516eb6c45	dc28b372-c259-41ce-9cf8-86abfd1f81a2
c95a2125-5ae7-4761-88cf-6214e553c63e	dc28b372-c259-41ce-9cf8-86abfd1f81a2
cf389b40-2527-40a3-93c2-570be37e0d89	dc28b372-c259-41ce-9cf8-86abfd1f81a2
bd515d95-8cc0-4c14-b6cc-b2afc63314b1	dc28b372-c259-41ce-9cf8-86abfd1f81a2
ac5b0414-ba95-4b27-950b-97e08c819f5f	dc28b372-c259-41ce-9cf8-86abfd1f81a2
38bc4704-aacf-4fbb-8659-24e5a4521dd3	dc28b372-c259-41ce-9cf8-86abfd1f81a2
868d8b6b-ed13-47fc-8c53-e90a88947754	dc28b372-c259-41ce-9cf8-86abfd1f81a2
3b370eb7-9b41-4e4e-b9b6-ed77e7d627f9	dc28b372-c259-41ce-9cf8-86abfd1f81a2
ce904331-e00c-4157-a4de-e2fbe6cef12f	dc28b372-c259-41ce-9cf8-86abfd1f81a2
5b9d18b7-a864-4619-9c54-2eede09cb669	dc28b372-c259-41ce-9cf8-86abfd1f81a2
387d8dba-a69c-4c1d-8873-aca3a7b4712f	dc28b372-c259-41ce-9cf8-86abfd1f81a2
b8430a61-318a-4536-8a67-e07515882ed2	19ca5976-ff4e-410f-bcdf-240e902d6aa8
ec9a25c1-c145-4f65-9a77-765ae805f9cc	19ca5976-ff4e-410f-bcdf-240e902d6aa8
2390bb88-23d8-469d-8399-764197dda005	c2ce3624-9d13-47fa-98ea-4075b0fb180b
3346375c-ae15-476f-8a16-91310b1cf560	c2ce3624-9d13-47fa-98ea-4075b0fb180b
b8430a61-318a-4536-8a67-e07515882ed2	c3e9b1e5-4363-4d11-b01f-7e6d77e35433
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: keycloak; Owner: bakertech
--

COPY keycloak.web_origins (client_id, value) FROM stdin;
e1ec9699-6a5e-4408-876d-5e6e18b7bd51	+
1fd5503d-5c11-4a2b-a6f4-48bbfadea7a7	+
\.


--
-- PostgreSQL database dump complete
--

