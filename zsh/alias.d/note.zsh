# Easily manage todo lists.
function todo() {
    vi "${NOTE_HOME}/todo${1:+-$1}.md"
}

# Easily manage scratchpad notes.
function scratch() {
    vi "${NOTE_HOME}/scratch${1:+-$1}.md"
}

# Log work done.
#
# Streams all arguments into a date-stamped file for organization. Adds a
# newline after them all.
function log() {
    local timestamp=$(date +%H:%M)
    local date_stamp=$(date +%Y-%m-%d)
    local fname="${WORKLOG_HOME}/${date_stamp}.md"
    local -a msg=()
    local tag=""

    local usage=(
      "$0 [-h|--help]"
      "$0 [-t|--tag] [-f|--filename=<file>] [<message...>]"
    )

    while (( $# )); do
        case $1 in
            -h|--help)
                printf "%s\n" $usage
                return
                ;;
            -t|--tag)
                shift
                tag=${1:+[$1]}
                ;;
            -f|--filename)
                shift
                fname=$1
                ;;
            --)
                shift
                msg+=("${@[@]}")
                break
                ;;
            -*)
                echo >&2 "Unknown option $1"
                return 2
                ;;
            *)
                msg+=("$1")
                ;;
        esac
        shift
    done

    (( ${#msg} )) || { echo "No message provided" && return 3 }

    if [[ ! -f "${fname}" ]]; then
        touch "${fname}"
        printf '# %s\n\n' "${date_stamp}" >> "${fname}"
    fi
    printf '[%s]%s %s\n\n' "${timestamp}" "${tag}" "${(j: :)msg}" >> "${fname}"
}

# Could store the `date ...` string in a variable and `eval` it, but not sure
# that's the best idea plus I believe the variable would pollute the general
# variable closure which isn't great either.
function worklog-open() {
    vi "${WORKLOG_HOME}/$(date +%Y-%m-%d).md"
}
