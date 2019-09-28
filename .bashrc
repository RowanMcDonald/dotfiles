#===================
# Config alias
#===================
alias config='/usr/bin/git --git-dir=/Users/rowanmcdonald/.cfg/ --work-tree=/Users/rowanmcdonald'

export TERM=xterm-256color
#====================
# Miscellaneous
#====================

alias credstash='gcredstash'
alias be='bundle exec'
alias bi='bundle install'
alias ber='bundle exec rspec'
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
#====================
# Git
#====================

alias gs='git status -s'
alias gb='git branch'
alias gsl='git shortlog -sn'
alias gcm='git commit -m'
alias gca='git commit -a'
alias gcb='git checkout -b'
alias b="git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'"
alias ga='git add .; git status -s'
alias cl="git checkout master; git fetch; git pull"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# add command for local changes to master
# alias gcl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit master..git branch | grep \* | cut -d ' ' -f2"

# alias download_all=`curl -u <token>:x-oauth-basic -s https://api.github.com/orgs/<organization>/repos\?per_page\=200 | ruby -rubygems -e 'require "json"; JSON.load(STDIN.read).each { |repo| %x[git clone #{repo["ssh_url"]} ]}'`
alias gfx='git clean -fx'



[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

#====================
# The 'ls' Family
#====================

alias ll='ls -l'            # list long form
alias ls='ls -hF'           # add colors for filetype recognition
alias la='ls -la'           # show hidden files
alias lk='ls -lSr'          # sort by size, biggest last
alias lc='ls -ltcr'         # sort by and show change time, most recent last
alias lu='ls -ltur'         # sort by and show access time, most recent last
alias lt='ls -ltr'          # sort by date, most recent last
alias lm='ls -al | less'    # pipe through 'less'
alias lr='ls -lR'           # recursive ls


#====================
# Navigation
#====================

alias ..='cd ..; pwd'
alias ...='cd ../..; pwd'
alias ....='cd ../../..; pwd'
alias .....='cd ../../../..; pwd'


#====================
# System
#  This is my bash prompt
#====================

parse_git_branch() {
	     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
     }
		 # export PS1="\[\033[1;30m\]\$(parse_git_branch)\[\033[0m\] \W ╣ "
		 export PS1="\[\033[1;30m\]\$(parse_git_branch)\[\033[0m\] \W ╣ "
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="%d/%m/%y %T "
export TERM=xterm

#====================
# Git Autocomplete
#====================

[ -f /usr/local/etc/bash_completion  ] && . /usr/local/etc/bash_completion

#====================
# python TODOS
#====================
# python ~/tina/todo/todo.py  /Users/rowan/felix/ever-standup /Users/rowan/tina/notes

#====================
# Stuff not to git
#====================
source ~/.private-config


#====================
# nvim
#====================

export EDITOR='nvim'
export VISUAL='nvim'




#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi


# Add colors to Terminal
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

#=========================
# Android studio
#=========================
alias android='open -a /Applications/Android\ Studio.app .'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash




#========================
# Local gemfile setup
#========================
# bundle config --global gemfile ~/.config/bundler/Gemfile.local
#

# function bundle() {
#   bundle="$(type -P bundle)"

#   if [ -r "$BUNDLE_GEMFILE" ] && [ -r Gemfile ] &&
#      [ "$BUNDLE_GEMFILE" != Gemfile ] &&
#      [[ "$1" =~ ^(|install|update)$ ]]; then
#     BUNDLE_GEMFILE=Gemfile "$bundle" "$@"
#     cp Gemfile.lock "${BUNDLE_GEMFILE}.lock"
#   fi

#   "$bundle" "$@"
# }
# use modes be_local, be_stop_local, be_reset_local
#

#==================================
# MAC CONF
#==================================

notify() {
				osascript -e "display notification \"$@\" with title \"iterm notification\""
}
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

source "$HOME/.bootstrap/env.sh"

alias sopsorific="secret_editor"

eval "$(direnv hook bash)"

export PATH=$PATH:~/.local/bin
export RIPGREP_CONFIG_PATH=~/.rgrc

#==================================
# Switch to large text 
#==================================
setProfileLargeText() {
  echo -e "\033]50;SetProfile=LargeText\a"
}

setProfileDefault() {
  echo -e "\033]50;SetProfile=Default\a"
}


#==================================
# This solves the issue of "There are 3 other sessions using the database"
#==================================
function kill_conn() {
    echo "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '$1' AND pid <> pg_backend_pid(); \d" | psql template1
}

#==================================
# This solves the issue of "There are 3 other sessions using the database"
#==================================
eval $(thefuck --alias)
