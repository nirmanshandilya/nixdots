{ config, pkgs, inputs, ... }:

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
    ./modules/homeModules/base/swaylock.nix
  ];

  home.username = "jawknee";
  home.homeDirectory = "/home/jawknee";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    unzip
    gcc
    gnumake
    loupe
    unrar
    p7zip

    # Terminal Tools
    neovim
    lsd
    fzf
    fastfetch
    wl-clipboard
    cliphist
    tty-clock
    zellij

    # Apps
    mpv
    localsend
    zed-editor
    inputs.zen-browser.packages.${pkgs.system}.default

    # Desktop
    mako
    swaylock-effects

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
