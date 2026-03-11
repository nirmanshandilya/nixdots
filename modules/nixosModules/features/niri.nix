{ pkgs, inputs, ... }: {
  # 1. SYSTEM LEVEL: Enable the compositor for the display manager
  programs.niri.enable = true;

  # 2. USER LEVEL: Wrap the Home Manager options for your user
  home-manager.users.jawknee = { pkgs, config, ... }: {
    
    home.packages = with pkgs; [
      xwayland
      wayland-utils
      hyprpolkitagent
      swaybg
      waybar
      fuzzel
      kitty
      floorp-bin
      xfce.thunar
      brightnessctl
      playerctl
      wireplumber
    ];

    xdg.configFile."niri/config.kdl".text = ''
      // ==========================================
      // ENVIRONMENT & STARTUP
      // ==========================================
      environment {
          DISPLAY ":1"
          ELECTRON_OZONE_PLATFORM_HINT "auto"
          QT_QPA_PLATFORM "wayland"
          QT_WAYLAND_DISABLE_WINDOWDECORATION "1"
          XDG_SESSION_TYPE "wayland"
          XDG_CURRENT_DESKTOP "niri"
          QT_QPA_PLATFORMTHEME "qt5ct"
          WLR_NO_HARDWARE_CURSORS "1"
          LIBVA_DRIVER_NAME "nvidia"
          __GLX_VENDOR_LIBRARY_NAME "nvidia"
      }

      spawn-sh-at-startup "hyprpolkitagent" 
      spawn-sh-at-startup "swaybg -i ${config.stylix.image} -m fill" // homescreen wallpaper
      spawn-sh-at-startup "waybar" 


      // ==========================================
      // GLOBAL SETTINGS
      // ==========================================
      prefer-no-csd 
      screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

      hotkey-overlay {
          skip-at-startup
      }


      // ==========================================
      // OUTPUT (MONITORS)
      // ==========================================
      output "eDP-1" {
          mode "1920x1080@144.003" 
          scale 1.0 
      }


      // ==========================================
      // INPUT (KEYBOARD & MOUSE)
      // ==========================================
      input {
          keyboard {
              xkb { layout "us"; }
              numlock 
          }

          touchpad {
              tap 
              natural-scroll 
          }

          focus-follows-mouse 
          workspace-auto-back-and-forth 
      }


      // ==========================================
      // LAYOUT & THEME
      // ==========================================
      layout {
          gaps 8 
          always-center-single-column
          focus-ring {
              width 3
              active-color "#${config.lib.stylix.colors.base0E}"
              inactive-color "#${config.lib.stylix.colors.base03}"
        
        }
      }


      // ==========================================
      // WINDOW RULES
      // ==========================================
      // Open browser in expanded view (not fullscreen)
      window-rule {
          match app-id="floorp" 
          default-column-width { proportion 1.0; }
      }

      // Apply rounded corners to ALL windows
      window-rule {
          geometry-corner-radius 10
          clip-to-geometry true
      }


      // ==========================================
      // KEYBINDS
      // ==========================================
      binds {
          // --- Apps & Launchers ---
          MOD+RETURN          { spawn-sh "kitty"; }
          ALT+SPACE           { spawn-sh "fuzzel"; }
          MOD+B               { spawn-sh "floorp"; }
          MOD+E               { spawn-sh "thunar"; }
          
          // --- System & Toggles ---
          MOD+Q               { close-window; }
          MOD+ALT+L           { spawn-sh "swaylock"; }
          MOD+SHIFT+B         { spawn "~/.local/bin/battery-toggle"; } // battery conservation mode toggle
          MOD+ESCAPE          allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }
          MOD+O               repeat=false { toggle-overview; }

          // --- Media & Brightness ---
          XF86AudioRaiseVolume  allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+"; }
          XF86AudioLowerVolume  allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"; }
          XF86AudioMute         allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
          XF86AudioMicMute      allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
          XF86AudioPlay         allow-when-locked=true { spawn-sh "playerctl play-pause"; }
          XF86AudioPause        allow-when-locked=true { spawn-sh "playerctl play-pause"; }
          XF86AudioNext         allow-when-locked=true { spawn-sh "playerctl next"; }
          XF86AudioPrev         allow-when-locked=true { spawn-sh "playerctl previous"; }
          XF86MonBrightnessUp   allow-when-locked=true { spawn "brightnessctl" "set" "+5%"; }
          XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "set" "5%-"; }

          // --- Window Focus & Movement ---
          MOD+H               { focus-column-left; }
          MOD+L               { focus-column-right; }
          MOD+K               { focus-window-up; }
          MOD+J               { focus-window-down; }
          MOD+SHIFT+H         { move-column-left; }
          MOD+SHIFT+L         { move-column-right; }
          MOD+SHIFT+K         { move-window-up; }
          MOD+SHIFT+J         { move-window-down; }
          
          // --- Layout & Resizing ---
          MOD+F               { fullscreen-window; }
          MOD+C               { center-column; }
          MOD+CTRL+C          { center-visible-columns; }
          MOD+MINUS           { set-column-width "-10%"; }
          MOD+EQUAL           { set-column-width "+10%"; }
          MOD+SHIFT+MINUS     { set-window-height "-10%"; }
          MOD+SHIFT+EQUAL     { set-window-height "+10%"; }
          MOD+T               { toggle-window-floating; }
          MOD+CTRL+F          { expand-column-to-available-width; } 
          MOD+W               { toggle-column-tabbed-display; }

          // --- Workspaces ---
          MOD+TAB             { focus-workspace-previous; }
          MOD+1               { focus-workspace 1; }
          MOD+2               { focus-workspace 2; }
          MOD+3               { focus-workspace 3; }
          MOD+4               { focus-workspace 4; }
          MOD+5               { focus-workspace 5; }
          MOD+6               { focus-workspace 6; }
          MOD+7               { focus-workspace 7; }
          MOD+8               { focus-workspace 8; }
          MOD+9               { focus-workspace 9; }
          MOD+SHIFT+1         { move-column-to-workspace 1; }
          MOD+SHIFT+2         { move-column-to-workspace 2; }
          MOD+SHIFT+3         { move-column-to-workspace 3; }
          MOD+SHIFT+4         { move-column-to-workspace 4; }
          MOD+SHIFT+5         { move-column-to-workspace 5; }
          MOD+SHIFT+6         { move-column-to-workspace 6; }
          MOD+SHIFT+7         { move-column-to-workspace 7; }
          MOD+SHIFT+8         { move-column-to-workspace 8; }
          MOD+SHIFT+9         { move-column-to-workspace 9; }

          // --- Screenshots ---
          CTRL+SHIFT+1        { screenshot; }
          CTRL+SHIFT+2        { screenshot-screen; }
          CTRL+SHIFT+3        { screenshot-window; }
      }
    '';
  };
}
