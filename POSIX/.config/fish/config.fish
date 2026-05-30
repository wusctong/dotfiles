fish_add_path ~/.local/bin
fish_add_path ~/.npm-global/bin
fish_add_path ~/Developer/devPATH
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path ~/.cargo/bin

set -x PKG_CONFIG_PATH \
    (brew --prefix)/lib/pkgconfig \
    (brew --prefix)/share/pkgconfig \
    $PKG_CONFIG_PATH

zoxide init fish | source
starship init fish | source

function starship_cursor_fix --on-event fish_prompt
    echo -ne '\e[2 q'
end

function fish_greeting
    fish_config theme choose catppuccin-mocha
    clear
    fastfetch
end
