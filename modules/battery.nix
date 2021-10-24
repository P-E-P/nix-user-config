{ config, pkgs, lib, ... }:
with lib;

let
  cfg = config.services.batteryNotifier;
  script = pkgs.writeShellScriptBin "battery-notifier" ''
    function notify() {
      ${pkgs.libnotify}/bin/notify-send \
        --urgency=$1 \
        --category="device" \
        --hint=int:transient:1 \
        --icon=battery_empty \
        "$2" "$3"
    }

    battery_capacity=$(${pkgs.coreutils}/bin/cat /sys/class/power_supply/${cfg.device}/capacity)
    battery_status=$(${pkgs.coreutils}/bin/cat /sys/class/power_supply/${cfg.device}/status)

    if [[ $battery_status = "Discharging" ]]; then
        if [[ $battery_capacity -le ${builtins.toString cfg.notifyCapacity} ]]; then
        notify "critical" "Battery Low" "Time to charge your battery!"
        fi

        if [[ $battery_capacity -le ${builtins.toString cfg.criticalCapacity} ]]; then
          notify "critical" "Battery Critically Low" "Computer will hibernate in ${builtins.toString cfg.chargedCapacity} seconds."

          sleep ${builtins.toString cfg.hibernateDelay}

          battery_status=$(${pkgs.coreutils}/bin/cat /sys/class/power_supply/${cfg.device}/status)

          if [[ $battery_status = "Discharging" ]]; then
              systemctl hibernate
          fi
        fi
    else
      if [[ $battery_capacity -ge ${builtins.toString cfg.chargedCapacity} ]]; then
        notify "low" "Battery Charged" "You can unplug now"
      fi
    fi
  '';
in {
  options = {
    services.batteryNotifier = {
      enable = mkOption {
        default = false;
        description = ''
          Whether to enable battery notifier.
        '';
      };
      device = mkOption {
        default = "BAT0";
        description = ''
          Device to monitor.
        '';
      };
      notifyCapacity = mkOption {
        default = 15;
        description = ''
          Battery level at which a notification shall be sent.
        '';
      };
      criticalCapacity = mkOption {
        default = 5;
        description = ''
          Battery level considered critical. Trigger hibernation delay.
        '';
      };
      chargedCapacity = mkOption {
        default = 80;
        description = ''
          Battery level at which a charge complete notification shall be sent.
        '';
      };

      hibernateDelay = mkOption {
        default = 60;
        description = ''
          Delay between critical battery notification and hibernation in seconds.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.user.timers."battery-notifier" = {
      Unit = {
        Description = "check battery level";
      };

      Timer = {
        OnBootSec = "1m";
        OnUnitInactiveSec = "1m";
        Unit = "battery-notifier.service";
      };

      Install = {
        WantedBy = [ "timers.target" ];
      };
    };

    systemd.user.services."battery-notifier" = {
      Unit = {
        Description = "battery level notifier";
      };

      Service = {
        PassEnvironment = "DISPLAY";
        ExecStart = "${script}/bin/battery-notifier";
      };
    };
  };
}
