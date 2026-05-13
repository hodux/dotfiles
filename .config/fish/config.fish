set -gx PATH $PATH $HOME/.krew/bin

if status is-interactive
    # Commands to run in interactive sessions can go here

    # Direnv + Zoxide
    zoxide init fish | source
    eval (direnv hook fish)

    # aliases
    alias vim nvim
    alias ses sesh
    # pretty ls
    alias ls='eza --icons --group-directories-first'

    # Abbrs
    abbr k kubectl

end
