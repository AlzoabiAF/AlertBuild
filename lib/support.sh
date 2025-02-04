usage() {
  echo "Usage: alertbuild [OPTIONS] TG_BOT_TOKEN [SCRIPT...]"
  echo "OPTIONS: "
  echo "    -a | --all         Notify about every build"
  echo "    -e | --error       Notify only if the build fails"
  echo "    -g | --group ID    Telegram group ID to send notifications to"
  echo "    -h | --help        Show command usage information"
  echo "    -o | --output      Print script output (stdout) to the console"
  echo "    -s | --stop        Stop the builds if it fails"
  echo "    -u | --user ID     Telegram user ID to send notifications to"
  echo ""
  echo "You must specify at least one destination using -u (--user), -g (--group), or both."
}



check_arg() {
  if [[ $# -eq 0 ]]; then
    echo -e "\033[31malertbuild: no arguments\033[0m"
    usage
    exit 1
  fi
}

check_number() {
  re='^-?[0-9]+$'
  if ! [[ $1 =~ $re ]]; then
    echo -e "\033[31malertbuild: invalid id\033[0m $1" >&2
    exit 1
  fi
}

execution_time() {
    local start=$1
    local end=$2
    total_seconds=$(echo "$end - $start" | bc)
    minutes=$((total_seconds / 60))
    seconds=$((total_seconds % 60))
    formatTimeExe=$(printf "%02d:%02d\n" $minutes $seconds)
    echo $formatTimeExe
}