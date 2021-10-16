{ config, pkgs, lib, ... }:
let
  tin = pkgs.callPackage ./tin.nix {};
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


  programs = {
    home-manager.enable = true;
    command-not-found.enable = true;

    vim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        vim-airline
        rust-vim
        vim-nix
        vim-gutentags
        jellybeans-vim
      ];
      settings = {
        relativenumber = true;
        number = true;
        expandtab = true;
        ignorecase = true;
        shiftwidth = 4;
        # The length of a tab, this is for documentation purpose only
        # do not change the default value of 8, ever.
        tabstop = 8;
      };
      extraConfig = builtins.readFile vim/vimrc;
    };

    git = {
      enable = true;
      userName = "Pierre-Emmanuel Patry";
      userEmail = "pierre-emmanuel.patry" + "@" + "epita.fr";
      aliases = {
        lg = "log --all --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };
      ignores = [ "*~" "*.swp" ".o" ".d" "format_marker"];
    };

    bash = {
      enable = true;
      historyControl = [ "ignorespace" ];
      historyIgnore = [ "exit" ];
      initExtra = ''
        set -o vi
        alias fmt="find \$(test -f format_marker && echo -newer format_marker) \( -name '*.cc' -o -name '*.hh' -o -name '*.[ch]' \) -exec clang-format -i -style=file \{\} \; && touch format_marker"
      '';
    };

  };


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
