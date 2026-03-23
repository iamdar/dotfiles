# ~/.bashrc: executed by bash(1) for non-login shells.

# ------------------------------------------------------------------------------
# 1. Environment & Non-interactive checks
# ------------------------------------------------------------------------------

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# ------------------------------------------------------------------------------
# 2. Shell Options
# ------------------------------------------------------------------------------

shopt -s histappend     # Append to the history file, don't overwrite it
shopt -s checkwinsize   # Update LINES and COLUMNS after each command
shopt -s globstar       # ** matches all files and subdirectories
shopt -s autocd         # cd by typing directory name
shopt -s cdspell        # Correct minor spelling errors in cd
shopt -s nocaseglob     # Case-insensitive filename completion
shopt -s cmdhist        # Save multiline commands as one entry

# ------------------------------------------------------------------------------
# 3. History Management
# ------------------------------------------------------------------------------

HISTCONTROL=ignoreboth
HISTSIZE=50000
HISTFILESIZE=100000
HISTIGNORE="ls:ls -al:ps:history:exit:pwd:clear"

# Sync history between multiple terminal sessions
PROMPT_COMMAND='history -a; history -n; '"$PROMPT_COMMAND"

# ------------------------------------------------------------------------------
# 4. Source Aliases and Functions
# ------------------------------------------------------------------------------

# Source Functions first so they can be used in aliases or prompt
if [ -f ~/.functions ]; then
    . ~/.functions
fi

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

# Source custom aliases if they exist (standard location)
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ------------------------------------------------------------------------------
# 5. Prompt & Appearance
# ------------------------------------------------------------------------------

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Prompt definition (User@Host:Path [Branch] $)
# parse_git_branch is defined in ~/.functions
if [ "$TERM" != "dumb" ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[33m\]$(parse_git_branch)\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\$ '
fi

# ------------------------------------------------------------------------------
# 6. Completion & Integrations
# ------------------------------------------------------------------------------

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
