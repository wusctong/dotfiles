function fish_greeting
    set -gx PATH $PATH /opt/nvim-linux-x86_64/bin
    starship init fish | source
    fastfetch
end
