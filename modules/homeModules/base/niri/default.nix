{ config, pkgs, inputs, ... }: {
    
    home.packages = with pkgs; [ xwayland wayland-utils hyprpolkitagent swaybg waybar fuzzel kitty thunar brightnessctl playerctl wireplumber ];

   xdg.configFile."niri"= {
    source = ./config;
    recursive = true;
  };

  xdg.configFile."niri/stylix.kdl".text = ''
      // ==========================================
      // LAYOUT & THEME
      // ==========================================
      layout {
          gaps 12 
          always-center-single-column
          focus-ring {
            //on
            off
            width 3
          }	  
          border {
		          on
              width 3
              active-color "#${config.lib.stylix.colors.base0E}"
              inactive-color "#${config.lib.stylix.colors.base03}"
        }
      }
      spawn-sh-at-startup "swaybg -i ${config.stylix.image} -m fill" // homescreen wallpaper
  '';
}
