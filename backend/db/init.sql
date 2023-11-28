create user bakertech_users with encrypted password '5dJQNm=b';
alter user bakertech_users with superuser;

create user bakertech_business with encrypted password '5dJQNm=b';
alter user bakertech_business with superuser;

create sequence if not exists license_id_seq
    increment by 1
    start with 100000000000000
    minvalue 100000000000000
    maxvalue 999999999999999
    no cycle;

create or replace function generate_license_id()
    returns bigint
    language sql
    immutable
as
$$
select nextval('license_id_seq')
$$;

create type public.order_status as enum ('OPEN', 'IN_PROGRESS', 'FOR_SETTLEMENT', 'CLOSED');

alter type public.order_status owner to bakertech;

create type public.device_category as enum ('MECHANICAL', 'ELECTROMECHANICAL');

alter type public.device_category owner to bakertech;

create type public.service_language as enum ('PL', 'EN');

alter type public.service_language owner to bakertech;

create table if not exists public.account
(
    created_by                  bigint
        unique
        constraint fk_account_created_by
            references public.account,
    creation_date_time          timestamp(6)            not null,
    id                          bigserial
        primary key,
    last_modification_by        bigint
        unique
        constraint fk_account_last_modification_by
            references public.account,
    last_modification_date_time timestamp(6),
    version                     bigint,
    username                    varchar(32)             not null
        unique,
    email                       varchar(64)             not null
        unique,
    language_                   public.service_language not null
);

alter table public.account
    owner to bakertech;

create table if not exists public.address
(
    building_number             varchar(6)   not null,
    postal_code                 varchar(6)   not null,
    created_by                  bigint
        unique
        constraint fk_address_created_by
            references public.account,
    creation_date_time          timestamp(6) not null,
    id                          bigserial
        primary key,
    last_modification_by        bigint
        unique
        constraint fk_address_last_modification_by
            references public.account,
    last_modification_date_time timestamp(6),
    version                     bigint,
    city                        varchar(32)  not null,
    street                      varchar(32)  not null
);

alter table public.address
    owner to bakertech;

create table if not exists public.billing_details
(
    created_by                  bigint
        unique
        constraint fk_billing_details_created_by
            references public.account,
    creation_date_time          timestamp(6) not null,
    id                          bigserial
        primary key,
    last_modification_by        bigint
        unique
        constraint fk_billing_details_last_modification_by
            references public.account,
    last_modification_date_time timestamp(6),
    version                     bigint,
    nip                         varchar(10)  not null
        unique,
    regon                       varchar(255) not null
        unique
);

alter table public.billing_details
    owner to bakertech;

create table if not exists public.order_data
(
    duration                    numeric(38, 2) not null,
    total_cost                  numeric(38, 2) not null,
    created_by                  bigint
        unique
        constraint fk_order_data_created_by
            references public.account,
    creation_date_time          timestamp(6)   not null,
    id                          bigserial
        primary key,
    last_modification_by        bigint
        unique
        constraint fk_order_data_last_modification_by
            references public.account,
    last_modification_date_time timestamp(6),
    version                     bigint,
    description                 varchar(2000)
);

alter table public.order_data
    owner to bakertech;

create table if not exists public.device
(
    warranty_ended              boolean default true not null,
    created_by                  bigint
        unique
        constraint fk_device_created_by
            references public.account,
    creation_date_time          timestamp(6)         not null,
    devices                     bigint
        constraint fk_device_order_data
            references public.order_data,
    id                          bigserial
        primary key,
    last_modification_by        bigint
        unique
        constraint fk_device_last_modification_by
            references public.account,
    last_modification_date_time timestamp(6),
    version                     bigint,
    brand                       varchar(100)         not null,
    device_name                 varchar(100)         not null,
    serial_number               varchar(200)         not null
        constraint unique_device_sn
            unique,
    category                    varchar(255)         not null
        constraint device_category_check
            check ((category)::text = ANY
                   ((ARRAY ['MECHANICAL'::character varying, 'ELECTROMECHANICAL'::character varying])::text[])),
    constraint unique_device_bdn
        unique (brand, device_name)
);

alter table public.device
    owner to bakertech;

create table if not exists public.order_queue
(
    created_by                  bigint
        unique
        constraint fk_order_queue_created_by
            references public.account,
    creation_date_time          timestamp(6) not null,
    id                          bigserial
        primary key,
    last_modification_by        bigint
        unique
        constraint fk_order_queue_last_modification_by
            references public.account,
    last_modification_date_time timestamp(6),
    version                     bigint
);

alter table public.order_queue
    owner to bakertech;

create table if not exists public.personal_data
(
    created_by                  bigint
        unique
        constraint fk_personal_data_created_by
            references public.account,
    creation_date_time          timestamp(6) not null,
    id                          bigserial
        primary key,
    last_modification_by        bigint
        unique
        constraint fk_personal_data_last_modification_by
            references public.account,
    last_modification_date_time timestamp(6),
    version                     bigint,
    first_name                  varchar(32)  not null,
    last_name                   varchar(32)  not null,
    phone_number                varchar(255) not null
        unique
);

alter table public.personal_data
    owner to bakertech;

create table if not exists public.access_level
(
    is_active                   varchar default true not null,
    account_id                  bigint               not null
        unique
        constraint fk_access_level_account_id
            references public.account,
    created_by                  bigint
        unique
        constraint fk_access_level_created_by
            references public.account,
    creation_date_time          timestamp(6)         not null,
    id                          bigserial
        primary key,
    last_modification_by        bigint
        unique
        constraint fk_access_level_last_modification_by
            references public.account,
    last_modification_date_time timestamp(6),
    personal_data_id            bigint               not null
        unique
        constraint fk_access_level_personal_data_id
            references public.personal_data,
    version                     bigint,
    access_level_name           varchar(31)          not null,
    constraint access_level_unique_constraint
        unique (account_id, access_level_name)
);

alter table public.access_level
    owner to bakertech;

create index if not exists access_level_account_id
    on public.access_level (account_id);

create index if not exists access_level_personal_data_id
    on public.access_level (personal_data_id);

create table if not exists public.administrator
(
    id bigint not null
        primary key
        constraint fk_administrator_access_level
            references public.access_level
);

alter table public.administrator
    owner to bakertech;

create table if not exists public.client
(
    address_id         bigint      not null
        unique
        constraint fk_client_address_id
            references public.address,
    billing_details_id bigint      not null
        unique
        constraint fk_client_billing_details_id
            references public.billing_details,
    id                 bigint      not null
        primary key
        constraint fk_client_id
            references public.access_level,
    company_name       varchar(64) not null
        unique
);

alter table public.client
    owner to bakertech;

create index if not exists address_id
    on public.client (address_id);

create index if not exists billing_details_id
    on public.client (billing_details_id);

create table if not exists public.report
(
    report_end_date             date         not null,
    report_start_date           date         not null,
    access_level_id             bigint
        constraint fk_report_access_level_id
            references public.access_level (account_id),
    created_by                  bigint
        unique
        constraint fk_report_created_by
            references public.account,
    creation_date_time          timestamp(6) not null,
    id                          bigserial
        primary key,
    last_modification_by        bigint
        unique
        constraint fk_report_last_modification_by
            references public.account,
    last_modification_date_time timestamp(6),
    version                     bigint,
    report_title                varchar(100) not null
);

alter table public.report
    owner to bakertech;

create index if not exists report_access_level_id
    on public.report (access_level_id);

create table if not exists public.report_number_data
(
    report_number_data_value numeric(38, 2),
    report_id                bigint       not null
        constraint fk_report_number_data_report_id
            references public.report,
    report_number_data_key   varchar(255) not null,
    primary key (report_id, report_number_data_key)
);

alter table public.report_number_data
    owner to bakertech;

create table if not exists public.report_text_data
(
    report_id              bigint       not null
        constraint fk_report_text_data_report_id
            references public.report,
    report_text_data_key   varchar(255) not null,
    report_text_data_value varchar(255),
    primary key (report_id, report_text_data_key)
);

alter table public.report_text_data
    owner to bakertech;

create table if not exists public.service_parameters
(
    unit_cost_of_working_hour   numeric(38, 2) not null,
    created_by                  bigint
        unique
        constraint fk_service_parameters_created_by
            references public.account,
    creation_date_time          timestamp(6)   not null,
    cut_off_date_period         bigint         not null,
    id                          bigserial
        primary key,
    last_modification_by        bigint
        unique
        constraint fk_service_parameters_last_modification_by
            references public.account,
    last_modification_date_time timestamp(6),
    version                     bigint
);

alter table public.service_parameters
    owner to bakertech;

create table if not exists public.serviceman
(
    id         bigint                                                    not null
        primary key
        constraint fk_serviceman_access_level_id
            references public.access_level,
    license_id bigint generated always as (generate_license_id()) stored not null
        unique
);

alter table public.serviceman
    owner to bakertech;

create table if not exists public.orders
(
    date_of_order_execution     date                  not null,
    delayed                     boolean default false not null,
    client_id                   bigint                not null
        constraint fk_orders_created_by
            references public.client,
    created_by                  bigint
        unique
        constraint fk_orders_last_modification_by
            references public.account,
    creation_date_time          timestamp(6)          not null,
    id                          bigserial
        primary key,
    last_modification_by        bigint
        unique
        constraint fk_orders_order_queue
            references public.account,
    last_modification_date_time timestamp(6),
    order_data_id               bigint
        unique
        constraint fk_orders_client_id
            references public.order_data,
    orders                      bigint                not null
        constraint fk_orders_order_data_id
            references public.order_queue,
    serviceman_id               bigint
        constraint fk_orders_serviceman_id
            references public.serviceman,
    version                     bigint,
    order_type                  varchar(31)           not null,
    status                      varchar(255)          not null
        constraint orders_status_check
            check ((status)::text = ANY
                   ((ARRAY ['OPEN'::character varying, 'IN_PROGRESS'::character varying, 'FOR_SETTLEMENT'::character varying, 'CLOSED'::character varying])::text[]))
);

alter table public.orders
    owner to bakertech;

create table if not exists public.non_warranty_repair
(
    id bigint not null
        primary key
        constraint fk_non_warranty_repair_orders_id
            references public.orders
);

alter table public.non_warranty_repair
    owner to bakertech;

create index if not exists client_account_id
    on public.orders (client_id);

create index if not exists serviceman_account_id
    on public.orders (serviceman_id);

create index if not exists order_data_id
    on public.orders (order_data_id);

create table if not exists public.warranty_repair
(
    last_date_of_device_service date,
    id                          bigint not null
        primary key
        constraint fk_warranty_repair_orders_id
            references public.orders
);

alter table public.warranty_repair
    owner to bakertech;

create table if not exists public.conservation
(
    date_of_next_device_conversation date,
    id                               bigint not null
        primary key
        constraint fk_conservation_warranty_repair_id
            references public.warranty_repair,
    last_conservation_id             bigint
        unique
        constraint fk_conservation_last_conservation_id
            references public.conservation
);

alter table public.conservation
    owner to bakertech;

insert into account (creation_date_time, id, last_modification_date_time, version, username, email, language_,
                     created_by, last_modification_by)
values ('2023-09-20 19:58:23.111737', 0, null, 0, 'bakertech-admin', 'stary2111@gmail.com', 'EN', null, null);

insert into personal_data (creation_date_time, id, last_modification_date_time, version, first_name, last_name,
                           phone_number, created_by, last_modification_by)
values ('2023-09-20 19:58:23.162640', 0, null, 0, 'bakertech', 'bakertech', '123456789', null, null);

insert into address (building_number, postal_code, creation_date_time, id, last_modification_date_time, version,
                     city, street, created_by, last_modification_by)
values ('5', '00-000', '2023-09-20 19:58:23.166929', 0, null, 0, 'bakertech', 'bakertech', null, null);

insert into billing_details (creation_date_time, id, last_modification_date_time, version, nip, regon, created_by,
                             last_modification_by)
values ('2023-09-20 19:58:23.170216', 0, null, 0, '9999999999', '999999999', null, null);

insert into access_level (is_active, account_id, creation_date_time, id, last_modification_date_time,
                          version, access_level_name, created_by, last_modification_by, personal_data_id)
values ('true', 0, '2023-09-20 19:58:23.162640', 0, null, 0, 'ADMINISTRATOR', null, null, 0);

insert into administrator (id)
values (0);