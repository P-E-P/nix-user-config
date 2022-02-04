{ config, pkgs, lib, ... }:
with lib;
let
  tin = pkgs.callPackage programs/tin.nix {};
  unstable = import <nixos-unstable> { config.allowUnfree = true; };
  discordUpdated = import programs/discord.nix;
  cfg = config.my.programs;
in
  {

    xsession.windowManager.i3 = import programs/i3.nix { inherit pkgs lib; };

    imports = [
      modules/battery.nix
      modules/programs.nix
    ];

    my.programs.packages = [
      config.my.programs.packageBundles.devJava
      config.my.programs.packageBundles.devCpp
      config.my.programs.packageBundles.dev
      config.my.programs.packageBundles.reverse
    ];

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home = {
      username = "und";
      homeDirectory = "/home/und";
      packages = with pkgs; (flatten cfg.packages) ++ [
        inkscape

        rustup
        cmake patchelf

        unstable.idea.pycharm-professional
        # Virtualization
        qemu
        docker-compose virt-viewer virt-manager

        # Multimedia
        vlc obs-studio imagemagick
        # Networking
        wireguard nethogs sshfs
        # Misc
        minecraft flameshot
        discordUpdated
        firefox pavucontrol
        libnotify android-studio texlive.combined.scheme-full
        tin woof ripgrep
        zip unzip lz4 unrar
        gnupg

        # Fonts
        dejavu_fonts
        feh
      ];
    };

    programs = import programs/programs.nix { inherit pkgs; };

    services = import services/services.nix { inherit pkgs; };

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
