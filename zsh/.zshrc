colorscript random
fortune

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="spaceship"

export SRC_ACCESS_TOKEN=sgp_304bf449d8889942cbc1473bdec5392608896dae
export SRC_ENDPOINT=https://sourcegraph.com 

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

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
    git
    history-substring-search
    colored-man-pages
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf-tab
    zsh-z
)

source $ZSH/oh-my-zsh.sh
# source ~/.config/zsh_config/fzf-tab.plugin.zsh

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
#
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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias zrc="nvim ~/.zshrc"
alias brc="nvim ~/.bashrc"
alias szrc="source ~/.zshrc"
alias sbrc="source ~/.bashrc"


alias alac="nvim ~/.config/alacritty/alacritty.toml"
alias cdnv="cd ~/.config/nvim/"
alias n="nvim ."
alias vim="nvim"

alias act="source ./venv/bin/activate"
alias dev="cd ~/Development/"
alias odev="cd ~/Development/oletv2/"
alias ost="cd ~/Development/ostip_django/"
alias zew="cd ~/Development/zew_arbeitswelt_2023/"

alias pms="python manage.py shell"
alias pmr="python manage.py runserver"
alias pmm="python manage.py makemigrations"
alias pm="python manage.py migrate"
alias pt="pytest"
alias ptv="pytest -v"
alias ptrp="pytest -rP"

alias gs="git status"
alias ga="git add ."
alias gc="git commit"
alias gd="git diff"
alias gr="git reflog"
alias gl="git log"
alias glg="git log --pretty='%C(cyan)%ad %C(yellow)%h %C(blue)%aN %C(red)%d %Creset%s' --all --date-order --graph --date=iso"
alias glo="git log --oneline --pretty='%C(cyan)%ad %C(yellow)%h %C(blue)%aN %C(red)%d %Creset%s' --all --date=iso"
alias gp="git push"
alias gb="git branch"
alias lg="lazygit"

alias spam="pacman -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias spu=" sudo pacman -Syu"
alias ..="cd ../"
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias ght='xclip -sel c < ~/uni/githubtoken.txt'

alias leetcode='cd ~/Development/leetcode/'
alias aoc='cd ~/Development/AOC/aoc2022/rustacean'

#TMUX
alias odv='~/.config/tmux/olet-dev-shell.sh'
alias ostdev='~/.config/tmux/ost-dev-shell.sh'
alias zdv='~/.config/tmux/zew-dev-shell.sh'

alias ta='tmux attach-session'
alias tks='tmux kill-session'

export LC_ALL=en_US.utf8
export PATH=$PATH:/opt/pycharm-2020.2.3/bin/
export PATH=$PATH:~/.scripts/
export PATH=$PATH:~/go/bin/

export GTK_IM_MODULE='fcitx'
export QT_IM_MODULE='fcitx'
export SDL_IM_MODULE='fcitx'
export XMODIFIERS='@im=fcitx'

alias ship_it="git push"
