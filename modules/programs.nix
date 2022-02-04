{ config, pkgs, lib, ...}:
with lib;

let
  cfg = config.my.programs;
in
  {
    options = {
      my.programs = {
        packageBundles = mkOption {
          default = { };
          type = with types; attrsOf (listOf package);
          description = "Set of package bundles";
        };

        packages = mkOption {
          default = [ ];
          type = with types; listOf (oneOf [ package (listOf package) ]);
          description = "Packages to install.";
        };

      };
    };

    imports = [
      ./bundles.nix
    ];
  }

