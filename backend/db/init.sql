create user bakertech_users with encrypted password '5dJQNm=b';
alter user bakertech_users with superuser;

create user bakertech_business with encrypted password '5dJQNm=b';
alter user bakertech_business with superuser;

create schema if not exists keycloak;

alter schema keycloak owner to bakertech;

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

create table if not exists public.account
(
    created_by                  bigint
        unique
        constraint fkatwoepbie7ousm3au0cp7hira
            references public.account,
    creation_date_time          timestamp(6)                            not null,
    id                          bigserial
        primary key,
    last_modification_by        bigint
        unique
        constraint fkmbrbov8bxa9aqnox59m0rafd5
            references public.account,
    last_modification_date_time timestamp(6),
    version                     bigint,
    username                    varchar(32)                             not null
        unique,
    email                       varchar(64)                             not null
        unique,
    language_                   varchar default 'EN'::character varying not null
);

alter table public.account
    owner to bakertech;

create table if not exists public.address
(
    building_number             varchar(6)   not null,
    postal_code                 varchar(6)   not null,
    created_by                  bigint
        unique
        constraint fksgrw3por9aufp2t5xeml8ohvb
            references public.account,
    creation_date_time          timestamp(6) not null,
    id                          bigserial
        primary key,
    last_modification_by        bigint
        unique
        constraint fkp0ui5p26femnw2qg1g9cdi3yg
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
        constraint fkfxg6t11gc5jx6njb0hs0vslcv
            references public.account,
    creation_date_time          timestamp(6) not null,
    id                          bigserial
        primary key,
    last_modification_by        bigint
        unique
        constraint fkqq0hra6ewvhg6q3edndw71y1l
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

create table if not exists public.personal_data
(
    created_by                  bigint
        unique
        constraint fks470wl5u72uwblooefohytyov
            references public.account,
    creation_date_time          timestamp(6) not null,
    id                          bigserial
        primary key,
    last_modification_by        bigint
        unique
        constraint fk847j9o210fvkmp02j6f780lp
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
        constraint fkl6ljrvl5w8nhxvrrqt0pu4uou
            references public.account,
    created_by                  bigint
        unique
        constraint fkof8x67v6rlo4uqhjr3k1csaoo
            references public.account,
    creation_date_time          timestamp(6)         not null,
    id                          bigserial
        primary key,
    last_modification_by        bigint
        unique
        constraint fkar3mjn7retpq2i18ask7buhev
            references public.account,
    last_modification_date_time timestamp(6),
    personal_data               bigint               not null
        unique
        constraint fkp1j8y2xi53hj8awma0x6k2aue
            references public.personal_data,
    version                     bigint,
    access_level_name           varchar(31)          not null,
    constraint access_level_unique_constraint
        unique (account_id, access_level_name)
);

alter table public.access_level
    owner to bakertech;

create index access_level_account_id
    on public.access_level (account_id);

create table if not exists public.administrator
(
    id bigint not null
        primary key
        constraint fkmsnxouqpp6d2x12i9gal38n1p
            references public.access_level
);

alter table public.administrator
    owner to bakertech;

create table if not exists public.client
(
    address_id         bigint      not null
        unique
        constraint fkb137u2cl2ec0otae32lk5pcl2
            references public.address,
    billing_details_id bigint      not null
        unique
        constraint fkldq1vxowdqqrpmpdj1g2lkbws
            references public.billing_details,
    id                 bigint      not null
        primary key
        constraint fkex05cqwnf2x5bajsnjw3blyvl
            references public.access_level,
    client_name        varchar(64) not null
        unique
);

alter table public.client
    owner to bakertech;

create index address_id
    on public.client (address_id);

create index billing_details_id
    on public.client (billing_details_id);

create table if not exists public.manager
(
    id bigint not null
        primary key
        constraint fkgis57tqf52pk3femfmq7p3hg
            references public.access_level
);

alter table public.manager
    owner to bakertech;

create table if not exists public.serviceman
(
    id         bigint                                                    not null
        primary key
        constraint fk6ing2375tei2kgwyp5kqmwwue
            references public.access_level,
    license_id bigint generated always as (generate_license_id()) stored not null
        unique
);

alter table public.serviceman
    owner to bakertech;

insert into account (creation_date_time, id, last_modification_date_time, version, username, email, language_, created_by, last_modification_by)
values ('2023-09-20 19:58:23.111737', 0, null, 0, 'bakertech-admin', 'stary2111@gmail.com', 'EN', null, null);

insert into personal_data (creation_date_time, id, last_modification_date_time, version, first_name, last_name,
                           phone_number, created_by, last_modification_by)
values ('2023-09-20 19:58:23.162640', 0, null, 0, 'bakertech', 'bakertech', '123456789', null, null);

insert into address (building_number, postal_code, creation_date_time, id, last_modification_date_time, version,
                     city, street, created_by, last_modification_by)
values ('5', '00-000', '2023-09-20 19:58:23.166929', 0, null, 0, 'bakertech', 'bakertech', null, null);

insert into billing_details (creation_date_time, id, last_modification_date_time, version, nip, regon, created_by, last_modification_by)
values ('2023-09-20 19:58:23.170216', 0, null, 0, '9999999999', '999999999', null, null);

insert into access_level (is_active, account_id, creation_date_time, id, last_modification_date_time,
                          personal_data, version, access_level_name, created_by, last_modification_by)
values ('true', 0, '2023-09-20 19:58:23.162640', 0, null, 0, 0, 'ADMINISTRATOR', null, null);

insert into administrator (id)
values (0);