# ~/.zshrc

# set antibody and load plugins
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

# autocompletions
autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

zmodload -i zsh/complist

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

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

#connect to windows docker daemon
export DOCKER_HOST=tcp://localhost:2375

eval `dircolors ~/.dircolors`

# aliases
 # ls
alias ll='ls -l'
alias ls='ls -F --color=auto --show-control-chars' 

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
alias gf='git fetch --all'
alias gitpurge='git fetch --all -p; git branch -vv | grep ": gone]" | awk '{ print $1 }' | xargs -n 1 git branch -d'

ssh() {
	if [[ $@ == "help" ]]; then
		command echo -e "Available Domains:\nprovide\nsolm64\nintgm\n1501eng\n1501expkg\nsolgm\ns18bx\neng18\nexp18\ndeveng"
	elif [[ $@ == "provide" ]]; then
		command ~/.ssh/selflogin.sh spoon.ip.devcerner.net
	elif [[ $@ == "solm64" ]]; then
		command ~/.ssh/login.sh cerner root solm64.ip.devcerner.net
	elif [[ $@ == "intgm" ]]; then
		command ~/.ssh/selflogin.sh ipint1.ip.devcerner.net
	elif [[ $@ == "1501eng" ]]; then
		command ~/.ssh/selflogin.sh ip1501ar.ip.devcerner.net
	elif [[ $@ = "1501expkg" ]]; then
		command ~/.ssh/login.sh trogdor mcstest ip1501ep.northamerica.cerner.net
	elif [[ $@ = "solgm" ]]; then
		command ~/.ssh/selflogin.sh ipsol3.ip.devcerner.net
	elif [[ $@ = "s18bx" ]]; then
		command ~/.ssh/selflogin.sh ips18bx.ip.devcerner.net
	elif [[ $@ = "eng18" ]]; then
		command ~/.ssh/selflogin.sh ipara1.ip.devcerner.net
	elif [[ $@ = "exp18" ]]; then
		command ~/.ssh/login.sh sv055015 sv055015 ipexp18app.northamerica.cerner.net
	elif [[ $@ = "deveng" ]]; then
		command ~/.ssh/login.sh ae060571 ae060571 deveng1.ip.devcerner.net
	else
		command ssh "$@"
	fi		
}

scp() {
	if [[ $@ = "help" ]]; then
		command echo scp domainName fileName serverFolder
	elif [[ $1 == "provide" ]]; then
		command scp $2 ae060571@spoon.ip.devcerner.net:/cerner/w_standard/provide/java/$3
	else
		command scp "$@"
	fi
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/ant/.sdkman"
[[ -s "/home/ant/.sdkman/bin/sdkman-init.sh" ]] && source "/home/ant/.sdkman/bin/sdkman-init.sh"
