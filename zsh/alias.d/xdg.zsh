# Easy navigation to XDG directories.

# Config.
function xcfg() {
    cd ${XDG_CONFIG_HOME:-$HOME/.config}/${1}
}

# Local Config.
function xcfgl() {
    cd ${XDG_CONFIG_LOCAL_HOME}/${1}
}

# Runtime.
function xrun() {
    cd ${XDG_RUNTIME_DIR}/${1}
}

# Data.
function xdata() {
    cd ${XDG_DATA_HOME:-$HOME/.local/share}/${1}
}

# State.
function xstate() {
    cd ${XDG_STATE_HOME:-$HOME/.local/state}/${1}
}

# Binaries.
function xbin() {
    cd ${XDG_BIN_HOME:-$HOME/.local/bin}/${1}
}

# Cache.
function xcache() {
    cd ${XDG_CACHE_HOME:-$HOME/.cache}/${1}
}
