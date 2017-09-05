#!/bin/bash
: ${APPUSER_PASSWORD_HASH?"Please enter the password hash for the app user"}
: ${CHANGELOG_FILE:="changelog_diff.xml"}

TS=$(date +%s)
echo "Generating changelog ...."
liquibase --diffTypes="$DIFF_TYPES" --defaultSchemaName="$DB_SCHEMA_NAME" --changeLogFile="/changelogs/$TS-$CHANGELOG_FILE" generateChangeLog -Dappuser_password_hash="$APPUSER_PASSWORD_HASH"

echo "Changelog generated into: /changelogs/$TS-$CHANGELOG_FILE"
