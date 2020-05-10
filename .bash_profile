export PATH="$HOME/.bin:$HOME/.rbenv/bin:$PATH"
export PATH=$PATH:~/.local/bin
export PATH="/usr/local/sbin:$PATH"

export EDITOR=/usr/local/bin/nvim
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export VISUAL='nvim'
export INPUTRC="$HOME/.inputrc"
export RIPGREP_CONFIG_PATH=~/.rgrc

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export NODE_EXTRA_CA_CERTS=/usr/local/etc/openssl/cert.pem

#======================
# History
# Unsetting size doesn't work.
#======================
export HISTFILESIZE=1000000
export HISTSIZE=1000000
# Ignore duplicate commands + those starting with a space
export HISTCONTROL=ignoreboth
# Ignore common commands
export HISTIGNORE='ls:bg:fg:history:gl:gs:gcm:cl:vim:v:tldr'
export HISTTIMEFORMAT='%F %T '
# Store history as it is written
# If we set this after bashrc is sourced, it clobbers both direnv + z
export PROMPT_COMMAND='history -a'


export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.nimble/bin:$PATH"

[ -f ~/.bashrc ] && source ~/.bashrc
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
eval "$(rbenv init -)"

