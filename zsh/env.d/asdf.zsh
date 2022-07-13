# Make `asdf` follow XDG spec.
export ASDF_DATA_DIR=${XDG_DATA_HOME}/asdf
export ASDF_CONFIG_FILE=${XDG_CONFIG_HOME}/asdf/asdfrc
export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME=${ASDF_DATA_DIR}/tool-versions
export ASDF_NPM_DEFAULT_PACKAGES_FILE=${ASDF_DATA_DIR}/npm/default-packages

export ASDF_BIN_HOME=${XDG_BIN_HOME}/asdf
