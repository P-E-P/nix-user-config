{ pkgs, ... }:

{
  enable = true;

  theme = builtins.toString (pkgs.writeTextFile {
    name = "rofi-theme";
    text = builtins.readFile rofi/clouds.rasi;
  });
  package = pkgs.rofi.override {
    plugins = [
      pkgs.rofi-emoji
      pkgs.rofi-calc
    ];
  };

}
