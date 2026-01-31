function fish_greeting
    set -gx PATH $PATH ~/.local/bin
    set -gx PATH $PATH ~/.npm-global/bin
    set -gx PATH $PATH ~/Developer/devPATH
    set -gx PATH $PATH /opt/homebrew/bin
    set -gx PATH $PATH /opt/homebrew/sbin
    zoxide init fish | source
    starship init fish | source
    fish_config theme choose "Catppuccin Mocha"

    clear
    fastfetch
    # cat ~/Developer/c++/lambdafetch/ascii.txt
    # echo (set_color yellow)"Welcome to Fish "(set_color red --bold)"<"(set_color yellow)">"(set_color bryellow)"<"(set_color normal)"."
end
