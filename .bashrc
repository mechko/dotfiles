# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
stty -ixon

export PATH=$PATH:/sbin:/usr/sbin:/Users/mechko/Library/Haskell/bin

export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h: \[\e[33m\]\w\[\e[0m\]\n\$ '

if [ -f /etc/bash_completion ]
then
  . /etc/bash_completion
fi

function screen_window() {
  if [ $TERM == "screen" ]; then
	echo "screen -t $1"
  else
	echo ""
  fi	
}

function tab() {
    local cmd=""
    local cdto="$PWD"
    local args="$@"

    if [ -d "$1" ]; then
        cdto=`cd "$1"; pwd`
        args="${@:2}"
    fi

    if [ -n "$args" ]; then
        cmd="; $args"
    fi

    osascript &>/dev/null <<EOF
        tell application "iTerm"
            tell current terminal
                launch session "Default Session"
                tell the last session
                    write text "cd \"$cdto\"$cmd"
                end tell
            end tell
        end tell
EOF
}


function determineLocalDatabase() {
    cat target/jiveHome/jive_startup.xml | grep serverURL | sed -e 's/.*5432\///' -e 's/<.*$//g'
}

#function buildJive() {
#    mvn clean package
#    localDatabase=$(determineLocalDatabase)
#    echo -e "\n\nUsing local database: $localDatabase\n\n"
#    psql -U mrsw ${localDatabase} -c "delete from jiveproperty where name='jive.master.encryption.key.node';"
#    psql -U mrsw ${localDatabase} -c "delete from jiveproperty where name='jive.master.eae.key.node';"
#}




# aliases
alias l='ls -lhG'
alias ll='ls -lahG'

# postgres
alias pgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop'
export PGHOST=localhost 

#java (jdk6)
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/1.6.0_65-b14-462.jdk/Contents/Home
#export MAVEN_OPTS="-Xmx1024m"

