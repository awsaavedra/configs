# ~/.bash_profile — login shell entry point (macOS + Linux)
# Sources .bashrc for all interactive config (aliases, PS1, functions).
# Only login-shell-specific or macOS-specific settings live here.

[[ -s ~/.bashrc ]] && source ~/.bashrc

# macOS BSD ls color (harmless on Linux; GNU ls uses CLICOLOR_FORCE or --color)
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
