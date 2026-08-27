{ config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/homeModules/base/niri
    ./modules/homeModules/base/git.nix
    ./modules/homeModules/base/bat.nix
    ./modules/homeModules/base/yazi.nix
    ./modules/homeModules/base/kitty.nix
    ./modules/homeModules/base/shell.nix
    ./modules/homeModules/base/starship.nix
    ./modules/homeModules/base/nixTools.nix
    ./modules/homeModules/base/noctalia.nix
  ];

  home.username = "jawknee";
  home.homeDirectory = "/home/jawknee";
  home.stateVersion = "25.11";
  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    EDITOR = "nvim";
    VISUAL = "nvim";
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
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    signal-desktop
    telegram-desktop

    # Desktop
    #mako
    #swaylock-effects
    cava

    # Themes
    adwaita-icon-theme
    gnome-themes-extra
    
    # Language Servers (LSPs)
    lua-language-server
    nil 
    pyright 
    vscode-langservers-extracted
    typescript-language-server
    clang-tools
    tailwindcss-language-server
    jdt-language-server
    nodejs_22

    # Development tools
    #mongodb-compass
    postman 
    google-chrome

  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # This tells Home Manager to manage itself
  programs.home-manager.enable = true;

stylix = {
  enable = true;
  enableReleaseChecks = false;
  targets.xresources.enable = false;
    #  image = inputs.wallpapers + "/catppuccin_mocha3.png";
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
      name = "Maple Mono NF";
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

  home.pointerCursor.enable = true;

  # --- BATTERY TOGGLE SCRIPT (CONSERVATION MODE) ---
  home.file.".local/bin/battery-toggle" = {
    executable = true;
    text = ''
      #!/bin/sh
      CONSERVATION_MODE="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
      
      current=$(cat "$CONSERVATION_MODE")
      
      if [ "$current" = "0" ]; then
        echo 1 | sudo tee "$CONSERVATION_MODE" > /dev/null
        notify-send "🔋 Battery" "Conservation mode ON (limit 60%)"
      else
        echo 0 | sudo tee "$CONSERVATION_MODE" > /dev/null
        notify-send "🔋 Battery" "Conservation mode OFF (charging to 100%)"
      fi
    '';
  };


  # Cava script for waybar capsule
  home.file.".config/cava/config" = {
    force = true;
    text = ''
      [general]
      bars = 10
  
      [output]
      method = raw
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
