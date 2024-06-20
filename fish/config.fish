source $HOME/.atuin/bin/env.fish
fish_add_path ~/.local/bin
source ~/.asdf/asdf.fish
set -gx EDITOR nvim
alias vim="nvim"

if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init fish | source
end

