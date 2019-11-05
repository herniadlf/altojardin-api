CREATE ROLE deliveryapi WITH LOGIN PASSWORD 'deliveryapi' CREATEDB;

CREATE DATABASE deliveryapi_development;
CREATE DATABASE deliveryapi_test;

GRANT ALL PRIVILEGES ON DATABASE "deliveryapi_development" to deliveryapi;
GRANT ALL PRIVILEGES ON DATABASE "deliveryapi_test" to deliveryapi;
