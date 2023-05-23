# Easy navigation to XDG directories.

# Config.
function xcfg() {
    cd ${XDG_CONFIG_HOME}/${1}
}
function xcfgl() {
    cd ${XDG_CONFIG_LOCAL_HOME}/${1}
}

# Runtime.
function xrun() {
    cd ${XDG_RUNTIME_DIR}/${1}
}

# Data.
function xdata() {
    cd ${XDG_DATA_HOME}/${1}
}

# State.
function xstate() {
    cd ${XDG_STATE_HOME}/${1}
}

# Binaries.
function xbin() {
    cd ${XDG_BIN_HOME}/${1}
}

# Cache.
function xcache() {
    cd ${XDG_CACHE_HOME}/${1}
}
