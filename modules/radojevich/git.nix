{
  radojevich,
  ...
}:
{
  radojevich.everywhere.includes = [ radojevich.git ];

  radojevich.git.hm =
    { lib, pkgs, ... }:
    {
      programs.git = {
        enable = true;

        settings = {
          user.email = "31018428+johnathanradojevich@users.noreply.github.com";
          user.name = "Johnathan Radojevich";

          init = {
            defaultBranch = true;
          };
        };
      };
    };
}
