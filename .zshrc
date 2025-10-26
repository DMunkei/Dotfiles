fortune | cowsay
# export OM_ZSH="$HOME/.oh-my-zsh"
export ZSH="$HOME/.config/zsh/"
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
set -o emacs
bindkey '^X^E' edit-command-line

HISTSIZE=9999
SAVEHIST=9999

# plugins=(
#     history-substring-search
#     colored-man-pages
#     fzf-tab
# )

export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional

[ -f "$HOME/.config/zsh/plugins/plugins.sh" ] && source "$HOME/.config/zsh/plugins/plugins.sh"
[ -f "$HOME/.config/zsh/aliases.zsh" ] && source "$HOME/.config/zsh/aliases.zsh"
[ -f "$HOME/.config/zsh/completions.zsh" ] && source "$HOME/.config/zsh/completions.zsh"


export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=$PATH:~/.scripts/
export PATH="/opt/homebrew/opt/node@18/bin:$PATH"
export PYTHONBREAKPOINT=ipdb.set_trace  


eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export EDITOR=/opt/homebrew/bin/nvim

# Move cursor forward by a word
bindkey '^[[1;3C' forward-word   # Ctrl+Right Arrow
# Move cursor backward by a word
bindkey '^[[1;3D' backward-word  # Ctrl+Left Arrow
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

eval $(thefuck --alias)
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"

. "$HOME/.local/bin/env"
