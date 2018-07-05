# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=10000
setopt appendhistory beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/matt/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in /home/matt/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="mattlips"
DISABLE_AUTO_UPDATE="true"
plugins=(git zsh-syntax-highlighting)


source $ZSH/oh-my-zsh.sh

# .. autocomplete
zstyle ':completion:*' special-dirs ..

# Customize to your needs...
export DISABLE_AUTO_TITLE=true
export TMOUT=0

#Aliases
alias dc='cd'
alias nopaste='nopaste --private'
alias axel='axel -a'
alias deswap='sudo swapoff -a && sudo swapon -a'
alias aspell\-latex-es="aspell -l es -t -x check"
alias aspell\-latex-en="aspell -l en -t -x check"
alias pacman='PACMAN=/usr/bin/pacman; [ -f /usr/bin/pacman-color ] && PACMAN=/usr/bin/pacman-color; $PACMAN $@'

alias du='du -kh'       # more readable output
alias df='df -kTh'      # same that above
alias ll="ls -l --group-directories-first"
alias ls='ls -hF --color'  # add colors for filetype recognition
alias la='ls -Al'          # show hidden files
alias lx='ls -lXB'         # sort by extension
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -al |more'    # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias tree='tree -Csu'     # nice alternative to 'recursive ls'

alias srczsh='source ~/.zshrc'

alias oF='nohup nautilus . > /dev/null 2>&1 &'

alias gssi='gnome-screenshot --interactive'
alias gssw='gnome-screenshot -w -d 1'

alias myip="wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1 | cut -c 2-"
alias nivelesPrima='curl http://24.232.0.118/asp/nivelesPrima.asp | grep "valor" | grep "dB" | cut -d ">" -f2 | cut -d "<" -f1'


alias recordDesktop='ffmpeg -f alsa -i pulse -f x11grab -s 3200x1800 -r 30 -i :0.0 -qscale:v 0 -qscale:a 0 '
alias k9='kill -9'
alias ka='killall'

alias tandil_xflux='xflux -l -37.3195228 -g -59.1427021'
alias tandil_weather='curl http://wttr.in/tandil'

alias tcli='transmission-cli -w ~/Videos -D'

# tmux
alias tmux='TERM=xterm-256color tmux -u'
alias tmn='tmux new-session'
alias tma='tmux attach -t'
alias tmls='tmux list-sessions'
alias tmrm='tmux kill-session -t'

eval $(thefuck --alias)

function del() { mv $1 ~/.local/share/Trash/files/; }

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'$*'*' -ls ; }

function getWebsiteTitle() {
    if [ "$#" -eq 1 ] ; then
        content=$(wget $1 -q -O -); echo $content | awk -vRS="</title>" '/<title>/{gsub(/.*<title>|\n+/,"");print;exit}' -
    fi
}

# UTILS
#ldapsearch -LLL -H ldap://activedirectory.example.com:389 -b 'dc=example,dc=com' -D 'DOMAIN\Joe.Bloggs' -w 'p@ssw0rd' '(sAMAccountName=joe.bloggs)'

function ffxhist() {
  cd ~/.mozilla/firefox/ && sqlite3 `cat profiles.ini | grep Path | awk -F= '{print $2 "\n"}'`/formhistory.sqlite "select * from moz_formhistory" && cd - > /dev/null
}

# Find a pattern in a set of files and highlight them:
# (needs a recent version of egrep)
function fstr() {
    OPTIND=1
    local case=""
    local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
        case "$opt" in
        i) case="-i " ;;
        *) echo "$usage"; return;;
        esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return;
    fi
    find . -type f -name "${2:-*}" -print0 | \
    xargs -0 egrep --color=always -sn ${case} "$1" 2>&- | more

}

function normalizeFiles() {
    if [ "$#" -lt 2 ]; then
        echo "normalizeFiles .current_extension .new_extension"
        echo "normalizeFiles .PdF?.0 .pdf"
    else
        j=0
        for i in *.$1; do let j+=1 ;mv $i archivo$j.$2 ; done
    fi
}

function extract()      # Handy Extract Program.
{
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xvjf $1     ;;
             *.tar.gz)    tar xvzf $1     ;;
             *.bz2)       bunzip2 $1      ;;
             *.rar)       unrar x $1      ;;
             *.gz)        gunzip $1       ;;
             *.tar)       tar xvf $1      ;;
             *.tbz2)      tar xvjf $1     ;;
             *.tgz)       tar xvzf $1     ;;
             *.zip)       unzip $1        ;;
             *.Z)         uncompress $1   ;;
             *.7z)        7z x $1         ;;
             *)           echo "'$1' cannot be extracted via >extract<" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

function extract_ips() {
    if [ -f $1 ] ; then
        grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' $1 | sort | uniq
    else
        echo "'$1' is not a valid file"
    fi
}

function myps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }

function vbox_getip() {
	VBoxManage guestproperty enumerate $1 | grep "IP, value:" | awk {'print $4'} | sed 's/,$//'
}

function vbox_startheadless() {
	vboxmanage startvm $1 --type headless
}

function ii()   # Get current host related info.
{
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Memory stats :$NC " ; free
    my_ip 2>&- ;
    echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP:-"Not connected"}
    echo -e "\n${RED}ISP Address :$NC" ; echo ${MY_ISP:-"Not connected"}
    echo -e "\n${RED}Open connections :$NC "; netstat -pan --inet;
    echo
}

function awksort() {
    if [ -f $1 ] ; then
        awk ' !x[$0]++' $1
    else
        echo "'$1' is not a valid file"
    fi
}

function wiki() {
        dig +short txt $1.wp.dg.cx

}

function getInternalIp() {
  if [ "$#" -eq 3 ]; then
    echo -e "GET $3 HTTP/1.0\n" | ncat $1 $2 | grep -P "\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b" --color
    echo -e "GET $3 HTTP/1.1\nHost:$2\n" | ncat $1 $2 | grep -P "\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b" --color
  else
    echo "getInternalIp host port path"
    echo "getInternalIp 127.0.0.1 80 /"
  fi
}


function power_save_off() {
  if [ "$#" -eq 1 ]; then
    sudo iw dev $1 set power_save off
  else
    echo "missing interface"
  fi
}

function javaproxy() {
  if [ "$#" -gt 1 ]; then
    java -DsocksProxyHost=$1 -DsocksProxyPort=$2 ${*:3:$#+1}
  else
    echo "javaproxy ip port params"
  fi
}

function karaoketize() {
    if [ $# -eq 2 ]; then
        INPUT=$1
        OUTPUT=$2
        mplayer -ao pcm:file=$OUTPUT -af karaoke $INPUT
        lame -V2 $OUTPUT ${OUTPUT%.wav}.mp3
    else
        echo "This will strip vocals from a song."
        echo "Usage: karaoketize song.mp3 output.wav"
        echo "It will return a .wav and an .mp3 file without the vocals."
    fi
}

#------------------
# Useful exports
#------------------
# set backupdir=./.backup,.,/tmp
# set directory^=$HOME/.vim_swap//
NPM_PACKAGES="${HOME}/.npm-packages"
export EDITOR=vim
export GOPATH="/home/matt/.go"
export PATH=$PATH::$NPM_PACKAGES/bin:$GOPATH/bin
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd' #on, lcd, gasp

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"


if [ -z "$TMUX" ]; then tmux; fi
