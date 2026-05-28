#==============================
# Homebrew (Apple Silicon / Intel)
#==============================
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

#==============================
# PATH
#==============================
path=(
  $HOME/.bin
  $HOME/.local/bin
  $HOME/.bun/bin
  $path
  $HOME/.pub-cache/bin
  $HOME/fvm/default/bin
)
typeset -U path

#==============================
# Environment
#==============================
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
export RIPGREP_CONFIG_PATH=~/.rgrc
export BAT_THEME="TwoDark"
export LANG='en_US.UTF-8'
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export DIRENV_LOG_FORMAT=

# Ruby / Rails
export RUBYFMT_USE_RELEASE=1
export SPEC_OPTS='--no-profile'
export SPRING_ENABLED="true"
if command -v brew &>/dev/null; then
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)"
fi

export CDPATH=".:$HOME/w/core"

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude vendor'
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND='fd --type f --type d --hidden --follow --exclude .git'
[ -n "$NVIM_LISTEN_ADDRESS" ] && export FZF_DEFAULT_OPTS='--no-height'
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"

#==============================
# History
#==============================
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt SHARE_HISTORY HIST_IGNORE_SPACE HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS EXTENDED_HISTORY

#==============================
# Shell options
#==============================
setopt AUTO_CD
setopt NO_CASE_GLOB
setopt EXTENDED_GLOB
setopt PROMPT_SUBST

#==============================
# Aliases
#==============================
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias android='open -a /Applications/Android\ Studio.app .'

# Ruby
alias bi='bundle install'
alias ber='bundle exec rspec'
alias be='bundle exec'

# Git
alias gs='git status -s'
alias gsl='git shortlog -sn'
alias gcm='git commit -m'
alias gca='git commit -a'
alias gcb='git checkout -b'
alias b="git for-each-ref --sort='-authordate' --format='%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'"
alias ga='git add .; git status -s'
alias cl="git checkout main; git fetch; git pull"
alias cl_="git checkout master; git fetch; git pull"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset - %s %C(yellow)%d%Creset %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gp='git push -u origin HEAD'

# ls family
alias ls='eza -hF'
alias la='eza -la'

# Navigation
alias bwd='pwd | sed -e "s:/:🥖:g"'
alias ..='cd ..; bwd'
alias ...='cd ../..; bwd'
alias ....='cd ../../..; bwd'
alias .....='cd ../../../..; bwd'

alias rgf='rg --files | rg'
alias cat='bat --paging=never --style=plain'

alias vim='nvim'
alias vi='nvim'
alias v='nvim'

alias prettygource="gource -1080x800 --hide mouse,filenames --seconds-per-day .2 --file-idle-time 0 --highlight-users --multi-sampling --key"
alias f="fly -t zoe_ci"

# https://gist.github.com/april/a4010daa8581626eb4670a08df558311
SUDOPROMPT=$'🌺🌳🌸🌷🌷🌸🌻🌷🌷🌸🌸🌸🌸🌷🌼🌷🌳🌺🌼🌺🌸🌻🌼🌼🌳🌳🌼🌺🌻🌷🐛🌷🌼🌻🌳🌸🌷🌷🌻🌸\n🌸🦉🌻🌸🌳🌷🌸🌷🌸🌳🌸🌻🌳🐌🌻🌷🌷🌼🌻🌺🌺🌻🌼🌻🌻🌼🌺🌻🌳🌼🌳🌺🌳🌷🌻🌼🌷🌼🌻🌸\n🌳🌸🌻🌺🌻🌳🌺🌺🌻🌺🌸🌻🌷🌷🌼🌻🌺🌼🌻🌻🌷🌳🌻🌸🌳🌷🌻🌳🌳🌳🌳🌼🌳🌳🌺🌷🌳🌺🌳🌺\n🦉🌸🌻🌺🌺🌳🌸🌸🌼🌻🌺🌼🌷🌸🌳🌼🌺🌸🌺🌷🌻🌷🌺🌺🌳🌷🌷🐰🌸🌻🌳🌸🌼🌷🌼🌳🌷🐹🌼🌺\n🌷🌳🌻🌸🌸🌼🐰🌷🌺🌷🌺🌻🌷🌸🌺🌻🌳🌻🌷🌻🌻🌺🌸🌸🌺🌻🌸🌻🌳🌳🌻🐦🌻🌼🌼🌻🌻🌺🌳🐰\n🌼🐦🌻🌳🌸🌸🌳🌷🌺🌼🌳🌷🌸🌻🌼🌻🐛🌻🌼🌷🌺🌼🌺🌸🌺🦔🌷🌸🌷🌻🌻🌺🌼🌷🐌🌸🌷🌼🌸🐹\n🌸🌳🌻🌼🌻🌳🌸🌷🌺🌷🌷🌼🌻🌷🌻🌺🌼🌼🌳🌸🌻🌻🌸🌼🌼🌸🌳🌺🌻🌻🌳🌺🌷🐰🌻🌼🐹🌷🌷🌳\n🌼🌷🌻🌸🌼🌳🌻🌻🌳🌷🌼🌻🌺🌺🌺🌺🌺🌳🌻🌼🌷🌸🌸🌻🌺🌻🌳🌸🌷🌺🌺🌼🌸🌺🌻🌻🌷🌸🌻🌷\n🌼🌳🌷🌳🌸🌺🌻🌳                                              🌺🌸🌻🐢🌺🌳🌻🌺🌼\n🌷🌷🌺🌳🌼🌸🌻🌸     please enter ur password, cutie pie      🌷🌺🌼🌷🌻🌺🌼🌷🌺\n🌺🌺🌻🌼🌻🌻🌷🌻                                              🌼🌷🌸🌷🌺🌷🌸🌳🌸\n🌳🌼🌼🌼🌻🌺🌺🌺🌼🌺🌼🌻🌺🦉🌺🌸🌸🌳🌳🌳🌷🌸🌺🌷🌼🌼🌺🐛🌷🌸🌸🌺🌻🌸🌺🌺🌷🌷🌻🌺\n🌳🌳🌷🌷🐢🌳🌼🌺🌼🌻🌺🌼🌷🌻🌸🌻🌺🌷🌳🌺🌻🌺🌼🌷🌷🌳🌺🌸🌸🌻🌷🌷🌳🌳🌻🌸🌻🌼🌼🌷\n🌼🌸🌳🌻🌻🌳🌼🌻🌸🌻🌸🌷🌺🌷🌳🌻🌼🐌🌼🌳🌺🌷🌷🌼🌷🌷🦔🌻🌷🌸🌼🌷🌼🌻🌷🌷🌺🌻🌷🌷\n🌸🌻🌷🌷🦉🌻🌻🌼🌺🌻🌳🌻🌸🌷🌷🌻🌳🌻🌺🌺🌼🌷🌳🌼🌷🌸🌼🌻🌻🌷🌺🌷🌻🌷🌷🌼🌻🌷🌺🌺\n🌳🌺🌷🌼🌻🌺🌸🌺🌳🌻🌸🐣🌻🌼🌻🌷🌸🌼🌺🌳🌳🌸🌷🌸🌻🌸🌷🌻🌸🌳🌻🌺🌳🌺🌷🌺🌼🌳🌳🌷\n🌳🌷🌷🐹🌺🌸🌼🌺🌺🌼🌺🌸🌸🌳🌳🌳🌼🌻🌳🌻🌷🌷🌼🌼🌳🌺🌷🌻🌳🌸🌻🌺🌸🌸🌸🌷🌻🌻🌸🌼\n🌼🌳🌸🐦🌺🌺🌷🌼🌻🌺🌼🌷🌻🌸🌷🌸🌸🌸🌸🌼🌺🌻🌺🐢🌳🌼🌻🌺🌺🌺🐹🌳🌸🌸🌼🌳🌻🌻🌺🌻\n🌷🌼🌸🌼🌳🌺🌺🦔🌻🌼🌻🌸🌼🌺🌺🌻🌼🌷🌼🌳🌺🌺🌷🌻🌷🐌🌸🌷🌷🌳🌺🌺🌷🌸🌳🌻🌳🌻🌸🌸\n🥰 ps i love u 🥰 :'
alias prettyplease="sudo -p '$SUDOPROMPT'"

#==============================
# Functions
#==============================
dots() {
  /usr/bin/git --git-dir="$HOME/dotfiles/" --work-tree="$HOME" "$@"
}

notify() {
  osascript -e "display notification \"$*\" with title \"iterm notification\""
}

set_profile_large_text() { print -n '\e]50;SetProfile=LargeText\a' }
set_profile_default()    { print -n '\e]50;SetProfile=Default\a' }
set_profile_light()      { print -n '\e]50;SetProfile=Light\a' }

pg_kill_conn() {
  echo "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '$1' AND pid <> pg_backend_pid(); \d" | psql template1
}

how_many() { rg -F --vimgrep "$1" | wc -l }

in_each_ruby_dir() {
  local root=$(git rev-parse --show-toplevel)
  cd "$root"
  local g
  for g in $(find . -name 'Gemfile'); do
    pushd "$(dirname $g)"
    "$@"
    popd
  done
}

rubo() {
  local current_branch=$(git rev-parse --abbrev-ref HEAD)
  local base_commit_of_branch=$(diff -u <(git rev-list --first-parent $current_branch) <(git rev-list --first-parent main) | sed -ne 's/^ //p' | head -1)
  git diff-tree -r --no-commit-id --name-only --relative head $base_commit_of_branch | xargs ls -d 2>/dev/null | xargs bundle exec rubocop --auto-correct
}

lint() {
  bundle exec standardrb
  bundle exec erblint --lint-all -a
  git add .
  git commit -m "Lint"
}

is_in_git_repo() { git rev-parse HEAD &>/dev/null }
fzf-down()       { fzf --height 50% "$@" --border }

fgl() {
  [ $# -eq 0 ] && return
  cd "$(brew --prefix figlet)/share/figlet/fonts"
  local font
  font=$(ls *.flf | sort | fzf --no-multi --reverse --preview "figlet -f {} $*" --preview-window up) &&
    figlet -f "$font" "$@" | pbcopy
  cd -
}

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

# Renamed from gh() to avoid colliding with the GitHub CLI.
gshow() {
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

gd() {
  local branches branch
  branches=$(git branch --all) &&
  branch=$(echo "$branches" | fzf-down --no-hscroll --reverse --ansi -m -q "rowan/$*") &&
    git branch -D $(echo "$branch" | sed "s/.* //")
}

# Toggle between two recent directories
toggle_top_two_stack() {
  if [[ -n "$1" ]]; then
    pushd "$1"
    return
  fi
  if [[ -z "$top_stack" ]]; then
    local tmp_top_stack=$(pwd)
    local tmp_top_stack_display=$(pwd | sed "s#$HOME# ~#")
    if popd >/dev/null; then
      top_stack=$tmp_top_stack
      top_stack_display=$tmp_top_stack_display
    else
      echo "nowhere to go"
    fi
  else
    pushd "$top_stack" >/dev/null
    top_stack=""
    top_stack_display=""
  fi
  export top_stack
}
alias kk="toggle_top_two_stack"

open_pr() {
  local github_url branch_name pr_url
  github_url=$(git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#https://#' -e 's@com:@com/@' -e 's%\.git$%%' | awk '/github/')
  branch_name=$(git symbolic-ref HEAD | cut -d"/" -f 3,4)
  pr_url="$github_url/compare/main...$branch_name"
  open "$pr_url"
}

gpr() {
  if git push origin HEAD; then
    open_pr
  else
    echo 'failed to push commits and open a pull request.'
  fi
}

ff() {
  echo "... zoooooommm"
  git pull origin main --ff-only
  if [[ -n $(git status --porcelain) ]]; then
    git add --all
    git commit --quiet --message=temp
    git rebase main
    git reset HEAD~1
  else
    git rebase main
  fi
}

#==============================
# Tool init
#==============================
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"
command -v mise   &>/dev/null && eval "$(mise activate zsh)"
command -v atuin  &>/dev/null && eval "$(atuin init zsh)"
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

# fzf key bindings + completion (installed by setup_dotfiles)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

#==============================
# Prompt
#==============================
PROMPT='%F{blue}%f %c ╣ '

#==============================
# Key bindings
#==============================
# Ctrl-P: pick a file with fzf, edit in nvim
fzf-vim-widget() { BUFFER="vim $(fzf)"; zle accept-line }
zle -N fzf-vim-widget
bindkey '^P' fzf-vim-widget

# Ctrl-B: pick a branch/tag with co(), insert checkout into command line
co-widget() { LBUFFER+="$(co)" }
zle -N co-widget
bindkey '^B' co-widget

#==============================
# Private (untracked) config
#==============================
[ -f ~/.private-config ] && source ~/.private-config
