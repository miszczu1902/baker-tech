#!/bin/bash

# to export data for keycloak:
# pg_dump -U bakertech -d bakertech -n keycloak > /home/db/init_keycloak.sql && pg_dump -U bakertech -d bakertech -n keycloak -a >> /home/db/init_keycloak.sql
psql -U bakertech -f /home/db/init.sql
psql -U bakertech -d bakertech < /home/db/init_keycloak.sql