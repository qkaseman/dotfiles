# Make AWS CLI respect XDG spec as much as possible.
export AWS_CONFIG_FILE=${XDG_CONFIG_HOME}/aws/config
export AWS_CLI_HISTORY_FILE=${XDG_STATE_HOME}/aws/history
export AWS_WEB_IDENTITY_TOKEN_FILE=${XDG_CACHE_HOME}/aws/token
export AWS_SHARED_CREDENTIALS_FILE=${XDG_CACHE_HOME}/aws/credentials
