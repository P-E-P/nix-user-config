{ pkgs, ... }:
let
  soundNotification = pkgs.writeScript "play-notification-sound.sh" ''
          #!/bin/sh
              ${pkgs.pulseaudio}/bin/paplay ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/window-attention.oga
  '';
in
  {
    enable = true;
    settings = {
      global = {
        geometry = "500x20-30+50";
        frame_color = "#aaaaaa";
        font = "Droid Sans 14";
        sort = "no";
        markup = "full";
        format = "<b>%a - %s</b>\\n%b";

        icon_position = "left";
        idle_threshold = 20;
        line_height = 10;
        padding = 10;
        horizontal_padding = 10;
        show_age_threshold = 120;
        separator_height = 10;
        separator_color = "auto";
        dmenu = "${pkgs.rofi}/bin/dmenu -dmenu -p dunst:";
        browser = "${pkgs.firefox}/bin/firefox -new-tab";
        mouse_left_click = "do_action";
        max_icon_size = 64;
        #bounce_freq = 3;
        word_wrap = "yes";

      };

      shortcuts = {
        history = "ctrl+shift+comma";
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
      };

      frame = {
        width = 1;
        color = "#aaaaaa";
      };
      urgency_low = {
        background = "#222222";
        foreground = "#888888";
        timeout = 3;
      };
      urgency_normal = {
        background = "#285577";
        foreground = "#ffffff";
        timeout = 4;
      };
      urgency_critical = {
        background = "#900000";
        foreground = "#ffffff";
        frame_color = "#ff0000";
        timeout = 10;
      };
      stack-volumes = {
        appname = "some_volume_notifiers";
        set_stack_tag = "volume";
      };
    };
  }
