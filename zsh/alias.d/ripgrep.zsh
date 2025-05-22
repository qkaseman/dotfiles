# Quick filename search.
#
# @param 1 - regex to search for
# @param 2 - directory pattern to search in
function rgf() {
  if [ -z "$2" ]; then
    rg --files | rg "${1}"
  else
    rg --files "${2}" | rg "${1}"
  fi
}
