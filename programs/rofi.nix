{ pkgs, ... }:

{
  enable = true;

  theme = rofi/clouds.rasi;

  package = pkgs.rofi.override {
    plugins = [
      pkgs.rofi-emoji
      pkgs.rofi-calc
    ];
  };

}
