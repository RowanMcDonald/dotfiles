export PATH="$HOME/.bin:$HOME/.rbenv/bin:$PATH"
export PATH=$PATH:~/.local/bin
export PATH="/usr/local/sbin:$PATH"

export EDITOR=/usr/local/bin/nvim
export VISUAL='nvim'
export INPUTRC="$HOME/.inputrc"
eval "$(rbenv init -)"

[ -f ~/.bashrc ] && source ~/.bashrc
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export NODE_EXTRA_CA_CERTS=/usr/local/etc/openssl/cert.pem

export RIPGREP_CONFIG_PATH=~/.rgrc
