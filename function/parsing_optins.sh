# processing options
. $SCRIPT_DIR/lib/getopts_long.sh

OPTLIND=1
while getopts_long :u:g:haeso opt \
  long 0 \
  user required_argument \
  group required_argument \
  help no_argument \
  all no_argument \
  error no_argument \
  stop no_argument \
  output no_argument "" "$@"; do
  case "$opt" in
  u | user)
    check_number "$OPTLARG"
    message_id=$OPTLARG
    ;;
  g | group)
    check_number "$OPTLARG"
    group_id=$OPTLARG
    ;;
  h | help)
    usage
    exit 0
    ;;
  a | all)
    all_flag=true
    ;;
  e | error)
    err_flag=true
    ;;
  s | stop)
    stop_flag=true
    ;;
  o | output)
    output_flag=true
    ;;
  :)
    printf >&2 '%s: %s\n' "${0##*/}" "$OPTLERR"
    usage
    exit 1
    ;;
  esac
done
shift "$(($OPTLIND - 1))"