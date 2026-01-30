export MTL_HUD_ENABLED=1
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi
export PATH=$PATH:~/.local/bin
export PATH="HOME/miniconda3/bin:$PATH"
export PATH="HOME\miniconda3/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/Developer/devPATH:$PATH"

eval "$(zoxide init zsh)"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# starship
eval "$(starship init zsh)"

# auto neofetch
if [[ $- == *i* ]] && [[ -z "$SSH_CONNECTION" ]]; then
  clear
  fastfetch
fi
