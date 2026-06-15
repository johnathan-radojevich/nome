{ vix, ... }:
{
  den.aspects.sisyphus = {
    darwin = {
      users.users.radojevich.home = "/Users/radojevich";
      system.primaryUser = "radojevich";
    };

    includes = [
      vix.nix-settings
      vix.darwin-base
    ];
  };
}
