# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/krupesh.faldu/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  # all plugins are available here - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
  brew
  cp
  docker
  docker-compose
  iterm2
  mvn
  node
  npm
  macos
  pip
  python
  gcloud
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='vim'
# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

################################################################################
### CHANGES SPECIFIC TO KRUPESH ###

# zsh history
setopt APPEND_HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

# vi mode!
# very easy to navigate for bigger commands and overall awesomeness
set -o vi

# https://iterm2.com/documentation-shell-integration.html
# curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

################################################################################
##### AUTO COMPLETIONS #####

# If fzf is available - source its bash file
# https://github.com/junegunn/fzf#using-homebrew
# brew install fzf && $(brew --prefix)/opt/fzf/install
# use ** and then tab for auto completion for files - goes inside sub directories
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# https://www.terraform.io/docs/cli/commands/index.html#shell-tab-completion
# terraform -install-autocomplete
# terraform -uninstall-autocomplete
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/Cellar/tfenv/2.2.2/versions/0.12.31/terraform terraform

# https://www.vaultproject.io/docs/commands#autocompletion
# vault -autocomplete-install
complete -o nospace -C /usr/local/bin/vault vault

# https://helm.sh/docs/helm/helm_completion_zsh/
source <(helm completion zsh)

# https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/#optional-kubectl-configurations-and-plugins
source <(kubectl completion zsh)
complete -F __start_kubectl ksandbox
complete -F __start_kubectl kdev
complete -F __start_kubectl kdevci
complete -F __start_kubectl kadmin
complete -F __start_kubectl kprod
################################################################################
##### EXPORTS #####

# Node Versioning System - makes its easy to switch between node versions
# brew install nvm && mkdir $HOME/.nvm
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# Making go path inside home folder
export GOPATH=~/go

# Add nod_modules to executable path - this way all the modules installed in the application can be run directly
export PATH=$PATH:./node_modules/.bin

# Add home directory
export PATH=~/bin:$PATH

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Add MongoDb to path
# export PATH="$PATH:~/mongodb/bin"

# Add mysql client path
export PATH="/usr/local/opt/mysql-client/bin:$PATH"

# Awesome - this shows which are your change directory paths to look for - helpful in autocompletion
export CDPATH=.:~:~/code:~/src/apps

# Export default profile for aws command line - assumed_role is profile inside ~/.aws/credentials
# export AWS_PROFILE=assumed_role

# For terraform configuration file
export TF_CLI_CONFIG_FILE=~/terraform.rc

export CUS_WORKSPACE=$HOME/code/customers-microservice

################################################################################
##### ALIASES #####

# faster way to just clear the screen -->> press c and return key
alias c="clear"

# clean docker containers instances which are exited && prune some images
alias dclean="docker ps -q -f status=exited | xargs docker rm && docker image prune"

# listing
alias la='ls -larthG' # list it, hidden files, revererse order, timestamp, human readable size, colorized output
alias labc='ls -lap' # alphabetical sort

# Kill chrome if its taking too much memory or power
alias kchrome="killall -9 \"Google Chrome\""

# git
alias gg="git grep -n"
alias greset="git reset --hard HEAD"
alias gprunemaster="git remote prune origin && git branch --merged master --no-color | grep -v master | grep -v stable | xargs git branch -D"
alias gprunemain="git remote prune origin && git branch --merged main --no-color | grep -v main | grep -v stable | xargs git branch -D"
alias gmaster="git stash && git ch master && git pull && gprunemaster"
alias gmain="git stash && git ch main && git pull && gprunemain"

# just clean up stuff for clearing the icons - for sanity
alias clearIcons="sudo find . -type f -name \"Icon?\" -delete"

alias updateDailyLog="cd dailyLog && git add . && git co -m'm' && git push && git push gitlab master && cd -"

alias cleanupZshHistory="awk '!seen[$0]++' ~/.zsh_history | awk '!/^(git|cd|cat|touch|echo|brew|rm|less|subl|kill|cp|mv|gcloud|terraform|kubectl|helm|vault|docker|vi)/' ~/.zsh_history > temp.txt && mv temp.txt ~/.zsh_history"

# https://confluence.dev.clover.com/display/CO/Setting+up+production+SSH+access+with+yubikeys
# alias yubinit='eval `noglob ssh-agent -s -P /usr/local/lib/*,/usr/local/Cellar/yubico-piv-tool/*/lib/*.dylib`;ssh-add -s /usr/local/lib/libykcs11.dylib'
alias yubinit='eval `killall ssh-agent;noglob ssh-agent -s -P /usr/local/lib/*,/usr/local/Cellar/yubico-piv-tool/*/lib/*.dylib`;ssh-add -s /usr/local/lib/libykcs11.dylib'

# https://github.corp.clover.com/clover/gke-cluster-manager/wiki/Connecting-to-clusters#steps-for-kubectl-via-privoxy
alias ksandbox='https_proxy=sandbox-us-west1-cluster-privoxy.ilb.sbx.pdx14.clover.network:8118 kubectl --context gke_clover-sandbox_us-west1_sandbox-us-west1-cluster'
alias kdev="https_proxy=dev-us-west1-cluster-privoxy.ilb.dev.pdx13.clover.network:8118 kubectl --context gke_clover-dev-kubernetes_us-west1_dev-us-west1-cluster"
alias kdevci="https_proxy=dev-ci-us-west1-cluster-privoxy.ilb.dev.pdx13.clover.network:8118 kubectl --context gke_clover-dev-kubernetes_us-west1_dev-ci-us-west1-cluster"
alias kadmin="https_proxy=admin-us-west1-cluster-privoxy.ilb.admin.pdx01.clover.network:8118 kubectl --context gke_clover-admin-plane_us-west1_admin-us-west1-cluster"
alias kprod="https_proxy=prod-us-central1-cluster-privoxy.ilb.prod.dsm06.clover.network:8118 kubectl --context gke_clover-prod-kubernetes_us-central1_prod-us-central1-cluster"

# https://github.corp.clover.com/clover/gke-cluster-manager/wiki/Connecting-to-clusters#steps-for-k9s-via-privoxy
alias k9ssandbox='gcloud --project clover-sandbox-kubernetes container clusters get-credentials sandbox-us-west1-cluster --region us-west1 && https_proxy=sandbox-us-west1-cluster-privoxy.ilb.sbx.pdx14.clover.network:8118 k9s --context gke_clover-sandbox_us-west1_sandbox-us-west1-cluster'
alias k9sdev="gcloud --project clover-dev-kubernetes container clusters get-credentials dev-us-west1-cluster --region us-west1 && https_proxy=dev-us-west1-cluster-privoxy.ilb.dev.pdx13.clover.network:8118 k9s --context gke_clover-dev-kubernetes_us-west1_dev-us-west1-cluster"
alias k9sdevci="https_proxy=dev-ci-us-west1-cluster-privoxy.ilb.dev.pdx13.clover.network:8118 k9s --context gke_clover-dev-kubernetes_us-west1_dev-ci-us-west1-cluster"
alias k9sadmin="gcloud --project clover-admin-plane container clusters get-credentials admin-us-west1-cluster --region us-west1 && https_proxy=admin-us-west1-cluster-privoxy.ilb.admin.pdx01.clover.network:8118 k9s --context gke_clover-admin-plane_us-west1_admin-us-west1-cluster"
alias k9sprod="gcloud --project clover-prod-kubernetes container clusters get-credentials prod-us-central1-cluster --region us-central1 && https_proxy=prod-us-central1-cluster-privoxy.ilb.prod.dsm06.clover.network:8118 k9s --context gke_clover-prod-kubernetes_us-central1_prod-us-central1-cluster"

# create immediate files if required and cd into that directory
function mkdr
{
  command mkdir -p $1 && cd $1
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
  sed -i '' -e 's/\[[0-9;]*[a-zA-Z]//g' "$terraformColoredPlanFileName" && subl "$terraformColoredPlanFileName"
}

jenkins_lint() {
  JENKINS_URL=https://jenkins.corp.clover.com
  if [ -z "$1" ]; then
      JENKINSFILE=Jenkinsfile
  else
    JENKINSFILE="$1"
  fi
  #JENKINS_CRUMB=$(curl -s "$JENKINS_URL/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,\":\",//crumb)")
  curl -s -X POST  -F "jenkinsfile=<${JENKINSFILE}" $JENKINS_URL/pipeline-model-converter/validate
}

clover_bastions() {
   hosts=$(curl -s  "https://infraapi.global.clover.network/mdb/v1/search?q=puppet.role%3Dbastion" | jq -r '.result[]')
   echo $hosts > ~/.ssh/bastions.txt
   cat ~/.ssh/bastions.txt
}

# if new hosts are added, run this script
clover_hosts(){
  hosts=$(curl -s "https://infraapi.global.clover.network/mdb/v1/endpoints" | jq -r '.endpoints[]' | grep -v "@")
  echo $hosts > ~/.ssh/host_list.txt
}

# just overriding the default ssh fzf
# https://medium.com/@Temikus/gcp-ssh-autocomplete-with-fzf-and-zsh-3870192f6ac6
# https://github.com/junegunn/fzf/wiki/Examples-(completion)
# please note the `< <(` sequence its critical to do - https://github.com/junegunn/fzf#custom-fuzzy-completion
_fzf_complete_ssh() {
  ARGS="$@"
  if [[ $ARGS == 'ssh '* ]]; then
    _fzf_complete "--reverse --multi" "$@" < <(cat ~/.ssh/host_list.txt)
  else
    eval "zle ${fzf_default_completion:-expand-or-complete}"
  fi
}

# Clear docker containers and images
clear_docker() {
    echo "Clearing containers"
    docker container rm -f $(docker container ls -aq)

    echo "Clearing CI images"
    docker image rm -f $(docker image ls -a | grep 'container-registry' | awk '{print $3}')

    echo "Clearing layered images"
    docker image rm -f $(docker image ls -a | grep '<none>' | awk '{print $3}')
}

# Get cluster credentials
get_credentials() {
    case $1 in
        "dev")
            gcloud --project clover-dev-kubernetes container clusters get-credentials dev-us-west1-cluster --region us-west1
            ;;
        "devci")
            gcloud --project clover-dev-kubernetes container clusters get-credentials dev-ci-us-west1-cluster --region us-west1
            ;;
        "admin")
            gcloud --project clover-admin-plane container clusters get-credentials admin-us-west1-cluster --region us-west1
            ;;
        "prod")
            gcloud --project clover-prod-kubernetes container clusters get-credentials prod-us-central1-cluster --region us-central1
            ;;
        "sandbox")
            gcloud --project clover-sandbox-kubernetes container clusters get-credentials sandbox-us-west1-cluster --region us-west1
            ;;
    esac
}

# Drain node
drain_node() {
    case $1 in
        "dev")
            eval "kdev drain $2 --ignore-daemonsets --delete-local-data"
            ;;
        "ci")
            eval "kdevci drain $2 --ignore-daemonsets --delete-local-data"
            ;;
        "admin")
            eval "kadmin drain $2 --ignore-daemonsets --delete-local-data"
            ;;
        "prod")
            eval "kprod drain $2 --ignore-daemonsets --delete-local-data"
            ;;
        "sandbox")
            eval "ksandbox drain $2 --ignore-daemonsets --delete-local-data"
            ;;
    esac
}

tf_check() {
    echo "Running terraform init..."
    terraform init

    echo "Running terraform validate..."
    terraform validate

    echo "Running terraform fmt..."
    terraform fmt

    echo "Running terraform plan..."
    terraform plan
}

get_resources() {
    case $1 in
        "dev")
            for i in $(kdev api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
                echo "Resource:" $i " namespace: " $2
                kdev -n ${2} get ${i}
            done
            ;;
        ":ci")
            for i in $(kdevci api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
                echo "Resource:" $i " namespace: " $2
                kdev -n ${2} get ${i}
            done
            ;;
        "admin")
            for i in $(kadmin api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
                echo "Resource:" $i " namespace: " $2
                kdev -n ${2} get ${i}
            done
            ;;
        "prod")
            for i in $(kprod api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
                echo "Resource:" $i " namespace: " $2
                kdev -n ${2} get ${i}
            done
            ;;
        "sandbox")
            for i in $(ksandbox api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
                echo "Resource:" $i " namespace: " $2
                kdev -n ${2} get ${i}
            done
            ;;
    esac
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/krupesh.faldu/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/krupesh.faldu/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/krupesh.faldu/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/krupesh.faldu/google-cloud-sdk/completion.zsh.inc'; fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

