# https://medium.com/@Navmed/setting-up-replication-in-postgresql-with-pglogical-8212e77ebc1b
# https://www.2ndquadrant.com/en/resources-old/pglogical/pglogical-docs/#nodes-postgresql-database-instances

both:
sudo apt-get install postgresql-12-pglogical
vi /etc/postgresql/12/main/postgresql.conf
# wal_level = logical
# max_worker_processes = 10 # one per database needed on provider node
# max_replication_slots = 10 # one per node needed on provider node
# max_wal_senders = 10 # one per node needed on provider node
# shared_preload_libraries = pglogical
# track_commit_timestamp = on
# pglogical.conflict_resolution = 'last_update_wins'
sudo systemctl restart postgresql.service
psql -U postgres
\c ord2_mainnet
CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;
CREATE EXTENSION pglogical;

srcInstance:

psql -U postgres
\c ord2_mainnet
select pglogical.create_node(node_name := 'provider2', dsn := 'host=192.168.1.101 port=5432 dbname=ord2_mainnet user=postgres password=tinyverse');
SELECT pglogical.replication_set_add_all_tables('default', ARRAY['public']);
grant usage on schema pglogical to postgres;
# drop
SELECT pglogical.drop_node('provider1');

destInstance:
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