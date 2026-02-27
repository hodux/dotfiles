function fish_right_prompt
    # Symbols (Requires a Nerd Font)
    set -l right_separator ""
    set -l start_separator ""
    set -l clock_icon ""
    set -l dur_icon "󱎫"

    # Define standard colors
    set -l time_bg brblack
    set -l time_fg white
    set -l dur_bg yellow
    set -l dur_fg black

    # --- 1. Format Command Duration ---
    set -l duration_text ""
    # Only show duration if it took longer than 100 milliseconds
    if test -n "$CMD_DURATION" -a "$CMD_DURATION" -gt 100
        if test $CMD_DURATION -gt 3600000
            set -l hrs (math -s0 "$CMD_DURATION / 3600000")
            set -l mins (math -s0 "($CMD_DURATION % 3600000) / 60000")
            set duration_text " $dur_icon $hrs h $mins m "
        else if test $CMD_DURATION -gt 60000
            set -l mins (math -s0 "$CMD_DURATION / 60000")
            set -l secs (math -s0 "($CMD_DURATION % 60000) / 1000")
            set duration_text " $dur_icon $mins m $secs s "
        else if test $CMD_DURATION -gt 1000
            set -l secs (math -s1 "$CMD_DURATION / 1000")
            set duration_text " $dur_icon $secs s "
        else
            set duration_text " $dur_icon $CMD_DURATION ms "
        end
    end

    # --- 2. Current Time ---
    set -l current_time (date "+%H:%M:%S")

    # --- 3. Build the Right Prompt ---
    
    # If we have a duration to show:
    if test -n "$duration_text"
        # Start with rounded edge in duration color
        set_color $dur_bg
        echo -n $start_separator
        
        # Duration content
        set_color -b $dur_bg $dur_fg
        echo -n $duration_text
        
        # Transition: Duration -> Time
        set_color -b $dur_bg $time_bg
        echo -n $right_separator
    else
        # If no duration, just start with rounded edge in time color
        set_color $time_bg
        echo -n $start_separator
    end
    
    # Time content
    set_color -b $time_bg $time_fg
    echo -n " $clock_icon $current_time "
    
    # Clear formatting
    set_color normal
end
