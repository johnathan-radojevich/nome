{ radojevich, ... }:
{
  radojevich.everywhere.includes = [ radojevich.nix ];
  radojevich.nix.homeManager =
    { pkgs, inputs', ... }:
    {
      home.packages = [
        pkgs.cachix
        pkgs.nixd
        pkgs.nixfmt
      ];
    };
}
