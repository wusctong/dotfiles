function fish_greeting
    set -gx PATH $PATH ~/.local/bin
    set -gx PATH $PATH ~/.npm-global/bin
    set -gx PATH $PATH ~/Developer/devPATH
    set -gx PATH $PATH /opt/homebrew/bin
    set -gx PATH $PATH /opt/homebrew/sbin
    set -gx PATH $PATH /opt/homebrew/Cellar/zigup/2025.05.24/bin

    set -gx PKG_CONFIG_PATH $PKG_CONFIG_PATH (brew --prefix opencv)/lib/pkgconfig
    set -gx PKG_CONFIG_PATH $PKG_CONFIG_PATH (brew --prefix raylib)/lib/pkgconfig
    # set -gx CGO_CXXFLAGS "-DGOCV_NO_OPAQUE_HANDLES"
    # set -gx CGO_LDFLAGS "-Wl,-allow_multiple_definition"

    zoxide init fish | source
    starship init fish | source
    fish_config theme choose "Gruvbox Dark"

    clear
    fastfetch
    # cat ~/Developer/c++/lambdafetch/ascii.txt
    # echo (set_color yellow)"Welcome to Fish "(set_color red --bold)"<"(set_color yellow)">"(set_color bryellow)"<"(set_color normal)"."
end
