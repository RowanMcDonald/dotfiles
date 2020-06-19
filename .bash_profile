# # Generate a profile
# [ -f /tmp/bash_profile_profile.log ] && rm /tmp/bash_profile_profile.log
# PS4='+ $(gdate "+%s.%N")\011 '
# exec 3>&2 2>/tmp/bash_profile_profile.log
# set -x

export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
# export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
# export PATH="$HOME/.nimble/bin:$PATH"

# If we set this after bashrc is sourced, it clobbers both direnv + z
export PROMPT_COMMAND='history -a'

[ -f ~/.bashrc ] && source ~/.bashrc

# set +x
# exec 2>&3 3>&-
