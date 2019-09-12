#!/bin/bash

# Radiam backup script
#
# Assumes we are running on the swarm master, and that both Postgres and Elasticsearch
# are pinned to the swarm master.
#
# The host directories for backups /var/backups/docker/db and /var/backups/docker/es
# are created in docker host-init tasks.
#
# This also assumes that there will only be one container running whose name
# contains "postgres" and also one whose name contains "elastic".
#

PGCONT=`docker container ls | grep postgres | cut -f 1 -d ' '`
ESCONT=`docker container ls | grep elastic | cut -f 1 -d ' '`


#################
# POSTGRES
#################

# Perform the backup
docker exec $PGCONT pg_dumpall -c -U postgres > /var/backups/docker/db/pgdump_`date +%Y-%m-%d`.sql

# Delete old backups
find /var/backups/docker/db/ -type f -mtime +10 -exec rm -f {} \;


#################
# ELASTICSEARCH
#################

# Only need to run this once, but safe to run it every time to ensure backup snapshot index is created
docker exec $ESCONT curl -XPUT "http://localhost:9200/_snapshot/esbackup" -H "Content-Type: application/json;charset=UTF-8" -d '{"type": "fs","settings": {"location": "/backups"}}'

# Delete old snapshot so that the new snapshot is not incremental
docker exec $ESCONT curl -XDELETE "localhost:9200/_snapshot/esbackup/snapshot_1"

# Tell ES to perform the snapshot, do not wait for completion
docker exec $ESCONT curl -XPUT "localhost:9200/_snapshot/esbackup/snapshot_1" -H "Content-Type: application/json;charset=UTF-8" -d '{"ignore_unavailable": true }'