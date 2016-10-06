#!/bin/bash

usage='Usage: bash stable-to-master.sh <client_directory>'
if [ $# -lt 1 ]; then
  printf "$0: not enough arguments\n%s\n" "$usage" >&2
  exit 2
fi

CLIENT_DIR=$1

ansible-playbook -vvvv scripts/ansible-playbook-branch-management-bokeh.yml --extra-vars "{'directory':'$CLIENT_DIR','branch_command':'stable-to-master.sh'}"
