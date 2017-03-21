#!/bin/bash

usage='Usage: bash install-branch.sh <git_branch_name> <client_directory>
ex: bash scripts/install-branch.sh hotline#47207_message_ressources_numeriques_cvs htdocs-mutu/le-gresivaudan.fr
'
if [ $# -lt 2 ]; then
  printf "$0: not enough arguments\n%s\n" "$usage" >&2
  exit 2
fi

BRANCH=$1
CLIENT_DIR=$2

ansible-playbook -vvvv scripts/ansible-playbook-branch-management-bokeh.yml --extra-vars "directory='$CLIENT_DIR' branch_command='install-branch.sh $BRANCH'"
