{ radojevich, ... }:
{
  radojevich.everywhere.includes = [ radojevich.tiling ];
  radojevich.tiling = {
    darwin =
      { pkgs, ... }:
      {
        services.aerospace = {
          enable = true;

          settings = builtins.fromTOML (builtins.readFile ./aerospace.toml);
        };

        homebrew = {
          taps = [
            {
              name = "FelixKratz/formulae";
            }
          ];

          brews = [
            "borders"
          ];
        };
      };
  };
}
