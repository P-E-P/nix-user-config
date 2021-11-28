{ pkgs, lib, ... }:

let
  wallpaper = builtins.fetchurl {
    url = https://wallpapers.etherealgames.com/wp-content/uploads/sites/6/2018/04/Doom-Wallpaper-003.jpg;
    sha256 = "1f207kh8c02xv4c03bylkxyw2ppcs3ns9dzc5hwfdqhrp53ij922";
  };
  cfg = {
    pkgs = pkgs;
    mod = "Mod4";
    workspaces = {
    ws1 = "1";
    ws2 = "2";
    ws3 = "3";
    ws4 = "4";
    ws5 = "5";
    ws6 = "6";
    ws7 = "7";
    ws8 = "8";
    ws9 = "9";
    ws10 = "10";
    };
  };
in
  {
    enable = true;
    package = pkgs.i3;

    config = rec {
      modifier = cfg.mod;
      terminal = "alacritty";

      window.border = 1;

      keybindings = lib.mkOptionDefault {
        "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -modi drun -show drun";
        "${modifier}+Shift+d" = "exec ${pkgs.rofi}/bin/rofi -show window";
        "XF86AudioRaiseVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ false, exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ false, exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "${modifier}+Print" = "exec --no-startup-id ${pkgs.flameshot}/bin/flameshot full -c -p \"/home/und/Pictures/Screenshots\"";
        "${modifier}+Shift+Print" = "exec --no-startup-id ${pkgs.flameshot}/bin/flameshot gui";
      };

      modes = {
        resize = {
          Down = "resize grow height 10 px or 10 ppt";
          Escape = "mode default";
          Left = "resize shrink width 10 px or 10 ppt";
          Return = "mode default";
          Right = "resize grow width 10 px or 10 ppt";
          Up = "resize shrink height 10 px or 10 ppt";
          ShiftUp = "resize shrink height 2 px or 2 ppt";
          ShiftDown = "resize grow height 2 px or 2 ppt";
          ShiftLeft = "resize shrink width 2 px or 2 ppt";
          ShiftRight = "resize grow width 2 px or 2 ppt";
        };
      };

      window.commands = [
        { command = "border pixel 0"; criteria = { class = "Firefox"; }; }
        { command = "border pixel 0"; criteria = { class = "discord"; }; }
      ];

      assigns = {
        "${cfg.workspaces.ws10}" = [ { class = "discord"; } ];
      };

      startup = [
        {
          command = "${pkgs.feh}/bin/feh --bg-scale ${wallpaper}";
          always = true;
          notification = false;
        }
      ];
    };
  }
