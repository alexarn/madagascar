#!/bin/bash

usage='Usage: bash install-branch.sh <git_branch_name> <client_directory>'
if [ $# -lt 2 ]; then
  printf "$0: not enough arguments\n%s\n" "$usage" >&2
  exit 2
fi

BRANCH=$1
CLIENT_DIR=$2

ansible-playbook -vvvv scripts/ansible-playbook-install-branch-bokeh.yml --extra-vars "branch=$BRANCH directory=$CLIENT_DIR"
