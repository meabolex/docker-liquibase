#!/bin/bash
echo "Setting up liquibase"

cat <<CONF > /liquibase.properties
  driver: org.mariadb.jdbc.Driver
  classpath:/usr/local/bin/mariadb-java-client-2.1.0.jar
  url: jdbc:mariadb://$DB_IP:3306/$DB_NAME
  username: $DB_USER
  password: $DB_PASS
CONF