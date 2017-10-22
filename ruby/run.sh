#!/bin/sh

export ISUBATA_DB_HOST=127.0.0.1
export ISUBATA_DB_USER=isucon
export ISUBATA_DB_PASSWORD=isucon

bundle exec puma -p 5000 -t 10
