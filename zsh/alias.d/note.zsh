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
# Streams all arguments into a date-stamped file for organization. Adds a newline after them all.
function log {
    local date_stamp=$(date +%Y-%m-%d)
    local fname="${WORKLOG_HOME}/${date_stamp}.md"
    if [ ! -f ${fname} ]; then
        touch ${fname}
        printf "# ${date_stamp}\n\n" >> ${fname}
    fi
    printf '%s\n\n' "$*" >> ${fname}
}

