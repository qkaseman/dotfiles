alias ls='ls -G'

# Annoyingly, MacOS has defaults for some environment variables in
# `/etc/zshrc`, which is sourced after `$ZDOTDIR/zshenv`, which means the
# definitions in `/etc/zshrc` take precedence.
#
# So we have to define/source them here again :(
source ${ZDOTDIR}/env.d/**/*history.zsh

# MacOS also doesn't create all of the XDG directories, so let's make sure
# they all exist.
XDG_DIRS=(
    ${XDG_RUNTIME_DIR}
    ${XDG_DATA_HOME}
    ${XDG_CONFIG_HOME}
    ${XDG_STATE_HOME}
    ${XDG_BIN_HOME}
    ${XDG_CACHE_HOME}
    ${XDG_CONFIG_LOCAL_HOME}
)
for xdg_dir in "${XDG_DIRS[@]}"; do
    [[ -d ${xdg_dir} ]] || mkdir -p ${xdg_dir}
done
