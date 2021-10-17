{ pkgs, ... }:

{
  home-manager.enable = true;
  command-not-found.enable = true;

  vim = import ./vim.nix { inherit pkgs; };

  git = import ./git.nix {};

  bash = import ./bash.nix {};

  rofi = {
    enable = true;
  };

}
