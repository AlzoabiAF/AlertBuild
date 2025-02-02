#!/bin/bash

# value
SCRIPT_DIR=$(dirname $(realpath "$BASH_SOURCE"))
OPTIONS="h,u:,g:"
LONG_OPTIONS="help,group:,user:"
id_user=""
id_group=""
id_tg_bot=""

# functions
usage() {
  echo "Usage: alertbuild [OPTIONS] ID_TG_BOT [SCRIPT ...]"
  echo "    -h | --help"
  echo "    -u | --user ID "
  echo "    -g | --group ID "
}

check_arg() {
  if [[ $# -eq 0 ]]; then
    echo "no arguments"
    exit 1
  fi
}

check_number() {
  re='^[0-9]+$'
  if ! [[ $1 =~ $re ]]; then
    echo "not a number: $1" >&2
    exit 1
  fi
}

# processing options
. $SCRIPT_DIR/getopts_long.sh

OPTLIND=1
while getopts_long :u:g:h opt \
  long 0 \
  user required_argument \
  group required_argument \
  help no_argument "" "$@"; do
  case "$opt" in
  u | user)
    check_number "$OPTLARG"
    id_user=$OPTLARG
    ;;
  g | group)
    check_number "$OPTLARG"
    id_group=$OPTLARG
    ;;
  h | help)
    usage
    exit 0
    ;;
  :)
    printf >&2 '%s: %s\n' "${0##*/}" "$OPTLERR"
    usage
    exit 1
    ;;
  esac
done
shift "$(($OPTLIND - 1))"

# checking id for a number
check_number $1
id_tg_bot=$1
shift

# proccessing scripts
check_arg
