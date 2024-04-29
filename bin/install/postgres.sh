#!/bin/bash
# set -x
set -e

# postgres
apt install postgresql postgresql-contrib
# vi /etc/postgresql/12/main/postgresql.conf
# listen_addresses = '*'
# vi /etc/postgresql/12/main/pg_hba.conf
# host    all             all             0.0.0.0/0            md5
# sudo -u postgres psql #sudo -i -u postgres
# ALTER USER postgres with password 'tinyverse';
# \q
# vi /etc/postgresql/12/main/pg_hba.conf
# local   all             postgres                             password
# sudo systemctl restart postgresql.service
# psql -h 192.168.1.102 -U postgres -W
# vi /etc/postgresql/12/main/postgresql.conf
# data_directory = '/data/postgresql/12/main'
# sudo chown -R postgres:postgres /data/postgresql/
# sudo chmod -R 0750 /data/postgresql/
# systemctl restart postgresql



