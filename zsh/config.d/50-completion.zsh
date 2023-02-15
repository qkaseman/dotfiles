unsetopt menucomplete       # Do not autoselect first completion entry.
setopt automenu             # Show completion on successive tab press.
setopt completeinword       # Allow completion from within word/phrase.
setopt alwaystoend          # Move cursor to end of word.
setopt autolist             # Immediately list ambiguous completion choices.
setopt autoremoveslash      # Remove slash from completion if redundant.
setopt autonamedirs         # Parameter that is absolute name of dir becomes a
                            # name for that dir.


# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' cache-path ${ZSH_CACHE_HOME}/zcompcache

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' squeeze-slashes true

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
cdpath=(.)

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs '_*'

# ... unless we really want to.
zstyle '*' single-ignored show

autoload -Uz compinit
compinit -u -i -d "${ZSH_CACHE_HOME}/zcompdump-${ZSH_VERSION}"
