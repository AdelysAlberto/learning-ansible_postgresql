#!/bin/bash
TIMESTAMP=$(date +%F-%T)
pg_dump -U postgres {{ db_name }} > {{ mount_point }}/backup_$TIMESTAMP.sql
