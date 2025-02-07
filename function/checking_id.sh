
if [[ -z $token ]]; then
    echo -e "\033[31mThe bot token is missing.\033[0m"
    exit 1
fi

if [[ -z $group_id  && -z $message_id ]]; then
    echo -e "\033[31mYou must specify the destination using one of the options(-u(--user), -g(--group)) or both options.\033[0m"
    exit 1
fi

if ! curl -s "https://api.telegram.org/bot$token/getMe" | grep -q '"ok":true'; then
    echo -e "\033[31mInvalid token.\033[0m"
    exit 1
fi

if [ ! -z "$group_id" ] && ! curl -s "https://api.telegram.org/bot$token/getChat?chat_id=$group_id" | grep -q '"ok":true'; then
    echo -e "\033[31mInvalid chat ID.\033[0m"
    exit 1
fi

if [ ! -z $message_id ] && ! curl -s "https://api.telegram.org/bot$token/getChat?chat_id=$message_id" | grep -q '"ok":true'; then
    echo -e "\033[31mInvalid user ID.\033[0m"
    exit 1
fi

