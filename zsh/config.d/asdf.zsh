# asdf is dumb and only allows `${HOME}/<filename>` level
# of customization so symlink to pseudo-make compliant. See:
# https://github.com/asdf-vm/asdf/blob/49e541a29ff7a2f35917a4544a8b9adbc02bb1b4/lib/functions/versions.bash#L23
[ ! -f ${ASDF_GLOBAL_TOOL_VERSIONS} ] && \
    touch ${ASDF_GLOBAL_TOOL_VERSIONS}
[ ! -f ${ASDF_TOOL_VERSIONS_LINK} ] && \
    ln -s ${ASDF_GLOBAL_TOOL_VERSIONS} ${ASDF_TOOL_VERSIONS_LINK}

[ -d ${ASDF_BIN_HOME} ] && \
    source ${ASDF_BIN_HOME}/asdf.sh && \
    fpath+=(${ASDF_BIN_HOME}/completions)
