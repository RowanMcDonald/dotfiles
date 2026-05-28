# # Generate a profile
# [ -f /tmp/bash_profile_profile.log ] && rm /tmp/bash_profile_profile.log
# PS4='+ $(gdate "+%s.%N")\011 '
# exec 3>&2 2>/tmp/bash_profile_profile.log
# set -x

# Initialize Homebrew (handles Apple Silicon /opt/homebrew and Intel /usr/local)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

export PATH="$HOME/.bin:$PATH"

# If we set this after bashrc is sourced, it clobbers both direnv + z
export PROMPT_COMMAND='history -a'

[ -f ~/.bashrc ] && source ~/.bashrc

# set +x
# exec 2>&3 3>&-

function _rake_cache_path() {
  # If in a Rails app, put the cache in the cache dir
  # so version control ignores it
  if [ -e 'tmp/cache' ]; then
    prefix='tmp/cache/'
  fi
  echo "${prefix}.rake_t_cache"
}

function rake_cache_store() {
  rake --tasks --silent > "$(_rake_cache_path)"
}

function rake_cache_clear() {
  rm -f .rake_t_cache
  rm -f tmp/cache/.rake_t_cache
}

export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}

function _rakecomplete() {
  # error if no Rakefile
  if [ ! -e Rakefile ]; then
    echo "missing Rakefile"
    return 1
  fi

  # build cache if missing
  if [ ! -e "$(_rake_cache_path)" ]; then
    rake_cache_store
  fi

  local tasks=`awk '{print $2}' "$(_rake_cache_path)"`
  COMPREPLY=($(compgen -W "${tasks}" -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}

complete -o default -o nospace -F _rakecomplete rake

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
