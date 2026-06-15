{
  den,
  radojevich,
  lib,
  ...
}:
{
  radojevich.everywhere.includes = [ radojevich.classes ];

  radojevich.classes.includes = [
    radojevich.hmPlatforms
    radojevich.hm
  ];

  radojevich.os-class =
    { class, aspect-chain }:
    den._.forward {
      each = [
        "nixos"
        "darwin"
      ];
      fromClass = _: "os";
      intoClass = lib.id;
      intoPath = _: [ ]; # top-level
      fromAspect = _: lib.head aspect-chain;
    };

  radojevich.hmPlatforms =
    { aspect-chain, ... }:
    den._.forward {
      each = [
        "Linux"
        "Darwin"
      ];
      fromClass = platform: "hm${platform}";
      intoClass = _: "homeManager";
      intoPath = _: [ ];
      fromAspect = _: lib.head aspect-chain;
      adaptArgs =
        { config, ... }:
        {
          osConfig = config;
        };
      guard =
        {
          pkgs,
          # deadnix: skip
          inputs',
          # deadnix: skip
          self',
          ...
        }:
        platform: lib.mkIf pkgs.stdenv."is${platform}";
    };

  radojevich.hm =
    { host, ... }:
    { aspect-chain, ... }:
    den._.forward {
      each = lib.singleton true;
      fromClass = _: "hm";
      intoClass = _: "homeManager";
      intoPath = _: [ ];
      fromAspect = _: lib.head aspect-chain;
      adaptArgs =
        { config, ... }:
        {
          osConfig = config;
        };
      guard =
        {
          pkgs,
          # deadnix: skip
          inputs',
          # deadnix: skip
          self',
          ...
        }:
        _: lib.mkIf (pkgs.stdenv.isDarwin || (pkgs.stdenv.isLinux && !host.iso));
    };
}
