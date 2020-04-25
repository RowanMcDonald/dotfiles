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

[ -f ~/.bashrc ] && source ~/.bashrc
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
eval "$(rbenv init -)"


export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.nimble/bin:$PATH"
