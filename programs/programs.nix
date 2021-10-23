{ pkgs, ... }:

{
  home-manager.enable = true;
  command-not-found.enable = true;

  vim = import ./vim.nix { inherit pkgs; };

  git = import ./git.nix {};

  bash = import ./bash.nix {};

  alacritty = import ./alacritty.nix {};

  rofi = {
    enable = true;
  };

  fzf = {
    enable = true;

    enableBashIntegration = true;
  };

  ncmpcpp = import ./ncmpcpp.nix {};

}
