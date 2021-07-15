# ~/.zshrc

# set antibody and load plugins
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

# spaceship prompt options
SPACESHIP_GRADLE_JVM_SHOW=false

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
