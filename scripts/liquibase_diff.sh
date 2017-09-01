#!/bin/bash
: ${CONNECTION_STRING? "please provide the connection string of the base database"}
: ${DB_USER?"Please provide the database user name"}
: ${DB_PASS?"Please provide the database password"}
: ${APPUSER_PASSWORD?"Please enter the password for the app user"}
: ${CHANGELOG_FILE:="changelog_diff.xml"}

TS=$(date +%s)
echo "Generating diff ...."
liquibase --changeLogFile="/changelogs/diff/$TS-$CHANGELOG_FILE" diffChangeLog \
  --referenceUrl=$CONNECTION_STRING \
  --referenceUsername=$DB_USER \
  --referencePassword=$DB_PASS \
  -Dappuser_password="$APPUSER_PASSWORD"

echo "Diff generated into: /changelogs/diff/$TS-$CHANGELOG_FILE"

if [ ! -z "$LIQUIBASE_INCLUSION_FILE" ] ; then
  if [ -f "/changelogs/$LIQUIBASE_INCLUSION_FILE" ] ; then
    echo "Include newly generated file into the list of changesets";
    sed -i "
      /<\/databaseChangeLog>/ i\
      <include relativeToChangelogFile='true' file=\"/diff/$TS-$CHANGELOG_FILE\" />" "/changelogs/$LIQUIBASE_INCLUSION_FILE"
  else
    echo "Liquibase include file doesn't exist: /changelogs/$LIQUIBASE_INCLUSION_FILE"
  fi
else
    echo "Inclusion file not provided."
fi
