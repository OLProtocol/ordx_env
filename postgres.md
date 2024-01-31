# https://medium.com/@Navmed/setting-up-replication-in-postgresql-with-pglogical-8212e77ebc1b
# https://www.2ndquadrant.com/en/resources-old/pglogical/pglogical-docs/#nodes-postgresql-database-instances
# https://www.2ndquadrant.com/en/resources-old/pglogical/pglogical-docs/#nodes-postgresql-database-instances

both:
psql -U postgres
\c ord2_testnet
CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;
CREATE EXTENSION pglogical;

srcInstance:

psql -U postgres
\c ord2_testnet
select pglogical.create_node(node_name := 'provider1', dsn := 'host=192.168.1.101 port=5432 dbname=ord2_testnet user=postgres password=tinyverse');
SELECT pglogical.replication_set_add_all_tables('default', ARRAY['public']);
grant usage on schema pglogical to postgres;
# drop
SELECT pglogical.drop_node('provider1');

destInstance:
psql -U postgres
\c ord2_testnet
SELECT pglogical.create_node( node_name := 'subscriber1', dsn := 'host=192.168.1.102 port=5432 dbname=ord2_testnet user=postgres password=tinyverse');
SELECT pglogical.create_subscription( subscription_name := 'subscription1', provider_dsn := 'host=192.168.1.101 port=5432 dbname=ord2_testnet user=postgres password=tinyverse' );
# checkout
select subscription_name, status FROM pglogical.show_subscription_status();
SELECT pglogical.wait_for_subscription_sync_complete(‘subscription1’);
# drop
SELECT pglogical.drop_subscription('subscription1');
SELECT pglogical.drop_node('subscriber1');