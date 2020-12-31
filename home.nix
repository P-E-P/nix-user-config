{ config, pkgs, lib, ... }:

{
  #  xsession.enable = true;
  #  xsession.windowManager.command = "…";
  xsession.windowManager.i3 = import ./i3.nix { inherit pkgs lib; };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "und";
  home.homeDirectory = "/home/und";

  programs = {
    home-manager.enable = true;
    command-not-found.enable = true;

    git = {
      enable = true;
      userName = "Pierre-Emmanuel Patry";
      userEmail = "pierre-emmanuel.patry" + "@" + "epita.fr";
    };

  };


    # List services that you want to enable:
    services = {

      gpg-agent = {
        enable = true;

        enableSshSupport = true;
        pinentryFlavor = "curses";
      };

      dunst = import ./dunst.nix { inherit pkgs; };
    };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}
