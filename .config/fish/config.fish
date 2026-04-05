set -gx PATH $PATH $HOME/.krew/bin

if status is-interactive
    # Commands to run in interactive sessions can go here

    # Starship custom prompt
    # starship init fish | source

    # doom
    fish_add_path ~/.config/emacs/bin

    # Direnv + Zoxide
    zoxide init fish | source
    eval (direnv hook fish)

    # Better ls
    alias ls='eza --icons --group-directories-first'

    # CLI
    alias k kubectl

    # Editors
    alias zed zeditor
    alias h hx
    alias n nvim

    # Git
    alias gs 'git status'
    alias ga 'git add'
    alias gc 'git commit'
    alias gp 'git push'
    alias gl 'git log'
    alias gd 'git diff'
    alias gb 'git blame'

    # Abbrs
    # abbr vim 'nvim'
    # abbr v 'nvim'
    # abbr n 'nvim'

    # cat ~/.local/state/caelestia/sequences.txt 2> /dev/null
end
