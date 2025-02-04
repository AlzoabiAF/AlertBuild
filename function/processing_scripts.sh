check_arg $@

START_ALL=$(date +%s)
while [[ $# -ne 0 ]]; do
	script=$1
	args=($1)
	err=""
	if [[ ${#args[@]} -eq 0 ]]; then
		err="no arguments"
		MESSAGE="empty script: Fail ❌\nError: $err\n\n"
		echo -e "\033[31malertbuild: $MESSAGE\033[0m"
		MESSAGE_ALL+="$MESSAGE\n"
		shift
		continue
	fi
	rm /tmp/errAlertBuild 2>/dev/null
	touch /tmp/errAlertBuild
	start=$(date +%s)
	if [[ $output_flag == true ]]; then
		eval "$script" > >(tee -a /dev/null) 2> >(tee -a /tmp/errAlertBuild >&2)
		status_code=$?
	else
		eval "$script" >/dev/null 2> >(tee -a /tmp/errAlertBuild >&2)
		status_code=$?
	fi
	end=$(date +%s)
	duration=$(execution_time $start $end)
	
	if [[ $status_code -ne 0 ]]; then
		err=$(cat /tmp/errAlertBuild | tail -n 5)
	fi
	rm /tmp/errAlertBuild 2>/dev/null

	if [[ $err == "" ]]; then
		MESSAGE="$script: Success ✅\nScript execution time: $duration\n"
		if [[ $all_flag == true ]]; then
			send_message "$MESSAGE"
		fi
		echo -e "\033[32m$MESSAGE\033[0m"
	else
		MESSAGE="$script: Fail ❌\nError: $err\nScript execution time: $duration\n"
		if [[ $all_flag == true || $err_flag == true ]]; then
			send_message "$MESSAGE"
		fi
		echo -e "\033[31m$MESSAGE\033[0m"
	fi

	MESSAGE_ALL+="$MESSAGE\n"

	if [[ $stop_flag == true && $err != "" ]]; then
		send_final_result

		MESSAGE_STOP="❗️❗️❗️ The script ended with an error"
		send_message "$MESSAGE_STOP"
		echo -e "\033[31m$MESSAGE_STOP\033[0m"
		exit 1
	fi
	shift
done
