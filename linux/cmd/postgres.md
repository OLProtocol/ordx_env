

## database synchronize

# https://medium.com/@Navmed/setting-up-replication-in-postgresql-with-pglogical-8212e77ebc1b
# https://www.2ndquadrant.com/en/resources-old/pglogical/pglogical-docs/#nodes-postgresql-database-instances
```shell
sudo apt-get install postgresql-12-pglogical
vi /etc/postgresql/12/main/postgresql.conf
sudo systemctl restart postgresql.service
psql -U postgres
\c ord2_mainnet
CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;
CREATE EXTENSION pglogical;

# srcInstance:

psql -U postgres
\c ord2_mainnet
select pglogical.create_node(node_name := 'provider2', dsn := 'host=192.168.1.101 port=5432 dbname=ord2_mainnet user=postgres password=tinyverse');
SELECT pglogical.replication_set_add_all_tables('default', ARRAY['public']);
grant usage on schema pglogical to postgres;
# drop
SELECT pglogical.drop_node('provider1');

# destInstance:
psql -U postgres
\c ord2_mainnet
SELECT pglogical.create_node( node_name := 'subscriber2', dsn := 'host=103.103.245.177 port=5432 dbname=ord2_mainnet user=postgres password=tinyverse');
SELECT pglogical.create_subscription(subscription_name := 'subscription2', provider_dsn := 'host=127.0.0.1 port=5433 dbname=ord2_mainnet user=postgres password=tinyverse');
# checkout
select subscription_name, status FROM pglogical.show_subscription_status();
SELECT pglogical.wait_for_subscription_sync_complete('subscription2');
# drop
SELECT pglogical.drop_subscription('subscription2');
SELECT pglogical.drop_node('subscriber1');

```

## install postgresql in macos
```shell
brew install postgrest
```

## remove postgresql10 in ubuntu18
## https://www.commandprompt.com/education/how-to-uninstall-postgresql-from-ubuntu/
```shell
sudo apt remove postgresql postgresql-contrib
sudo apt autoremove
dpkg -l |grep postgres
sudo apt-get –purge remove postgresql postgresql-10 postgresql-client-common postgresql-common postgresql-contrib
dpkg -l | grep postgres
```

## install postgresql10 in ubuntu18

```shell
sudo apt update
sudo apt install postgresql postgresql-contrib
sudo systemctl start postgresql.service
sudo systemctl status "postgresql*"
vi /etc/postgresql/12/main/postgresql.conf
listen_addresses = '*'
vi /etc/postgresql/12/main/pg_hba.conf
host    all             all             0.0.0.0/0            md5
sudo -u postgres psql #sudo -i -u postgres
ALTER USER postgres with password 'tinyverse';
\q
vi /etc/postgresql/12/main/pg_hba.conf
local   all             postgres                             password
sudo systemctl restart postgresql.service
psql -h 192.168.1.102 -U postgres -W

vi /etc/postgresql/12/main/postgresql.conf
data_directory = '/data/postgresql/12/main'
sudo chown -R postgres:postgres /data/postgresql/
sudo chmod -R 0750 /data/postgresql/
systemctl restart postgresql

# query db size
SELECT pg_database.datname AS database_name, pg_size_pretty(pg_database_size(pg_database.datname)) AS database_size FROM pg_database;
# backup and restore
pg_dump -U postgres -d ord2_mainnet -f ./sql/ord2_mainnet.sql --create
pg_dump -U postgres -d ord2_testnet -f ./sql/ord2_testnet.sql --create
pg_dump -U postgres -d postgres_metaprotocol_main -f ./sql/postgres_metaprotocol_main.sql --create
pg_dump -U postgres -d postgres_metaprotocol_testnet -f ./sql/postgres_metaprotocol_testnet.sql --create
rsync -avvv --checksum --update root@192.168.1.106:/root/sql ./
psql -U postgres -c "CREATE DATABASE ord2_mainnet WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8'"
psql -U postgres -d ord2_mainnet -f ./sql/ord2_mainnet.sql -W
psql -U postgres -c "CREATE DATABASE ord2_testnet WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8'"
psql -U postgres -d ord2_testnet -f ./sql/ord2_testnet.sql -W
psql -U postgres -c "CREATE DATABASE postgres_metaprotocol_main WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8'"
psql -U postgres -d postgres_metaprotocol_main -f ./sql/postgres_metaprotocol_main.sql
psql -U postgres -c "CREATE DATABASE postgres_metaprotocol_testnet WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8'"
psql -U postgres -d postgres_metaprotocol_testnet -f ./sql/postgres_metaprotocol_testnet.sql

# mount 200g to /data
mkdir -p /data/postgresql/postgresql1/12/main
cp -r /var/lib/postgresql/12/main to /data/postgresql/postgresql1/12/main
sudo chown -R postgres /data/postgresql
sudo chmod -R 0700 /data/postgresql/postgresql1/
vi /etc/postgresql/12/main/postgresql.conf
# data_directory = '/data/postgresql/postgresql1/12/main'
sudo systemctl restart postgresql.service
# sql
psql -h 192.168.1.101 -d ord2_mainnet -U postgres -c "SELECT * from ord2_event_types;"
```
