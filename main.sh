#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OPTIONS="h,u:,g:,a"
LONG_OPTIONS="help,group:,user:,all"
message_id=""
group_id=""
token=""
all_flag=false
err_flag=false
stop_flag=false
output_flag=false
MESSAGE_ALL="▶️ The alertBuild Report:\n\n"
MESSAGE=""


source $SCRIPT_DIR/lib/support.sh

source $SCRIPT_DIR/function/parsing_optins.sh

check_arg $@
token=$1
shift

source $SCRIPT_DIR/function/checking_id.sh

source $SCRIPT_DIR/function/send_message.sh

source $SCRIPT_DIR/function/processing_scripts.sh

send_final_result
