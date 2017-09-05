#!/bin/bash
: ${APPUSER_PASSWORD_HASH?"Please enter the password hash for the app user"}
: ${APPUSER_NAME?"Please enter the user name for the app user"}
: ${CHANGELOG_FILE:="changelog_diff.xml"}
: ${DB_NAME?"Please enter the database name"}

TS=$(date +%s)
echo "Generating changelog ...."
liquibase --diffTypes="$DIFF_TYPES" --defaultSchemaName="$DB_SCHEMA_NAME" --changeLogFile="/changelogs/$TS-$CHANGELOG_FILE" generateChangeLog -Dappuser_password_hash="$APPUSER_PASSWORD_HASH" -Dappuser_username="$APPUSER_NAME" -Ddb_name="$DB_NAME"

echo "Changelog generated into: /changelogs/$TS-$CHANGELOG_FILE"
