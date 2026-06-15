{
  den,
  radojevich,
  vix,
  ...
}:
{
  radojevich.everywhere.includes = [ radojevich.editors ];

  radojevich.editors = {
    hm =
      { pkgs, ... }:
      {
        programs.helix = {
          enable = true;

          languages = {
            language = [
              {
                auto-format = true;
                name = "nix";
                formatter = {
                  command = "nixfmt";
                };
              }
            ];
          };

          settings = {
            editor = {
              line-number = "relative";
              lsp = {
                display-messages = true;
              };
            };

            keys.normal = {
              space.space = "file_picker";
              space.w = ":w";
              space.q = ":q";
            };

            theme = "catppucin_latte";
          };
        };
      };
  };
}
