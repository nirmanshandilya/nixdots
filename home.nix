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
  home.sessionVariables = {
    LANG = "en_US.UTF-8";
};

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
    btop
    htop
    
    #Productivity

    # Apps
    mpv
    localsend
    vscode
    helix
    inputs.zen-browser.packages.${pkgs.system}.default

    # Desktop
    mako
    swaylock-effects
    cava

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

    # Development tools
    mongodb-compass
    postman #handle api requests

  ];

  # This tells Home Manager to manage itself
  programs.home-manager.enable = true;
  programs.fuzzel.enable = true;
  services.cliphist.enable = true; #this automatically starts ( wl-paste --watch cliphist store )

stylix = {
  enable = true;
  enableReleaseChecks = false;
  image = ./wallpapers/fields-clouds.jpg;
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
      terminal = 14;
      desktop = 11;
      popups = 10;
    };
  };
};


      # Cava script for waybar capsule
      home.file.".config/cava/config" = {
        force = true;
        text = ''
          [general]
          bars = 10
      
          [output]
          method = raw
          ascii_max_range = 7
          raw_target = /dev/stdout
          data_format = ascii
          ascii_max_range = 7
        '';
      };
      home.file.".config/waybar/cava.sh" = {
        executable = true;
        text = ''
          #!/bin/sh
          cava 2>/dev/null | while IFS= read -r line; do
            out=""
            while IFS=';' read -r -a bars <<< "$line"; do
              for val in "''${bars[@]}"; do
                case "$val" in
                  0) out="''${out}▁" ;;
                  1) out="''${out}▂" ;;
                  2) out="''${out}▃" ;;
                  3) out="''${out}▄" ;;
                  4) out="''${out}▅" ;;
                  5) out="''${out}▆" ;;
                  6) out="''${out}▇" ;;
                  7) out="''${out}█" ;;
                  *) out="''${out}▁" ;;
                esac
              done
              break
             done
             echo "$out"
          done
        '';
      };
      
}
