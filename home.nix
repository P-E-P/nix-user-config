{ config, pkgs, lib, ... }:
let
  tin = pkgs.callPackage ./tin.nix {};
  unstable = import <nixos-unstable> { config.allowUnfree = true; };
in
  {
  #  xsession.enable = true;
  #  xsession.windowManager.command = "…";
  xsession.windowManager.i3 = import ./i3.nix { inherit pkgs lib; };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "und";
    homeDirectory = "/home/und";
    packages = with pkgs; [
      unstable.idea.clion ghidra-bin vlc obs-studio nethogs tin woof qemu
      flameshot
    ];
  };

  programs = {
    home-manager.enable = true;
    command-not-found.enable = true;

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
      #shellOptions = [ "vi" ];
      initExtra = ''
        set -o vi
        #export VISUAL="vim"
        export PGDATA="/home/und/postgres_data"
        export PGHOST="/tmp"
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
