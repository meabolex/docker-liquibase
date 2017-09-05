#!/bin/bash
: ${APPUSER_PASSWORD?"Please enter the password hash for the app user"}
: ${CHANGELOG_FILE:="changelogs.xml"}

echo "Applying changes to the database. Changelog: $CHANGELOG_FILE"
liquibase --changeLogFile="/changelogs/$CHANGELOG_FILE" update -Dappuser_password_hash="$APPUSER_PASSWORD_HASH"
