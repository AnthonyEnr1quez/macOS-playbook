# ~/.zshrc

# set antibody
source <(antibody init)

# autocompletions
autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

zmodload -i zsh/complist

# load plugins, themes
antibody bundle < ~/.zsh_plugins.txt

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell

setopt auto_cd # cd by typing directory name if it's not a command

setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

# rebind delete key, will test w/ windows soon
#bindkey '^[[3~' delete-char
#bindkey '^[3;5~' delete-char

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

eval `gdircolors ~/.dircolors`

# aliases
  # dotfile config https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/local/bin/git --git-dir=$HOME/.config/ --work-tree=$HOME'
 # ls
alias ll='ls -l'
alias ls='ls -F -G' 
 # mvn
alias mci='mvn clean install'
alias qi='mvn clean install -DskipTests'
alias mee='mvn eclipse:eclipse -DdownloadSources=true -DdownloadJavadocs=true -Declipse.useProjectReferences=false -U'
alias mec='mvn eclipse:clean'
alias rebuild='mvn clean eclipse:clean; mvn install -DskipTests; mvn eclipse:eclipse'
alias mcs='mvn clean site'
alias mfr='mvn release:prepare -DdryRun=true'
alias mr='mvn release:prepare'
alias mcc='mvn clean compile'
alias mcp='mvn clean package -DskipTests'

 #git
alias gcam='git add . && git commit -m'
alias gs='git status'
alias gp='git push'
alias gpsu='git branch --show-current| xargs git push --set-upstream origin' 
alias gf='git fetch --all'
alias gitpurge='git fetch --all -p; git branch -vv | grep ": gone]" | awk "{ print $1 }" | xargs -n 1 git branch -D'
alias agcam='git add . && git -c user.name="AnthonyEnr1quez" -c user.email="aenriquez_dev@icloud.com" commit -m'
alias gfu='git fetch upstream && git checkout master && git rebase upstream/master'

 #intellij
alias idea='open -na "IntelliJ IDEA.app" --args "$@"'

# ford proxy settings
proxyHost=internet.ford.com
proxyPort=83
httpProxyUrl="http://$proxyHost:$proxyPort"
noProxies='127.0.0.1|localhost|*.github.ford.com|*.nexus.ford.com|*.sonarqube.ford.com|*.dearborn.ford.com|app-concourse.cf.ford.com'
initialize(){
 export LOCAL_REPOS_DIR="$HOME/Projects"
 export LOCAL_CLOUD_CONFIG_BOOTSTRAP='true'
 export ORG_GRADLE_PROJECT_nexus_user='CSDNNEXS'
 export ORG_GRADLE_PROJECT_nexus_password='KWABew@3y'
 export ORG_GRADLE_PROJECT_repository='ford_csdn_private_snapshot_repository'
}
setproxies(){
 export no_proxy="${noProxies//|/,}"
 export NO_PROXY="${noProxies//|/,}"
 export http_proxy="$httpProxyUrl"
 export https_proxy="$httpProxyUrl"
 export HTTP_PROXY="$httpProxyUrl"
 export HTTPS_PROXY="$httpProxyUrl"
 export JAVA_TOOL_OPTIONS="-Dhttp.proxyHost=$proxyHost -Dhttp.proxyPort=$proxyPort -Dhttps.proxyHost=$proxyHost -Dhttps.proxyPort=$proxyPort -Dhttp.nonProxyHosts=\"$noProxies\""
echo "Host *
 ProxyCommand nc -X connect -x $proxyHost:$proxyPort %h %p" > ~/.ssh/config
}
unsetproxies(){
 unset no_proxy
 unset NO_PROXY
 unset http_proxy
 unset https_proxy
 unset HTTP_PROXY
 unset HTTPS_PROXY
 unset JAVA_TOOL_OPTIONS
 unset JAVA_OPTS
 rm ~/.ssh/config
}
initialize
setproxies
