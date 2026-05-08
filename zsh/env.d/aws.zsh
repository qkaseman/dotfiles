# Make AWS CLI respect XDG spec as much as possible.
#
# XDG placement rationale:
# - CONFIG for config and credentials: AWS requires both in the same
#   directory. Credentials are regenerable via ada, but the config file
#   contains user-edited profile definitions, so CONFIG wins. This
#   follows the Arch wiki convention for AWS CLI.
# - STATE for CLI history: command/action history belongs in STATE per
#   the XDG spec.
# - CACHE for the web identity token: short-lived OIDC token,
#   regenerable. Ideally XDG_RUNTIME_DIR, but that is unreliable on
#   macOS (set to /tmp/$UID, not always present). CACHE is the
#   pragmatic choice — ephemeral and acceptable if deleted.
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/aws/config"
export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/aws/credentials"
export AWS_CLI_HISTORY_FILE="${XDG_STATE_HOME:-$HOME/.local/state}/aws/history"
export AWS_WEB_IDENTITY_TOKEN_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/aws/token"
