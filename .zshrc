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

eval `dircolors ~/.dircolors`

# aliases
alias ll='ls -l'
alias ls='ls -F --color=auto --show-control-chars' 

alias mci='mvn clean install'
alias qi='mvn clean install -DskipTests'
alias mee='mvn eclipse:eclipse -DdownloadSources=true -DdownloadJavadocs=true -Declipse.useProjectReferences=false -U'
alias mec='mvn eclipse:clean'
alias rebuild='mvn clean eclipse:clean; mvn install -DskipTests; mvn eclipse:eclipse'
alias mcs='mvn clean site'

#alias node='winpty node.exe'

alias gcam='git add . && git commit -m'
alias gs='git status'
alias gp='git push'
alias gf='git fetch --all'
