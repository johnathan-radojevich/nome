{ radojevich, ... }:
{
  radojevich.everywhere.includes = [ radojevich.dots ];
  radojevich.dots.homeManager =
    { config, pkgs, ... }:
    let
      dotsLink =
        path:
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.flake/modules/radojevich/dots/${path}";
    in
    {
      home.file.".config/doom".source = dotsLink "config/doom";
    };
}
