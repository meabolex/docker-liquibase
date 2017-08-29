#!/bin/bash
: ${APPUSER_PASSWORD?"Please enter the password for the app user"}
: ${CHANGELOG_FILE:="changelogs.xml"}

echo "Applying changes to the database. Changelog: $CHANGELOG_FILE"
liquibase --changeLogFile="$CHANGELOG_FILE" update -Dappuser_password="$APPUSER_PASSWORD"
