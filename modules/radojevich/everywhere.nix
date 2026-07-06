{
  den,
  radojevich,
  vix,
  ...
}:
{
  den.aspects.radojevich.includes = [ radojevich.everywhere ];

  radojevich.everywhere = {
    includes = [
      den.provides.primary-user
      vix.nix-index
      vix.nix-registry
    ];
  };
}
