with import <nixpkgs> {};

pkgs.discord.override rec {
  nss = pkgs.nss_latest;
  version = "0.0.16";
  src = builtins.fetchurl {
    url = "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
    sha256 = "1s9qym58cjm8m8kg3zywvwai2i3adiq6sdayygk2zv72ry74ldai";
  };
}
