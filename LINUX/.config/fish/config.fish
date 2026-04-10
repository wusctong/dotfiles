fish_add_path /opt/cuda/bin
fish_add_path ~/.cargo/bin

set -x LD_LIBRARY_PATH /opt/cuda/lib64 $LD_LIBRARY_PATH
set -x LIBGL_ALWAYS_INDIRECT 0
set -x __GLX_VENDOR_LIBRARY_NAME nvidia
set -x GALLIUM_DRIVER d3d12
set -x LIBVA_DRIVER_NAME d3d12

zoxide init fish | source
starship init fish | source

function fish_greeting
    fish_config theme choose catppuccin-mocha --color-theme=dark
    clear
    fastfetch
end
