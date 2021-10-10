{ config, pkgs, lib, ... }:
let
  script = pkgs.writeShellScriptBin "lowbatt" ''
    function notify() {
      notify-send \
        --urgency=$1 \
        --hint=int:transient:1 \
        --icon=battery_empty \
        "$2" "$3"
    }

    battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity)
    battery_status=$(cat /sys/class/power_supply/BAT0/status)

    if [[ $battery_status = "Discharging" ]]; then
        if [[ $battery_capacity -le 80 ]]; then
        notify "critical" "Battery Low" "Time to charge your battery!"
        fi

        if [[ $battery_capacity -le 5 ]]; then
          notify "critical" "Battery Critically Low" "Computer will hibernate in 60 seconds."

          sleep 60

          battery_status=$(cat /sys/class/power_supply/BAT0/status)

          if [[ $battery_status = "Discharging" ]]; then
              systemctl hibernate
          fi
        fi
    else
      if [[ $battery_capacity -ge 60 && $battery_capacity -le 82 ]]; then
        notify "low" "Battery Charged" "You can unplug now"
      fi
    fi
  '';

in
{
  systemd.user.timers."lowbatt" = {
    Unit = {
      Description = "check battery level";
    };

    Timer = {
      OnBootSec = "1m";
      OnUnitInactiveSec = "3m";
      Unit = "lowbatt.service";
    };

    Install = {
      WantedBy = [ "timers.target" ];
    };
  };

  systemd.user.services."lowbatt" = {
    Unit = {
      Description = "battery level notifier";
    };

    Service = {
      PassEnvironment = "DISPLAY";
      ExecStart = "${script}/bin/lowbatt";
    };
  };
}
