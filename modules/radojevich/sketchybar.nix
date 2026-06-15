{ radojevich, ... }:
{
  radojevich.everywhere.includes = [ radojevich.sketchybar ];
  radojevich.sketchybar = {
    darwin =
      { pkgs, ... }:
      {
        fonts.packages = [
          pkgs.iosevka
          pkgs.nerd-fonts.iosevka
          pkgs.nerd-fonts.hack
          pkgs.nerd-fonts.symbols-only
        ];

        services.sketchybar = {
          enable = true;
          config = builtins.readFile ./sketchybarrc;
        };
      };

    hmDarwin =
      { pkgs, ... }:
      let
        scripts = [
          "aerospace"
          "battery"
          "clock"
          "icon_map_fn"
          "load_spaces"
          "space"
          "space_windows"
          "update_workspace_icons"
          "volume"
        ];
      in
      {
        xdg.enable = true;

        xdg.configFile = builtins.listToAttrs (
          map (name: {
            name = "sketchybar/plugins/${name}.sh";
            value = {
              source = ./sketchybar-plugins/${name}.sh;
              executable = true;
            };
          }) scripts
        );
      };
  };
}
