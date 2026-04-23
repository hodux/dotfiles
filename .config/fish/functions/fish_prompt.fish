function fish_prompt
    set -l last_status $status
    
    # Symbols
    set -l separator ""        # Standard triangle
    set -l separator_round ""  # Rounded cap (U+E0B4)
    set -l branch_icon ""

    # Colors
    set -l os_bg magenta
    set -l os_fg black
    set -l dir_bg blue
    set -l dir_fg black
    set -l git_bg cyan
    set -l git_fg black
    set -l err_bg red
    set -l err_fg black

    # 1. NixOS Logo
    # set_color -b $os_bg $os_fg
    # echo -n " $nixos_icon "
    # set -l current_bg $os_bg

    # 2. Directory
    set_color -b $dir_bg $current_bg
    # echo -n $separator
    set_color -b $dir_bg $dir_fg
    echo -n " "(prompt_pwd)" "
    set current_bg $dir_bg

    # 3. Git
    set -l git_branch (command git branch --show-current 2>/dev/null)
    if test -n "$git_branch"
        set_color -b $git_bg $current_bg
        echo -n $separator
        set_color -b $git_bg $git_fg
        echo -n " $branch_icon $git_branch "
        set current_bg $git_bg
    end

    # 4. Error Status
    if test $last_status -ne 0
        set_color -b $err_bg $current_bg
        echo -n $separator
        set_color -b $err_bg $err_fg
        echo -n " ✘ $last_status "
        set current_bg $err_bg
    end

    # --- 5. Final Transition (The Rounded Tip) ---
    # We set the foreground to the previous background color 
    # and the background to 'normal' to create the curve effect.
    set_color normal
    set_color $current_bg
    echo -n $separator
    
    set_color normal
    echo -n " "
end
