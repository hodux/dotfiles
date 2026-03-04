set -gx PATH $PATH $HOME/.krew/bin

if status is-interactive
    # Commands to run in interactive sessions can go here

    # Starship custom prompt
    # starship init fish | source

    # Direnv + Zoxide
    zoxide init fish | source
    eval (direnv hook fish)

    # Better ls
    alias ls='eza --icons --group-directories-first'
    alias k='kubectl'
    alias vim 'zeditor'
    alias v 'zeditor'
    alias n 'zeditor'
    alias zed "zeditor"

    # Abbrs
    # abbr vim 'nvim'
    # abbr v 'nvim'
    # abbr n 'nvim'

    # cat ~/.local/state/caelestia/sequences.txt 2> /dev/null
end
