ASDF_DIR=${XDG_BIN_HOME}/asdf
[ -d ${ASDF_DIR} ] && \
    source ${ASDF_DIR}/asdf.sh && \
    fpath=(${ASDF_DIR}/completions $fpath)
