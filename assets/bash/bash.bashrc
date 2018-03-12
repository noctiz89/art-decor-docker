# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
#PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

if [ "$PS1" ]; then
  if [ "$BASH" ]; then
    if [ ${UID} -eq 0 ]; then
      #PS1="\[\e[31;1m\]\u\[\e[36;1m\]@\[\e[34;1m\]\h \[\e[31;1m\]\W#\[\e[0m\] "
      PS1="\[\e[31;1m\]\u\[\e[36;1m\]@\[\e[34;1m\]\h \[\e[31;1m\]\W#\[\e[0m\] "
    else
      #PS1="\[\e[1;33;40m\]\u\[\e[0;36;40m\]@\[\e[1;34;40m\]\h \[\e[1;31;40m\]\W$\[\e[0m\] "
      #PS1="\[\e[1;33;1m\]\u\[\e[0;36;1m\]@\[\e[1;34;1m\]\h \[\e[1;31;1m\]\W$\[\e[0m\] "
      PS1="\[\e[1;33;1m\]\u\[\e[0;36;1m\]@\[\e[01;32m\]\h \[\e[1;31;1m\]\W$\[\e[0m\] "
    fi
  else
    if [ "`id -u`" -eq 0 ]; then
      PS1='# '
    else
      PS1='$ '
    fi
  fi
fi


# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac

# enable bash completion in interactive shells
#if ! shopt -oq posix; then
#  if [ -f /usr/share/bash-completion/bash_completion ]; then
#    . /usr/share/bash-completion/bash_completion
#  elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#  fi
#fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/bin/python /usr/lib/command-not-found -- "$1"
                   return $?
                elif [ -x /usr/share/command-not-found/command-not-found ]; then
		   /usr/bin/python /usr/share/command-not-found/command-not-found -- "$1"
                   return $?
		else
		   printf "%s: command not found\n" "$1" >&2
		   return 127
		fi
	}
fi



LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
export LS_COLORS

alias ls="ls --color=auto"
alias ll="ls -lhF"

alias ps="ps -e f"
alias df="df -h"
alias du="du -h -d1"
alias pps="ps | grep -i"
alias apt-get="sudo apt-get"

alias eximlog='tail /var/log/exim4/mainlog'
alias eximlogf='tail -f /var/log/exim4/mainlog'
alias syslog='tail /var/log/syslog'
alias syslogf='tail -f /var/log/syslog'
alias tailf='tail -f'

