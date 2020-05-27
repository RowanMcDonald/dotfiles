export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.nimble/bin:$PATH"

# If we set this after bashrc is sourced, it clobbers both direnv + z
export PROMPT_COMMAND='history -a'

[ -f ~/.bashrc ] && source ~/.bashrc
