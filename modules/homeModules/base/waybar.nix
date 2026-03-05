{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        height = 26;
        reload_style_on_change = true;
        layer = "top";
        position = "top";
        "margin-top" = 0;
        "margin-bottom" = 0;
        spacing = 0;

        "modules-left" = [ "niri/workspaces" ];
        "modules-center" = [ "clock" "idle_inhibitor" ];
        "modules-right" = [
          "custom/clipboard"
          "bluetooth"
          "pulseaudio"
          "backlight"
          "network"
          "battery"
        ];

        clock = {
          format = "{:%H : %M}";
          timezone = "Asia/Kolkata";
          tooltip = false;
          "format-alt" = "{:%A, %b-%d}";
        };

        idle_inhibitor = {
          format = "{icon}";
          "format-icons" = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
        };

        "custom/clipboard" = {
          format = "󰅌 ";
          tooltip = true;
          tooltip-format = "Clipboard History";
          # This command uses cliphist and a launcher like fuzzel or wofi
          "on-click" = "bash -c 'choice=$(echo -e \"[󰃢  Clear History]\\n$(cliphist list)\" | fuzzel -d -a top-right -x 180 -y 30 -l 8 -w 40 -p \"󰅌  \"); if [ \"$choice\" = \"[󰃢  Clear History]\" ]; then cliphist wipe; elif [ -n \"$choice\" ]; then echo \"$choice\" | cliphist decode | wl-copy; fi'";
        };

        bluetooth = {
          format = "";
          "format-disabled" = "󰂲";
          "format-connected" = "󰂱";
          tooltip = true;
          "tooltip-format" = "{num_connections} connected";
          "tooltip-format-connected" = "{device_enumerate}";
          "on-click" = "blueman-manager"; # Opens the Bluetooth GUI
        };

        network = {
          "format-wifi" = "";
          "format-ethernet" = "";
          "format-disconnected" = "󰖪";
          "format-disabled" = "󰀝";
          tooltip = true;
          "tooltip-format" = "{essid} ({signalStrength}%)";
        };

        backlight = {
          device = "intel_backlight";
          format = "{icon}";
          "format-icons" = ["󰃞" "󰃟" "󰃠"];
          tooltip = true;
          "tooltip-format" = "Brightness: {percent}%";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          "format-charging" = "󰂄";
          "format-plugged" = "󰂄";
          "format-icons" = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          tooltip = true;
          "tooltip-format" = "Battery: {capacity}%\nTime: {time}";
        };

        pulseaudio = {
          "scroll-step" = 5;
          format = "{icon}";
          "format-muted" = "󰖁";
          "format-icons" = {
            default = ["" "" ""];
          };
          tooltip = true;
          "tooltip-format" = "Volume: {volume}%";
          "on-click" = "pavucontrol";
        };
     };
 };

style = ''
      * {
        font-family: JetBrainsMono Nerd Font;
        font-weight: bold;
        font-size: 14px;
        border-radius: 0px;
        margin: 0;
        padding: 0;
      }

      #waybar {
        background-color: @base00;
        color: @base05;
        min-height: 26px;
      }

      #workspaces {
        padding: 0 15px;
        margin: 0;
      }

      #clock,
      #idle_inhibitor {
        padding: 0 12px;
      }

      #custom-clipboard {
        padding: 0 5px;
        margin: 0;
      }

      #bluetooth,
      #pulseaudio,
      #backlight,
      #network {
        padding: 0 10px;
        margin: 0;
      }

      #battery {
        padding: 0 15px 0 10px;
        margin: 0;
      }

      #workspaces button {
        color: @base0D; /* Usually Blue */
        padding: 0 5px;
      }

      #workspaces button.active {
        color: @base0A; /* Usually Yellow */
        background-color: @base02; /* Usually a lighter background highlight */
      }

      #pulseaudio {
        color: @base05;
      }

      #battery {
        color: @base0B; /* Usually Green for normal battery */
      }

      #battery.warning {
        color: @base09; /* Orange */
      }

      #battery.critical {
        color: @base08; /* Red */
      }

      #backlight {
        color: @base0A; /* Yellow */
      }

      #network {
        color: @base0B; /* Green */
      }

      #idle_inhibitor {
        color: @base09; /* Orange */
      }
    '';
  };
      stylix.targets.waybar.enable = true;
      stylix.targets.fuzzel.enable = true;
}
