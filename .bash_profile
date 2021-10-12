# Ideas from https://gist.github.com/wedow/51e92155de948e2f4fbd274d626d3763
################################################################################

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# vi mode!
# very easy to navigate for bigger commands and overall awesomeness
set -o vi

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# don't put duplicate lines or lines starting with space in the history.
# man bash and search for HISTCONTROL for more info
HISTCONTROL=ignoreboth

# update the values of LINES and COLUMNS.
# After resizing terminal - it will not be messed up
# https://unix.stackexchange.com/a/61608
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

################################################################################
##### EXPORTS #####

# ignore case, long prompt, exit if it fits on one screen, allow colors for ls and grep colors
export LESS="-iMFXR"

# Node Versioning System - makes its easy to switch between node versions
# brew install nvm && mkdir $HOME/.nvm
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# Making go path inside home folder
export GOPATH=~/go

# Export JAVA_HOME
export JAVA_HOME=`/usr/libexec/java_home`

# Add nod_modules to executable path - this way all the modules installed in the application can be run directly
export PATH=$PATH:./node_modules/.bin

# Add home directory
export PATH=~/bin:$PATH

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Add MongoDb to path
# export PATH="$PATH:~/mongodb/bin"

# Awesome - this shows which are your change directory paths to look for - helpful in autocompletion
export CDPATH=.:~:~/code:~/src/apps

# Export default profile for aws command line - assumed_role is profile inside ~/.aws/credentials
# export AWS_PROFILE=assumed_role

# shows colors in terminal
export CLICOLOR=1

# https://geoff.greer.fm/lscolors/
export LSCOLORS=exfxcxdxbxegedabagacad

# For terraform configuration file
export TF_CLI_CONFIG_FILE=~/terraform.rc
################################################################################
##### PROMPT - PS1 #####
# No idea whats going on below this - took directly from source gist

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
    PS1='\[\033[01;32m\]\!:\#\[\033[00m\]:\[\033[01;36m\]\W\[\033[00m\]'
else
    PS1='\u:\W'
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u: \W\a\]$PS1"
    ;;
*)
    ;;
esac

# https://github.com/michaeldfallen/git-radar
# to install git-radar
# brew install michaeldfallen/formula/git-radar
# by default it looks good in white background
# when using dark background - enable option "Use bright colors for bold text" in Terminal profile
PS1+="\$(git-radar --bash --fetch)"
PS1+=" 🐶\n"

# To show error code if previous command exited with non-zero error code
# got idea from https://unix.stackexchange.com/a/23517/228414
# PS1='\e[41m${?/#0/}\e[0m'"🐼 $PS1"

################################################################################
##### ALIASES #####

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# faster way to just clear the screen -->> press c and return key
alias c="clear"

# clean docker containers instances which are exited && prune some images
alias dclean="docker ps -q -f status=exited | xargs docker rm && docker image prune"

# listing
alias la='ls -larthG' # list it, hidden files, revererse order, timestamp, human readable size, colorized output
alias labc='ls -lap' # alphabetical sort

# joyful terminal-parrot
alias parrot="/usr/local/Cellar/terminal-parrot/1.1.0/bin/parrot -delay 25"

# some postgres start and stop utility from command line
alias pstart="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pstop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Kill chrome if its taking too much memory or power
alias kchrome="killall -9 \"Google Chrome\""

# Kill tunnelblick when its not responding
alias ktunnel="killall -9 \"Tunnelblick\""

# git
alias gg="git grep -n"
alias greset="git reset --hard HEAD"
alias gprunemaster="git remote prune origin && git branch --merged master --no-color | grep -v master | grep -v stable | xargs git branch -D"
alias gprunemain="git remote prune origin && git branch --merged main --no-color | grep -v main | grep -v stable | xargs git branch -D"
alias gmaster="git stash && git ch master && git pull && gprunemaster"
alias gmain="git stash && git ch main && git pull && gprunemain"

# just clean up stuff for clearing the icons - for sanity
alias clearIcons="sudo find . -type f -name \"Icon?\" -delete"

# move to folders
alias box="cd ~/Box\ Sync"
alias downloads="cd ~/downloads"

# login to EC2 instance via bastion-host
alias keyless_login="$HOME/code/apollo-platform/common/bastion-hosts/keyless_login.sh --keypair ~/.ssh/dev-us-east-1-root-kp.pem --account-name apollo-development --instance-id"
alias keyless_login_sandbox="$HOME/code/apollo-platform/common/bastion-hosts/keyless_login.sh --keypair ~/.ssh/sandbox-us-east-1-root-kp.pem --account-name apollo-sandbox --instance-id"
alias keyless_login_prod="$HOME/code/apollo-platform/common/bastion-hosts/keyless_login.sh --keypair ~/.ssh/prod-us-east-1-root-kp.pem --account-name apollo-production --instance-id"


# open file or folder using vscode in command line
alias vscode="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"

alias updateDailyLog="cd dailyLog && git add . && git co -m'm' && git push && git push gitlab master && cd -"

alias cleanupBashHistory="awk '!seen[$0]++' ~/.bash_history | awk '!/^(git|cd|cat|touch|echo|brew|rm|less|subl|kill|cp|mv|gcloud|terraform|kubectl|helm|vault|docker|vi)/' ~/.bash_history > temp.txt && mv temp.txt ~/.bash_history"
alias t11="/usr/local/Cellar/terraform@0.11/0.11.14/bin/terraform"

# https://confluence.dev.clover.com/display/CO/Instructions+for+setting+up+your+yubikey
alias yubinit='eval `ssh-agent -s -P /usr/local/lib/*,/usr/local/Cellar/yubico-piv-tool/*/lib/*.dylib`;ssh-add -s /usr/local/lib/libykcs11.dylib'

alias ksandbox="https_proxy=sandbox-us-west1-cluster-privoxy.ilb.sbx.pdx12.clover.network:8118 kubectl --context gke_clover-sandbox_us-west1_sandbox-us-west1-cluster"
alias k9ssandbox="gcloud --project clover-sandbox container clusters get-credentials sandbox-us-west1-cluster --region us-west1 && https_proxy=sandbox-us-west1-cluster-privoxy.ilb.sbx.pdx12.clover.network:8118 k9s --context gke_clover-sandbox_us-west1_sandbox-us-west1-cluster"
alias kdev="https_proxy=dev-us-west1-cluster-privoxy.ilb.dev.pdx13.clover.network:8118 kubectl --context gke_clover-dev-kubernetes_us-west1_dev-us-west1-cluster"
alias k9sdev="gcloud --project clover-dev-kubernetes container clusters get-credentials dev-us-west1-cluster --region us-west1 && https_proxy=dev-us-west1-cluster-privoxy.ilb.dev.pdx13.clover.network:8118 k9s --context gke_clover-dev-kubernetes_us-west1_dev-us-west1-cluster"
alias kdevci="https_proxy=dev-ci-us-west1-cluster-privoxy.ilb.dev.pdx13.clover.network:8118 kubectl --context gke_clover-dev-kubernetes_us-west1_dev-ci-us-west1-cluster"
alias k9sdevci="https_proxy=dev-ci-us-west1-cluster-privoxy.ilb.dev.pdx13.clover.network:8118 k9s --context gke_clover-dev-kubernetes_us-west1_dev-ci-us-west1-cluster"
alias kadmin="https_proxy=admin-us-west1-cluster-privoxy.ilb.admin.pdx01.clover.network:8118 kubectl --context gke_clover-admin-plane_us-west1_admin-us-west1-cluster"
alias k9sadmin="gcloud --project clover-admin-plane container clusters get-credentials admin-us-west1-cluster --region us-west1 && https_proxy=admin-us-west1-cluster-privoxy.ilb.admin.pdx01.clover.network:8118 k9s --context gke_clover-admin-plane_us-west1_admin-us-west1-cluster"
alias kprod="https_proxy=prod-us-central1-cluster-privoxy.ilb.prod.dsm06.clover.network:8118 kubectl --context gke_clover-prod-kubernetes_us-central1_prod-us-central1-cluster"
alias k9sprod="gcloud --project clover-prod-kubernetes container clusters get-credentials prod-us-central1-cluster --region us-central1 && https_proxy=prod-us-central1-cluster-privoxy.ilb.prod.dsm06.clover.network:8118 k9s --context gke_clover-prod-kubernetes_us-central1_prod-us-central1-cluster"

# create immediate files if required and cd into that directory
function mkdr
{
  command mkdir -p $1 && cd $1
}

# saml login for LoyaltyOne
saml() {
	read -r -d '' VAR <<-EOF
		spawn python2 $HOME/code/apollo-platform/scripts/saml-login/cli_access_saml.py
		expect -ex Username:
		send -- kfaldu\r
		expect Password:
		stty -echo
		expect_user -re "(.*)\n"
		set password \$expect_out(1,string)
		stty echo
		send "\$password\r"
		expect Please
		send "${1:-3}\r"
		expect Please
		send "${2:-2}\r"
		expect AWS_DEFAULT_PROFILE
		exit
	EOF

	echo "$VAR" > /tmp/saml

	expect -f /tmp/saml

	rm /tmp/saml
}

# bastion login for Clover
b() {
	# if bastion user name is not passed, pick up default username - in some cases mac username is not same as clover username
	if [[ ( -z $2 ) ]]; then
		bastionUserName=krupesh.faldu
		# bastionUserName=$USER
	else
		bastionUserName=$2
	fi

	# echo the host dns entry, cut based on dot (.) pick up the third element which is the dataCenter
	dataCenter=$(echo $1 | cut -d. -f3)
	availableBastionHosts=($(curl -s  "https://infraapi.global.clover.network/mdb/v1/search?q=puppet.role%3Dbastion" | jq -r '.result[]' | grep ${dataCenter}))
	randomBastionHost=${availableBastionHosts[$RANDOM % ${#availableBastionHosts[@]}]}

	ssh -J $bastionUserName@$randomBastionHost $bastionUserName@$1
}

# clean terraform plan files for easier reading
tfcleanplan() {
	# if file name is not passed then just take the latest file
	if [[ ( -z $1 ) ]]; then
		terraformColoredPlanFileName=`ls -larth1 $HOME/downloads/run-*-plan-log*.txt | tail -1`
	else
		terraformColoredPlanFileName=$1
	fi
	# there is an escape character after s/ and before \[, sometimes copy paste does not take it so insert that character in your profile using Ctrl+V and then Esc key
	sed -i '' -e 's/\[[0-9;]*[a-zA-Z]//g' "$terraformColoredPlanFileName" && subl "$terraformColoredPlanFileName"
}
################################################################################
##### BASH-COMPLETIONS #####

# Use bash-completion, if available
# brew install bash-completion@2
# somehow git autocompletion does not work :(

# export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
# [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# below one is for `brew install bash-completion@2`
[[ $PS1 && -f /usr/local/share/bash-completion/bash_completion ]] && . /usr/local/share/bash-completion/bash_completion

# git autocompletion - https://git-scm.com/book/en/v1/Git-Basics-Tips-and-Tricks
# curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash
source ~/.git-completion.bash

## autocomplete aws commands
## its slow :( thats it other things are cool
complete -C aws_completer aws

## kubectl autocompletion - https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion
## upgrade bash to newer version - https://itnext.io/upgrading-bash-on-macos-7138bd1066ba
source <(kubectl completion bash)
# kubectl completion bash >/usr/local/etc/bash_completion.d/kubectl

## helm autocompletion
source <(helm completion bash)

# If fzf is available - source its bash file
# PUT THIS AT LAST BECAUSE IT DOES SOME OTHER CRAZY STUFF
# https://github.com/junegunn/fzf#using-homebrew-or-linuxbrew
# brew install fzf && $(brew --prefix)/opt/fzf/install
# use ** and then tab for auto completion for files - goes inside sub directories
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# vault autocomplete https://www.vaultproject.io/docs/commands/#autocompletion
complete -C /usr/local/bin/vault vault
################################################################################
# export PATH="/usr/local/opt/mongodb@3.4/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"

################################################################################
##### CLOVER #####

# Clover arc
# PATH=~/code/arcanist/bin/:~/code/clover-arc/bin/:$PATH
# source ~/code/arcanist/resources/shell/bash-completion

export WORKSPACE=/Users/krupeshf/code/perka
export M2_HOME=/Users/krupeshf/code/perka/dev/maven
export MAVEN_OPTS=-Xmx1024M
export PATH=/Users/krupeshf/code/perka/dev/bin:/bin:$PATH
export PATH=/Applications/Xcode.app/Contents/Developer/usr/libexec/git-core/:$PATH
export PATH=/usr/local/bin:$PATH
alias fastmvn='mvn -DskipTests -DskipDependencyAnalysis -DskipFindbugs install'
export PATH=/Applications/Postgres.app/Contents/Versions/10/bin:$PATH

# source $WORKSPACE/dev/bin/configure_js_exports.sh

ulimit -n 4096

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/krupeshf/google-cloud-sdk/path.bash.inc' ]; then . '/Users/krupeshf/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/krupeshf/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/krupeshf/google-cloud-sdk/completion.bash.inc'; fi

export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"

export LDFLAGS="-L/usr/local/opt/mysql-client/lib"
export CPPFLAGS="-I/usr/local/opt/mysql-client/include"

# to make arcanist use vi as default editor
export EDITOR="vim"

export CUS_WORKSPACE=$HOME/code/customers-microservice
alias cus.flyway='source $CUS_WORKSPACE/dev/bin/flyway.sh'
alias cus.init-db='source $CUS_WORKSPACE/dev/bin/init-db.sh'

export GROOVY_HOME=/usr/local/opt/groovy/libexec

export PATH="`/usr/libexec/java_home`/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

