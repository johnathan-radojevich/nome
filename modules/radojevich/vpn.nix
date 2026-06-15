{ radojevich, ... }:
{
  radojevich.everywhere.includes = [ radojevich.vpn ];
  radojevich.vpn = {
    darwin =
      { pkgs, ... }:
      {
        services.tailscale = {
          enable = true;
        };
      };
  };
}
