# Easily manage todo lists.
function todo {
    vi ${NOTE_HOME}/todo${1:+-$1}.md
}

# Easily manage scratchpad notes.
function scratch {
    vi ${NOTE_HOME}/scratch${1:+-$1}.md
}

# Log work done.
#
# Streams all arguments into a date-stamped file for organization. Adds a
# newline after them all.
function log {
    local timestamp=$(date +%H:%M)
    local date_stamp=$(date +%Y-%m-%d)
    local fname="${WORKLOG_HOME}/${date_stamp}.md"
    if [ ! -f ${fname} ]; then
        touch ${fname}
        printf "# ${date_stamp}\n\n" >> ${fname}
    fi
    printf '%s: %s\n\n' ${timestamp} "$*" >> ${fname}
}

# Could store the `date ...` string in a variable and `eval` it, but not sure
# that's the best idea plus I believe the variable would pollute the general
# variable closure which isn't great either.
alias worklog-open="vi ${WORKLOG_HOME}/$(date +%Y-%m-%d).md"
