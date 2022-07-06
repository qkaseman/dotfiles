# Open current node version documentation.
#
# Name is a squash of `node-man` --> `nman` but `n` and `m` are annoyingly
# close together and a bit hard to type quickly when you have to go back to the
# `n`.
function nan {
  local section=${1:-all}
  open_command "https://nodejs.org/docs/$(node --version)/api/$section.html"
}
