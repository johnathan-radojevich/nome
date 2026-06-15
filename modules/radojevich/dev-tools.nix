{ radojevich, ... }:
{
  radojevich.everywhere.includes = [ radojevich.dev-tools ];

  radojevich.dev-tools.hm =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.devenv
      ];
    };
}
