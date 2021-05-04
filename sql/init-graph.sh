#!/bin/bash
set -e
echo "********  Creating Graph  ********"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE EXTENSION age;
    LOAD 'age';
    SET search_path = ag_catalog, '$user', public;
    SELECT create_graph('my_graph_name');
EOSQL