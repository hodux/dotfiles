function fish_prompt
    # Capture the exit status of the last command immediately
    set -l last_status $status
    
    # Symbols (Requires a Nerd Font)
    set -l separator ""
    set -l branch_icon ""
    set -l nixos_icon ""

    # Define standard colors that will inherit perfectly from your terminal theme
    set -l os_bg magenta
    set -l os_fg black
    set -l dir_bg blue
    set -l dir_fg black
    set -l git_bg cyan
    set -l git_fg black
    set -l err_bg red
    set -l err_fg black

    # --- 1. NixOS Logo Segment ---
    set_color -b $os_bg $os_fg
    echo -n " $nixos_icon "
    
    # Track the background color for smooth Powerline transitions
    set -l current_bg $os_bg

    # --- 2. Directory Segment ---
    # Transition: OS Logo -> Directory
    set_color -b $dir_bg $current_bg
    echo -n $separator

    # Content: Directory
    set_color -b $dir_bg $dir_fg
    echo -n " "(prompt_pwd)" "
    set current_bg $dir_bg

    # --- 3. Git Segment ---
    set -l git_branch (command git branch --show-current 2>/dev/null)
    if test -n "$git_branch"
        # Transition: Directory -> Git
        set_color -b $git_bg $current_bg
        echo -n $separator
        
        # Content: Git
        set_color -b $git_bg $git_fg
        echo -n " $branch_icon $git_branch "
        set current_bg $git_bg
    end

    # --- 4. Error Status Segment ---
    if test $last_status -ne 0
        # Transition: Previous -> Error
        set_color -b $err_bg $current_bg
        echo -n $separator
        
        # Content: Error code
        set_color -b $err_bg $err_fg
        echo -n " ✘ $last_status "
        set current_bg $err_bg
    end

    # --- 5. Final Transition ---
    set_color -b normal $current_bg
    echo -n $separator
    
    # Reset text formatting and add a space for typing
    set_color normal
    echo -n " "
end
