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
# export JWT_TOKEN=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Ikg5bmo1QU9Tc3dNcGhnMVNGeDdqYVYtbEI5dyIsImtpZCI6Ikg5bmo1QU9Tc3dNcGhnMVNGeDdqYVYtbEI5dyJ9.eyJhdWQiOiJhcGk6Ly85M2E5NjdkYy0xOThhLTRlZmUtYTk1Yi1iYWQxOGU4ODZhYWQiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC84ZmJkZWIyMC0xMzhlLTQzMzktYmE2Yi01ZmVhMWU2ZWZiNTQvIiwiaWF0IjoxNzI2NjQ5NTQwLCJuYmYiOjE3MjY2NDk1NDAsImV4cCI6MTcyNjY1NDE4OCwiYWNyIjoiMSIsImFpbyI6IkFWUUFxLzhYQUFBQVh2Uy9nWm5TME1VNWVjYmkzeVFuT1hTY2RQbmMzYXB1amxuSElvQ1pEemo5NS8vQjhuRVFjR2l4aTJQcjZPVERXdFE1MzZ1Qk5COVM1YTFIbSs0NVZPQlVsaFE1L3ZDdDB4NkxqOFdRMTE0PSIsImFtciI6WyJwd2QiLCJtZmEiXSwiYXBwaWQiOiI5M2E5NjdkYy0xOThhLTRlZmUtYTk1Yi1iYWQxOGU4ODZhYWQiLCJhcHBpZGFjciI6IjAiLCJkZXZpY2VpZCI6IjM2ODRmODgyLTY2MzAtNGYwZS1hYzM4LTUzZTE4MjUxYjIyNSIsImZhbWlseV9uYW1lIjoiS8O2c3RsZXIiLCJnaXZlbl9uYW1lIjoiRG9taW5pcXVlIEFtaXIiLCJpcGFkZHIiOiIxOTQuOC4yMTcuMTU4IiwibmFtZSI6IkvDtnN0bGVyIERvbWluaXF1ZSBBbWlyIiwib2lkIjoiODMzNjNhZDQtMmFhMy00MzZjLTkyZDktOTllZmZhYzU4ZmM5Iiwib25wcmVtX3NpZCI6IlMtMS01LTIxLTE1NzkzODU4OTEtMTU4NzU1MTc5OC0yMTIyNTA3NTM3LTE0ODcyNSIsInJoIjoiMC5BU0FBSU91OWo0NFRPVU82YTFfcUhtNzdWTnhucVpPS0dmNU9xVnU2MFk2SWFxMGdBQWsuIiwic2NwIjoiY3VzdG9tLnJlYWQiLCJzdWIiOiJ5ZVV5ZU1aUUVxN3VlT1I2X3ozd0FpT2tzYWZRdTNxY2FBU2tEQngtN1MwIiwidGlkIjoiOGZiZGViMjAtMTM4ZS00MzM5LWJhNmItNWZlYTFlNmVmYjU0IiwidW5pcXVlX25hbWUiOiJES29lc3RsZXJAc3Ryb2Vlci5kZSIsInVwbiI6IkRLb2VzdGxlckBzdHJvZWVyLmRlIiwidXRpIjoiOWdMUE5NNnBWMFNidk1uWGtpQVZBQSIsInZlciI6IjEuMCJ9.BSKoKRV9wy3OH9VmI1qQ5rHBxuRbQxN3N14RLjcJWC4gMeJzsVOuYujt3EZR0JsagZK6soS4IdgRlpLTgPMog54Rm5KSUKqqps32hh5nM_tYjkJOfkYcWUADv_0PIT7tRtI6iLEIPJnI4lHH22sPBKNcoWk0l7fTuYxeLa5wbaBVeIs2k35RsLsE_4IP3OgX1FUvtXa55l9vh_8t0KC5YhSIz6QYkF5j4ct_uqW3qm0Aqrkl5aKPxXKabbrjlebsOmbP7mw6lE23JPsyQXLGD3rU2yYEwg2wld2s9HYqY6qJwz6ehaWRcYisGRovx-gNzHyZwC_LqxfQ5iTXHUL5lA

# Move cursor forward by a word
bindkey '^[[1;3C' forward-word   # Ctrl+Right Arrow
# Move cursor backward by a word
bindkey '^[[1;3D' backward-word  # Ctrl+Left Arrow
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

eval $(thefuck --alias)
