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
    ./modules/homeModules/base/niri.nix
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
    nh

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
    helix

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

  # This tells Home Manager to manage itself
  programs.home-manager.enable = true;

  services.cliphist.enable = true; #this automatically starts ( wl-paste --watch cliphist store )

stylix = {
  enable = true;
  enableReleaseChecks = false;
  image = ./wallpapers/clouds.png;
  base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  polarity = "dark";

  cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  fonts = {
    monospace = {
      package = pkgs.maple-mono.NF;
      name = "Msple Mono NF";
    };
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };
    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };
    emoji = {
      package = pkgs.noto-fonts-color-emoji;
      name = "Noto Color Emoji";
    };
    sizes = {
      applications = 12;
      terminal = 13;
      desktop = 11;
      popups = 10;
    };
  };
};


}
