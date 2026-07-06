{ radojevich, ... }:
{
  radojevich.everywhere.includes = [ radojevich.desktop ];

  radojevich.desktop.darwin =
    { pkgs, ... }:
    {
      system.defaults.dock.persistent-apps = [
        {
          app = "/Applications/Safari.app";
        }
        {
          app = "/System/Applications/Messages.app";
        }
        {
          app = "/System/Applications/FaceTime.app";
        }
        {
          app = "/System/Applications/Mail.app";
        }
      ];

      system.defaults.dock.show-recents = false;
      system.defaults.dock.show-process-indicators = true;
      system.defaults.dock.tilesize = 40;

      homebrew = {
        enable = true;

        casks = [
          "backblaze"
          "claude"
          "codex"
          "docker-desktop"
          "firefox"
          "istat-menus"
          "microsoft-excel"
          "microsoft-word"
          "mochi"
          "notion"
          "orbstack"
          "parallels"
          "texifier"
          "yubico-authenticator"
        ];
      };
    };
}
