#===================
# Config alias
#===================
alias config='/usr/bin/git --git-dir=/Users/rowanmcdonald/.cfg/ --work-tree=/Users/rowanmcdonald'
v() {
  nvim $@
}

#====================
# Miscellaneous
#====================
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

#====================
# Ruby
#====================
alias bi='bundle install'
alias ber='bundle exec rspec'
LOCAL_GEMFILE=Gemfile.local
be() {
   bundle exec $@
}

in_each_ruby_dir(){
  # this is not working :/
  local root=$(git rev-parse --show-toplevel)
  cd $root

  for g in $(find . -name 'Gemfile'); do
    cd $(dirname ${g})
    $@
    cd ..
  done
}

# run rubocop on files changed since the base branch that are under the current dir
rubo() {
  local current_branch=$(git rev-parse --abbrev-ref HEAD)
  local base_commit_of_branch=$(diff -u <(git rev-list --first-parent $current_branch) <(git rev-list --first-parent master) | sed -ne 's/^ //p' | head -1)
  git diff-tree -r --no-commit-id --name-only --relative head $base_commit_of_branch | xargs ls -d 2>/dev/null | xargs bundle exec rubocop
}

#====================
# Git
#====================

alias gs='git status -s'
alias gsl='git shortlog -sn'
alias gcm='git commit -m'
alias gca='git commit -a'
alias gcb='git checkout -b'
alias b="git for-each-ref --sort='-authordate' --format='%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'"
alias ga='git add .; git status -s'
alias cl="git checkout master; git fetch; git pull"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

## add command for local changes to master
alias gcl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit master..git branch | grep \* | cut -d ' ' -f2"

# alias download_all=`curl -u <token>:x-oauth-basic -s https://api.github.com/orgs/<organization>/repos\?per_page\=200 | ruby -rubygems -e 'require "json"; JSON.load(STDIN.read).each { |repo| %x[git clone #{repo["ssh_url"]} ]}'`
alias gfx='git clean -fdx'


##====================
## The 'ls' Family
##====================

alias ls='exa -hF'           # add colors for filetype recognition
alias la='exa -la'           # show hidden files

#====================
# Navigation
#====================

alias bwd='pwd | sed -e "s:/:🥖:g"'
alias ..='cd ..; bwd'
alias ...='cd ../..; bwd'
alias ....='cd ../../..; bwd'
alias .....='cd ../../../..; bwd'

#====================
# System
#  This is my bash prompt
#====================

if [ "$PLATFORM" = Linux ]; then
  PS1="\[\e[1;38m\]\u\[\e[1;34m\]@\[\e[1;31m\]\h\[\e[1;30m\]:"
  PS1="$PS1\[\e[0;38m\]\w\[\e[1;35m\]> \[\e[0m\]"
else
  __git_ps1() { :;}
  if [ -e ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
  fi
  PS1="\[\033[1;34m\]\$(__git_ps1)\[\033[0m\] \W ╣ "
fi

export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="%d/%m/%y %T "
export BAT_THEME="TwoDark"

#====================
# Stuff not to git
#====================
source ~/.private-config

#====================
# Language
#====================

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi


##========================
# Add colors to Terminal
##========================
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

#=========================
# Android studio
#=========================
alias android='open -a /Applications/Android\ Studio.app .'


##========================
# FZF
##========================

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

###========================
### Local gemfile setup 🐲
###========================
### bundle config --global gemfile ~/.config/bundler/Gemfile.local
###

### function bundle() {
###   bundle="$(type -P bundle)"

###   if [ -r "$BUNDLE_GEMFILE" ] && [ -r Gemfile ] &&
###      [ "$BUNDLE_GEMFILE" != Gemfile ] &&
###      [[ "$1" =~ ^(|install|update)$ ]]; then
###     BUNDLE_GEMFILE=Gemfile "$bundle" "$@"
###     cp Gemfile.lock "${BUNDLE_GEMFILE}.lock"
###   fi

###   "$bundle" "$@"
### }
### use modes be_local, be_stop_local, be_reset_local
###

#==================================
# MAC CONF
#==================================

notify() {
				osascript -e "display notification \"$@\" with title \"iterm notification\""
}

eval "$(direnv hook bash)"

#==================================
# Switch to large text  in iterm
#==================================
set_profile_large_text() {
  echo -e "\033]50;SetProfile=LargeText\a"
}

set_profile_default() {
  echo -e "\033]50;SetProfile=Default\a"
}

set_profile_light() {
  echo -e "\033]50;SetProfile=Light\a"
}




#==================================
# This solves the issue of "There are 3 other sessions using the database"
#==================================
function pg_kill_conn() {
    echo "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '$1' AND pid <> pg_backend_pid(); \d" | psql template1
}

##===================================
# FZF stuff
##===================================

# binds contrl-p to open fzf view
bind -x '"\C-p": vim $(fzf);'

fzf-down() {
  fzf --height 50% "$@" --border
}

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude vendor'
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND='fd --type f --type d --hidden --follow --exclude .git'
[ -n "$NVIM_LISTEN_ADDRESS" ] && export FZF_DEFAULT_OPTS='--no-height'

if [ -x ~/.config/nvim/plugged/fzf.vim/bin/preview.rb ]; then
  export FZF_CTRL_T_OPTS="--preview '~/.config/nvim/plugged/fzf.vim/bin/preview.rb {} | head -200'"
fi

export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"

fgl() {
  [ $# -eq 0 ] && return
  cd /usr/local/Cellar/figlet/*/share/figlet/fonts
  local font=$(ls *.flf | sort | fzf --no-multi --reverse --preview "figlet -f {} $@" --preview-window up) &&
  figlet -f "$font" "$@" | pbcopy
}

# co - checkout git branch/tag
co() {
  local tags branches target
  tags=$(git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") | sed '/^$/d' |
    fzf-down --no-hscroll --reverse --ansi +m -d "\t" -n 2 -q "rowan/$*") || return
  git checkout $(echo "$target" | awk '{print $2}')
}

#===============================
# z integration
#===============================

. /usr/local/etc/profile.d/z.sh
j() {
  if [[ -z "$*" ]]; then
    cd "$(_z -l 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')"
  else
    _last_z_args="$@"
    _z "$@"
  fi
}

jj() {
  cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf -q "$_last_z_args")"
}

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -200' |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -200' |
  grep -o "[a-f0-9]\{7,\}"
}

gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

stash() {
  is_in_git_repo || return
  git stash list | fzf-down --reverse -d: --preview 'git show --color=always {1}' |
  cut -d: -f1
}

if [[ $- =~ i ]]; then
  bind '"\er": redraw-current-line'
  bind '"\C-b": "$(co)\e\C-e\er"'
  # bind '"\C-g\C-b": "$(gb)\e\C-e\er"'
  # bind '"\C-g\C-t": "$(gt)\e\C-e\er"'
  # bind '"\C-g\C-h": "$(gh)\e\C-e\er"'
  # bind '"\C-g\C-r": "$(gr)\e\C-e\er"'
  # bind '"\C-g\C-s": "$(stash)\e\C-e\er"'
fi

alias see='ruby --disable=gems /Users/rowanmcdonald/p/see_rails/build/see_rails.rb'
alias seer='ruby /Users/rowanmcdonald/p/see_rails/build/see_rails.rb'

if type tmux &>/dev/null; then
  if [ "$TERM" == "xterm-256color" ] && [ "$TERM_PROGRAM" != "iTerm.app" ]; then
    [ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit; }
  fi
fi
source /Users/rowanmcdonald/p/alacritty/extra/completions/alacritty.bash
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

