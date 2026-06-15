{ radojevich, ... }:
{
  radojevich.everywhere.includes = [ radojevich.terminals ];
  radojevich.terminals = {
    hmLinux =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.ghostty ];
      };

    darwin = {
      homebrew = {
        casks = [
          "ghostty"
        ];
      };
    };

    hmDarwin =
      { pkgs, ... }:
      {
        home.file.".hushlogin".text = "";
      };

    hm =
      { pkgs, ... }:
      {
        home.packages = [
          pkgs.nushell
        ];

        programs.starship = {
          enableNushellIntegration = true;
          enableZshIntegration = true;
        };

        xdg.enable = true;
        xdg.configFile."ghostty/config.ghostty".source = ./terminals/ghostty/config.ghostty;
      };
  };
}
