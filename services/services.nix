{ pkgs, ... }:

{

  redshift = {
    enable = true;
    provider = "geoclue2";
  };

  gpg-agent = {
    enable = true;

    enableSshSupport = true;
    pinentryFlavor = "curses";
  };

  picom = {
    enable = true;
    blur = true;
    shadow = true;
  };

  dunst = import ./dunst.nix { inherit pkgs; };

  batteryNotifier.enable = true;
}
