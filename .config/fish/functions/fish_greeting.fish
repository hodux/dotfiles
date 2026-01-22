function fish_greeting
    # -f 437: Convert FROM Code Page 437 (DOS)
    # -t UTF-8: Convert TO modern UTF-8
    iconv -f 437 -t UTF-8 ~/.config/fish/art/ak-ice.ans
    
    fastfetch --key-padding-left 20
end
