{ radojevich, ... }:
{
  radojevich.everywhere.includes = [ radojevich.fonts ];

  radojevich.fonts.hm =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        ibm-plex
      ];

      fonts.fontconfig.enable = true;
    };
}
