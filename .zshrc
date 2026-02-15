fortune

autoload -U edit-command-line

zle -N edit-command-line

bindkey -M vicmd v edit-command-line
# Move cursor forward by a word
bindkey '^[[1;3C' forward-word   # Ctrl+Right Arrow
# Move cursor backward by a word
bindkey '^[[1;3D' backward-word  # Ctrl+Left Arrow
bindkey '^X^E' edit-command-line

set -o emacs

HISTSIZE=9999999999
SAVEHIST=9999999999

[ -f "$HOME/.config/zsh/plugins/plugins.sh" ] && source "$HOME/.config/zsh/plugins/plugins.sh"
[ -f "$HOME/.config/zsh/aliases.zsh" ] && source "$HOME/.config/zsh/aliases.zsh"
[ -f "$HOME/.config/zsh/completions.zsh" ] && source "$HOME/.config/zsh/completions.zsh"


export CARAPACE_BRIDGES='zsh' # optional
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=$PATH:~/.scripts/
export PYTHONBREAKPOINT=ipdb.set_trace  
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export EDITOR=/opt/homebrew/bin/nvim

export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/opt/homebrew/opt/node@18/bin:$PATH"
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"


. "$HOME/.local/bin/env"

set_db ()
{
  bat ~/Development/QuestBackend/.env | sed -i '' "s/DB_NAME.*/DB_NAME='$1'/" .env
}

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(uv --generate-shell-completion zsh)"
