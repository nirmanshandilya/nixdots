{ config, pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    xwayland
    wayland-utils
    hyprpolkitagent
    swaybg
    waybar
    fuzzel
    kitty
    thunar
    brightnessctl
    playerctl
    wireplumber
  ];

  wayland.windowManager.niri = {
    enable = true;
    settings = {
    # ==========================================
    # config.kdl
    # ==========================================
    prefer-no-csd = {};

    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

    blur = {
      passes = 3;
      offset = 3.0;
    };

    hotkey-overlay.skip-at-startup = {};

    # ==========================================
    # environment.kdl
    # ==========================================
    environment = {
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "niri";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      WLR_NO_HARDWARE_CURSORS = "1";
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };

    # ==========================================
    # input.kdl
    # ==========================================
    input = {
      keyboard = {
        xkb = {
          layout = "us,us";
          variant = ",colemak_dh";
          options = "caps:swapescape,grp:win_space_toggle";
        };
        numlock = {};
      };

      touchpad = {
        tap = {};
        natural-scroll = {};
      };

      focus-follows-mouse = {};
      workspace-auto-back-and-forth = {};
    };

    # ==========================================
    # output.kdl
    # ==========================================
    output = {
      _args = [ "eDP-1" ];
      mode = "1920x1080@144.003";
      scale = 1.0;
    };

    # ==========================================
    # stylix.kdl (formerly xdg.configFile."niri/stylix.kdl".text)
    # ==========================================
    layout = {
      gaps = 12;
      always-center-single-column = {};

      focus-ring = {
        # on
        off = {};
        width = 3;
      };

      border = {
        on = {};
        width = 3;
        active-color = "#${config.lib.stylix.colors.base0E}";
        inactive-color = "#${config.lib.stylix.colors.base03}";
      };
    };

    # ==========================================
    # binds.kdl
    # ==========================================
    binds = {
      # --- Apps & Launchers ---
      "Mod+Return".spawn = "kitty";
      "ALT+SPACE".spawn-sh = "fuzzel";
      "MOD+B".spawn-sh = "zen";
      "MOD+E".spawn-sh = "thunar";

      # --- System & Toggles ---
      "MOD+Q".close-window = {};
      # "MOD+ALT+L".spawn = [ "noctalia-shell" "ipc" "call" "lockScreen" "lock" ];
      # "MOD+ALT+L".spawn-sh = "swaylock";
      "MOD+SHIFT+B".spawn = "~/.local/bin/battery-toggle"; # battery conservation mode toggle
      "MOD+ESCAPE" = {
        _props.allow-inhibiting = false;
        toggle-keyboard-shortcuts-inhibit = {};
      };
      "MOD+O" = {
        _props.repeat = false;
        toggle-overview = {};
      };

      # --- Media & Brightness ---
      "XF86AudioRaiseVolume" = {
        _props.allow-when-locked = true;
        spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
      };
      "XF86AudioLowerVolume" = {
        _props.allow-when-locked = true;
        spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
      };
      "XF86AudioMute" = {
        _props.allow-when-locked = true;
        spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };
      "XF86AudioMicMute" = {
        _props.allow-when-locked = true;
        spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
      };
      "XF86AudioPlay" = {
        _props.allow-when-locked = true;
        spawn-sh = "playerctl play-pause";
      };
      "XF86AudioPause" = {
        _props.allow-when-locked = true;
        spawn-sh = "playerctl play-pause";
      };
      "XF86AudioNext" = {
        _props.allow-when-locked = true;
        spawn-sh = "playerctl next";
      };
      "XF86AudioPrev" = {
        _props.allow-when-locked = true;
        spawn-sh = "playerctl previous";
      };
      "XF86MonBrightnessUp" = {
        _props.allow-when-locked = true;
        spawn = [ "brightnessctl" "set" "+5%" ];
      };
      "XF86MonBrightnessDown" = {
        _props.allow-when-locked = true;
        spawn = [ "brightnessctl" "set" "5%-" ];
      };

      # --- Window Focus & Movement ---
      "MOD+H".focus-column-left = {};
      "MOD+L".focus-column-right = {};
      "MOD+K".focus-window-up = {};
      "MOD+J".focus-window-down = {};
      "MOD+SHIFT+H".move-column-left = {};
      "MOD+SHIFT+L".move-column-right = {};
      "MOD+SHIFT+K".move-window-up = {};
      "MOD+SHIFT+J".move-window-down = {};

      # --- Layout & Resizing ---
      "MOD+F".fullscreen-window = {};
      "MOD+C".center-column = {};
      "MOD+CTRL+C".center-visible-columns = {};
      "MOD+MINUS".set-column-width = "-10%";
      "MOD+EQUAL".set-column-width = "+10%";
      "MOD+SHIFT+MINUS".set-window-height = "-10%";
      "MOD+SHIFT+EQUAL".set-window-height = "+10%";
      "MOD+T".toggle-window-floating = {};
      "MOD+CTRL+F".expand-column-to-available-width = {};
      "MOD+W".toggle-column-tabbed-display = {};

      # --- Workspaces ---
      "MOD+TAB".focus-workspace-previous = {};
      "MOD+1".focus-workspace = 1;
      "MOD+2".focus-workspace = 2;
      "MOD+3".focus-workspace = 3;
      "MOD+4".focus-workspace = 4;
      "MOD+5".focus-workspace = 5;
      "MOD+6".focus-workspace = 6;
      "MOD+7".focus-workspace = 7;
      "MOD+8".focus-workspace = 8;
      "MOD+9".focus-workspace = 9;
      "MOD+SHIFT+1".move-column-to-workspace = 1;
      "MOD+SHIFT+2".move-column-to-workspace = 2;
      "MOD+SHIFT+3".move-column-to-workspace = 3;
      "MOD+SHIFT+4".move-column-to-workspace = 4;
      "MOD+SHIFT+5".move-column-to-workspace = 5;
      "MOD+SHIFT+6".move-column-to-workspace = 6;
      "MOD+SHIFT+7".move-column-to-workspace = 7;
      "MOD+SHIFT+8".move-column-to-workspace = 8;
      "MOD+SHIFT+9".move-column-to-workspace = 9;

      # --- Screenshots ---
      "CTRL+SHIFT+1".screenshot = {};
      "CTRL+SHIFT+2".screenshot-screen = {};
      "CTRL+SHIFT+3".screenshot-window = {};
    };

    # ==========================================
    # spawn-at-startup.kdl + window-rule.kdl
    # (repeated top-level node names need _children)
    # ==========================================
    _children = [
      { spawn-sh-at-startup._args = [ "hyprpolkitagent" ]; }
      { spawn-sh-at-startup._args = [ "noctalia" ]; }
      # { spawn-sh-at-startup._args = [ "waybar" ]; }

      {
        window-rule._children = [
          { match._props = { app-id = "zen"; }; }
          { default-column-width.proportion = 1.0; }
        ];
      }

      # Apply rounded corners to ALL windows
      {
        window-rule = {
          geometry-corner-radius = 10;
          clip-to-geometry = true;
          opacity = 1.0;
          draw-border-with-background = false;
        };
      }

      {
        window-rule = {
          match._props = { app-id = "mpv"; };
          opacity = 1.0;
          # background-effect.blur = false;
        };
      }

      # BLUR SETTINGS FOR ALL APPS
      {
        window-rule = {
          opacity = 0.88;
          background-effect.blur = true;
        };
      }
    ];
  };
  };
}
