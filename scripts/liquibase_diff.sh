#!/bin/bash
: ${CONNECTION_STRING? "please provide the connection string of the base database"}
: ${DB_USER?"Please provide the database user name"}
: ${DB_PASS?"Please provide the database password"}
: ${APPUSER_PASSWORD?"Please enter the password for the app user"}

TS=$(date +%s)
echo "Generating diff ...."
liquibase --changeLogFile="/changelogs/diff/$TS-changelog_diff.xml" diffChangeLog \
  --referenceUrl=$CONNECTION_STRING \
  --referenceUsername=$DB_USER \
  --referencePassword=$DB_PASS \
  -Dappuser_password="$APPUSER_PASSWORD"

echo "Diff generated into: /changelogs/diff/$TS-changelog_diff.xml"

if [ ! -z "$LIQUIBASE_INCLUSION_FILE" ] ; then
  if [ -f "/changelogs/$LIQUIBASE_INCLUSION_FILE" ] ; then
    echo "Include newly generated file into the list of changesets";
    sed -i "
      /<\/databaseChangeLog>/ i\
      <include relativeToChangelogFile='true' file=\"/diff/$TS-changelog_diff.xml\" />" "/changelogs/$LIQUIBASE_INCLUSION_FILE"
  else
    echo "Liquibase include file doesn't exist: /changelogs/$LIQUIBASE_INCLUSION_FILE"
  fi
else
    echo "Inclusion file not provided."
fi
