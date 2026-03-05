{ config, pkgs, ... }:

{
  imports = [
    ./modules/homeModules/base/shell.nix
    ./modules/homeModules/base/waybar.nix
    ./modules/homeModules/base/starship.nix
    ./modules/homeModules/base/bat.nix
    ./modules/homeModules/base/git.nix
    ./modules/homeModules/base/kitty.nix
    ./modules/homeModules/base/nixTools.nix
    ./modules/homeModules/base/yazi.nix
  ];

  home.username = "jawknee";
  home.homeDirectory = "/home/jawknee";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    home-manager
    unzip
    gcc
    gnumake
    loupe
    unrar
    p7zip

    # Terminal Tools
    kitty
    neovim
    lsd
    fzf
    fastfetch
    wl-clipboard
    cliphist

    # Apps
    floorp-bin
    vlc
    mpv
    localsend
    xfce.thunar
    zed-editor

    # Desktop
    waybar
    mako
    swaylock-effects
    fuzzel
    swww
    hyprpolkitagent
    swaybg

    # Themes
    adwaita-icon-theme
    gnome-themes-extra
    
    # Language Servers (LSPs)
    lua-language-server
    nil 
    pyright 
    vscode-langservers-extracted
    nodePackages.typescript-language-server
    clang-tools
    tailwindcss-language-server
    jdt-language-server
    nodejs_22

    #Development tools
    mongodb-compass
    postman #handle api requests
  ];

  stylix.enableReleaseChecks = false;
  # This tells Home Manager to manage itself
  programs.home-manager.enable = true;
  services.cliphist.enable = true; #this automatically starts ( wl-paste --watch cliphist store )



}
