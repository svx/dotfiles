# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
alias tmux="TERM=screen-256color-bce tmux"

# path to packer to make it easy
export PATH=$PATH:~/bin/packer/

# make my path shorter, this is only working from bash4 on
PROMPT_DIRTRIM=2

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Benachrichtigungen bei langen Prozessen
#if [ -x /usr/bin/notify-send ]; then
#      alias alert='notify-send -i gnome-terminal "[$?] $(history|tail -n1|sed
#      -e '\''s/^\s*[0-9]\+\s*//;s/;\s*alert$//'\'')"'
#fi

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w$(__git_ps1 "\[\033[00m\]\[\033[1;33m\] (%s)")\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias du='du -h -d 2'
alias psa='ps aux'
alias psg='ps aux | grep'
alias dush='du -hcs *'

# ecrypt pw's
alias epass='gpg -e -r 0x7C6BAE3F'

# create new passwd
alias newpass='pwgen -sy 24 1'

# gitlog
alias gitlog='git log --graph --decorate --pretty=oneline --abbrev-commit --all'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.


# Set the default password directory.
export PASSDIR=~/pw




#  text file and build it with an extension, if needed.
# Prefer gpg extension over txt.
buildfile() {
    # If an extension was given, use it.
    if [[ "$1" == *.* ]]; then
        echo "$1"

    # If no extension was given...
    else
        # ... try the file without any extension.
        if [ -e "$1" ]; then
            echo "$1"
        # ... try the file with a gpg extension.
        elif [ -e "$1".gpg ]; then
            echo "$1".gpg
        # ... use a txt extension.
        else
            echo "$1".txt
        fi
    fi
}
# Set the password database directory.
PASSDIR=/home/svx/pw

# Create or edit password databases.
pw() {
    cd "$PASSDIR"
    if [ ! -z "$1" ]; then
        vim $(buildfile "$1")
        cd "$OLDPWD"
    fi
}

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ssh-agent
if [ $SSH_AGENT_PID ]; then
    if [[ $(ssh-add -l) != *id_?sa* ]]; then
        ssh-add -t 2h  ## Haltbarkeit von 2 Std.
    fi
fi


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

