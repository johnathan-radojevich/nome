{ radojevich, ... }:
{
  flake-file.inputs = {
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  radojevich.everywhere.includes = [ radojevich.homebrew ];

  radojevich.homebrew.darwin =
    { pkgs, inputs', ... }:
    {
      imports = [ ];
    };
}
