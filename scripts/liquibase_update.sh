#!/bin/bash
: ${APPUSER_PASSWORD_HASH?"Please enter the password hash for the app user"}
: ${APPUSER_NAME?"Please enter the user name for the app user"}
: ${CHANGELOG_FILE:="changelogs.xml"}
: ${DB_NAME?"Please enter the database name"}

echo "Applying changes to the database. Changelog: $CHANGELOG_FILE"
liquibase --logLevel=debug --changeLogFile="/changelogs/$CHANGELOG_FILE" update -Dappuser_password_hash="$APPUSER_PASSWORD_HASH" -Dappuser_username="$APPUSER_NAME" -Ddb_name="$DB_NAME"
