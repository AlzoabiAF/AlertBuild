send_message() {
    local MESSAGE=$(echo -e $1)
    if [[ ! -z group_id ]]; then
        curl -s -X POST https://api.telegram.org/bot$token/sendMessage -d chat_id=$group_id -d text="$MESSAGE" > /dev/null
    fi
    if [[ ! -z message_id ]]; then
        curl -s -X POST https://api.telegram.org/bot$token/sendMessage -d chat_id=$message_id   -d text="$MESSAGE" > /dev/null
    fi
}

send_final_result() {
    END_ALL=$(date +%s)
    duration=$(execution_time $START_ALL $END_ALL)
    MESSAGE="❗️ Total execution time: $duration ❗️\n"
    echo -e "\033[32m$MESSAGE\033[0m"
    MESSAGE_ALL+="$MESSAGE"
    send_message "$MESSAGE_ALL"
}