#!/bin/bash

# to export data for keycloak:
# pg_dump -U bakertech -d bakertech -n keycloak > /home/init_keycloak.sql && pg_dump -U bakertech -d bakertech -n keycloak -a >> /home/init_keycloak.sql
psql -U bakertech -f /home/init.sql
psql -U bakertech -d bakertech < /home/init_keycloak.sql