
set EDITOR=vim
set history=400
set savehist=500

alias ls='ls --color'
alias ll='ls -lAtr'
alias h=history
alias grep='grep --color'

# Colors!
bold=$(tput bold)
red="\[$(tput setaf 1)\]"
green="\[$(tput setaf 2)\]"
yellow="\[$(tput setaf 3)\]"
blue="\[$(tput setaf 4)\]"
magenta="\[$(tput setaf 5)\]"
cyan="\[$(tput setaf 6)\]"
white="\[$(tput setaf 7)\]"
reset="\[$(tput sgr0)\]"

user_color=$green
[[ ! "${whoami}" == "okoren" ]] || { user_color=$red; }

#set prompt="${green}%n${blue}@%m${yellow}:~ ${yellow}>${end} "
#export PS1="${bold}${user_color}\u${blue}@\h${yellow}:\w >${reset} "

#export PS1="\[\e[1;32m\]\u\[\e[0m\]@\[\e[1;34m\]\h\[\e[0m\]:\[\e[1;33m\]\W\[\033[0m\] > "
export PS1="\[\e[5m\]\[\e[1;32m\]\u\[\e[0m\]\[\e[1;34m\]@\h\[\e[0m\]:\[\e[1;33m\]\W\[\033[0m\] > "
