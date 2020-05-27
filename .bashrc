#==============================
# source anything inside .bash
#==============================

for rcfile in ~/.bash/*; do
  source "$rcfile"
done
unset rcfile

#====================
# Stuff not to track
#====================
source ~/.private-config

#====================
# Shell options
#   docs: https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
#====================

# If set, Bash matches filenames in a case-insensitive fashion when performing filename expansion.
shopt -s nocaseglob

# If set, the history list is appended to the file named by the value of the HISTFILE variable when the shell exits, rather than overwriting the file.
shopt -s histappend

# If set, minor errors in the spelling of a directory component in a cd command will be corrected. The errors checked for are transposed characters, a missing character, and a character too many. If a correction is found, the corrected path is printed, and the command proceeds. This option is only used by interactive shells.
shopt -s cdspell

# If set, a command name that is the name of a directory is executed as if it were the argument to the cd command. This option is only used by interactive shells.
[ "${BASH_VERSINFO:-0}" -ge 4 ] && shopt -s autocd

# If set, the pattern ‘**’ used in a filename expansion context will match all files and zero or more directories and subdirectories. If the pattern is followed by a ‘/’, only directories and subdirectories match.
[ "${BASH_VERSINFO:-0}" -ge 4 ] && shopt -s globstar

# If set, Bash attempts to save all lines of a multiple-line command in the same history entry. This allows easy re-editing of multi-line commands.
shopt -s cmdhist

#====================
# Bash Prompt
#====================

if [ "$PLATFORM" = Linux ]; then
  PS1="\[\e[1;38m\]\u\[\e[1;34m\]@\[\e[1;31m\]\h\[\e[1;30m\]:"
  PS1="$PS1\[\e[0;38m\]\w\[\e[1;35m\]> \[\e[0m\]"
else
  __git_ps1() { :;}
  PS1="\[\033[1;34m\]\$(__git_ps1)\[\033[0m\] \W ╣ "
fi

##========================
# FZF bindings, completion, etc.
##========================

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# binds contrl-p to open fzf view
bind -x '"\C-p": vim $(fzf);'

##========================
# Direnv hook
##========================
eval "$(direnv hook bash)"

#===============================
# z integration
#===============================

source ~/.bin/z.sh

#===============================
# fzf fn bindings
#===============================

if [[ $- =~ i ]]; then
  bind '"\er": redraw-current-line'
  bind '"\C-b": "$(co)\e\C-e\er"'
  # bind '"\C-g\C-b": "$(gb)\e\C-e\er"'
  # bind '"\C-g\C-t": "$(gt)\e\C-e\er"'
  # bind '"\C-g\C-h": "$(gh)\e\C-e\er"'
  # bind '"\C-g\C-r": "$(gr)\e\C-e\er"'
  # bind '"\C-g\C-s": "$(stash)\e\C-e\er"'
fi

#===============================
# TMUX integration on startup.
#===============================
#
# if type tmux &>/dev/null; then
#   if [ "$TERM" == "xterm-256color" ] && [ "$TERM_PROGRAM" != "iTerm.app" ]; then
#     source /Users/rowanmcdonald/p/alacritty/extra/completions/alacritty.bash
#     [ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit; }
#   fi
# fi

#===============================
# programmable bash completion
#===============================
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

#===============================
# startup rbenv
#===============================
eval "$(rbenv init -)"
