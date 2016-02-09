# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias vi='vim'
alias ca='lolcat'
alias rm='rm -i'
alias cdd='cd ~/Dropbox/'
alias lss='ls -lrt --color=auto'
## export HISTTIMEFORMAT='%F %T '
export HISTTIMEFORMAT=''
export LANG="en_GB.utf8"
export PS1='\[\e[1;37m\][\u@\h \W]\[\e[1;31m\]尼可\[\e[m\] ' #correctly escaped things between square brackets so line wrapping now works
#export PS1='\e[1;37m[\u@\h \W]\[\033[1;37m\]<U+26BD> \e[m '
#尼可
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
alias grep='grep -n'
alias o='xdg-open'
alias la='ls'
alias sl='ls'
alias windows='/bin/xfreerdp /size:1900x1000 /v:rds.ADDRESS.ac.uk /u:USERNAME /load-balance-info:"tsv://MS Terminal Services Plugin.1.ADDRESS"'
export PATH=/usr/local/texlive/2012/bin/x86_64-linux:$PATH 
alias gst='git status'
alias R='R -q'
alias bc='bc -l' 

## From http://www.davidpashley.com/articles/xterm-titles-with-bash/
#PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
##case "$TERM" in
##xterm*|rxvt*)
##    set -o functrace
##    trap 'echo -ne "\e]0;$BASH_COMMAND\007"' DEBUG
##    export PS1="\e]0;\s\007$PS1"
##    ;;
##*)
##    ;;
##esac
## From http://mg.pov.lt/blog/bash-prompt.html
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    ##PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    PROMPT_COMMAND='echo -ne "\033]0;${SHELL##*/} ${PWD}\007"'
#    ##PROMPT_COMMAND="__vte_prompt_command"
#    ##PROMPT_COMMAND="${PROMPT_COMMAND}${PROMPT_COMMAND:+;}__vte_prompt_command"
#
#    # Show the currently running command in the terminal title:
#    # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
#    show_command_in_title_bar()
#    {
#        case "$BASH_COMMAND" in
#            *\033]0*)
#                # The command is trying to set the title bar as well;
#                # this is most likely the execution of $PROMPT_COMMAND.
#                # In any case nested escapes confuse the terminal, so don't
#                # output them.
#                ;;
#            *)
#                ##echo -ne "\033]0;${USER}@${HOSTNAME}: ${BASH_COMMAND}\007"
#		## -e allows escape sequences; 0 after ] means set window title (1 would mean set icon title (dunno what that is), 2 would mean set both)
#                ##echo -ne "\033]0;${BASH_COMMAND}\007"
#		## http://stackoverflow.com/a/7110386 ## works with pipes
#		echo -ne "\033]0;$(history 1 | sed "s/^[ ]*[0-9]*[ ]*//g")\007"
#                ;;
#        esac
#    }
#    trap show_command_in_title_bar DEBUG
#    ;;
#*)
#    ;;
#esac

