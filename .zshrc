
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/kouha/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


#--------------------------------------------------------------------------
export PATH=/usr/bin/:/usr/local/bin/:/usr/local/sbin:$PATH
export PATH=/usr/local/Cellar/vim/8.2.3025/bin:$PATH

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init -)"

export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.nodebrew/current/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
# export PATH="$HOME/.config/.zsh:$PATH"

# [[ -d ~/.rbenv  ]] && \
#   export PATH=${HOME}/.rbenv/bin:${PATH} && \
#   eval "$(rbenv init -)"


# alias gull=git pull --rebase origin $(git branch | grep "" |  sed -e "s/^\\s*//g"  )

##-tns-completion-start-###
if [ -f /Users/kouha/.tnsrc ]; then
   source /Users/kouha/.tnsrc
fi


function fdk(){
  if [[ $1 = "" ]]; then
    docker ps |
    fzf |
    awk '{ print $1 }' |
    tr -d '\n' |
    tee >(pbcopy)
  elif [[ $1 = "kill" ]]; then
    docker kill -9 $(fdk)
  elif [[ $1 = "exec" ]]; then
    docker exec -it $(fdk) bash
  fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# aliases
alias n='nvim'
alias gpm='git pull origin master'
alias ga='git add .'
alias gs='git status'
alias gc='(){git commit -m "$1"}'

# ghq + peco
alias g='cd $(ghq root)/$(ghq list | grep -v "_tmp" | peco)'
alias gopen='hub browse $(ghq list | grep -v "_tmp" | peco | cut -d "/" -f 2,3)'

function ghqf {
    cd $(ghq list -p | fzf)
}

# github repository create
function ghcr {
    echo "Repository name: " && read name;
    echo "Repository description: " && read description;
    gh repo create ${name} --private -d ${description}
    ghq get git@github.com:aganomaminmi/${name}.git
    cd ~/src/github.com/aganomaminmi/${name}
    gh gitignore
    gsed -e '$ a .DS_Store' -i .gitignore
    ga
    git commit -m "Initial commit"
    gpsh
}
