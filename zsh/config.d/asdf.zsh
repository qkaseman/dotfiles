[ -d ${ASDF_BIN_HOME} ] && \
    source ${ASDF_BIN_HOME}/asdf.sh && \
    fpath=(${ASDF_BIN_HOME}/completions $fpath)
