#!/bin/bash

# to export data for keycloak:
# pg_dump -U bakertech -d bakertech -n keycloak > init_keycloak.sql && pg_dump -U bakertech -d bakertech -n keycloak -a >> init_keycloak.sql
psql -U bakertech -f /init.sql
psql -U bakertech -d bakertech < /init_keycloak.sql