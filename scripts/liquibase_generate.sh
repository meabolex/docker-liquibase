#!/bin/bash
: ${APPUSER_PASSWORD?"Please enter the password for the app user"}

TS=$(date +%s)
echo "Generating changelog ...."
liquibase --diffTypes="$DIFF_TYPES" --defaultSchemaName="$DB_SCHEMA_NAME" --changeLogFile="/changelogs/$TS-changelog_diff.xml" generateChangeLog -Dappuser_password="$APPUSER_PASSWORD"

echo "Changelog generated into: /changelogs/$TS-changelog_diff.xml"
