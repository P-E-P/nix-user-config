{ config, pkgs, lib, ... }:
let
  tin = pkgs.callPackage ./programs/tin.nix {};
  unstable = import <nixos-unstable> { config.allowUnfree = true; };
  discordUpdated = pkgs.discord.override rec {

    version = "0.0.16";
    src = builtins.fetchurl {
      url = "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
      sha256 = "1s9qym58cjm8m8kg3zywvwai2i3adiq6sdayygk2zv72ry74ldai";
    };
  };
in
  {

    xsession.windowManager.i3 = import ./i3.nix { inherit pkgs lib; };

    imports = [
      ./battery.nix
    ];

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home = {
      username = "und";
      homeDirectory = "/home/und";
      packages = with pkgs; [
        # Dev
        boost unstable.adoptopenjdk-openj9-bin-16 maven
        # Jetbrains
        unstable.idea.clion
        unstable.idea.pycharm-professional
        unstable.idea.idea-ultimate
        unstable.idea.pycharm-professional
        # Security
        ghidra-bin
        # Virtualization
        qemu
        # Multimedia
        vlc obs-studio
        # Networking
        wireguard nethogs sshfs
        # Misc
        minecraft flameshot
        discordUpdated
        libnotify android-studio texlive.combined.scheme-full
        tin woof
      ];
    };

    programs = import programs/programs.nix { inherit pkgs; };

    # List services that you want to enable:
    services = {

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

      dunst = import ./services/dunst.nix { inherit pkgs; };
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
