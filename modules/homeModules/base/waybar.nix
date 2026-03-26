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

        "modules-left" = [ "custom/launcher" "niri/workspaces" ];
        "modules-center" = [ "clock" "custom/cava" ];
        "modules-right" = [
          "custom/clipboard"
          "bluetooth"
          "pulseaudio"
          "backlight"
          "network"
          "battery"
        ];

        "custom/launcher" = {
            format = "󱄅";
            tooltip = true;
            "tooltip-format" = "{}";
            exec = "echo \"$(hostname) - up $(uptime | awk '{print $3}' | tr -d ',') hrs\"";
            interval = 15;
            "on-click" = "kitty --title btop sh -c btop";
        };

        clock = {
          format = "{:%a, %b %d | %H:%M}"; /* Mon, Jan 01 | 00:00 */
          timezone = "Asia/Kolkata";
          tooltip = false;
        };
        
        "custom/cava" = {
          exec = "$HOME/.config/waybar/cava.sh";
          format = "{}";
          tooltip = false;
        };

        /*
        idle_inhibitor = {
          format = "{icon}";
          "format-icons" = {
            activated = "󰅶";
            deactivated = "󰾫";
          };
        };
        */

        "custom/clipboard" = {
          format = "󰅌 ";
          tooltip = false;
          "tooltip-format" = "{} items in clipboard history";
          "on-click" = "bash -c 'choice=$(cliphist list | fuzzel -d -a top-right -x 20 -y 20 -l 10 -w 60 -p \"  paste  \"); [ -n \"$choice\" ] && echo \"$choice\" | cliphist decode | wl-copy'";
          "on-click-right" = "cliphist wipe && notify-send '󰅌 Clipboard' 'History cleared'";
          "on-click-middle" = "bash -c 'choice=$(cliphist list | fuzzel -d -a top-right -x 20 -y 20 -l 10 -w 60 -p \"  delete  \"); [ -n \"$choice\" ] && cliphist delete <<< \"$choice\" && notify-send \"󰅌 Clipboard\" \"Entry removed\"'";
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
        font-family: Maple Mono NF;
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
      
      #custom-launcher {
        padding: 0 12px;
        color: @base0D;
        font-size: 16px;
      }
      
      #clock,
      #idle_inhibitor {
        padding: 0 12px;
      }
      
      #custom-cava {
        padding: 0 12px;
        background-color: @base02;
        border-radius: 12px;
        font-size: 10px;
        letter-spacing: 2px;
        margin: 4px 6px;
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

      #battery.warning {
        color: @base09; /* Orange */
      }

      #battery.critical {
        color: @base08; /* Red */
      }

    '';
  };

  stylix.targets.waybar.enable = true;
  stylix.targets.fuzzel.enable = true;
}
