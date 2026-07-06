{ den, radojevich, ... }:
{
  flake-file.inputs.nix-claude-code = {
    url = "github:ryoppippi/nix-claude-code";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake-file.nixConfig = {
    extra-substituters = [ "https://ryoppippi.cachix.org" ];
    extra-trusted-public-keys = [
      "ryoppippi.cachix.org-1:b2LbtWNvJeL/qb1B6TYOMK+apaCps4SCbzlPRfSQIms="
    ];
  };

  radojevich.everywhere.includes = [ radojevich.ai ];
  radojevich.ai.includes = [
    (den.provides.unfree [
      "claude"
    ])
  ];

  radojevich.ai.darwin =
    { pkgs, ... }:
    {
      homebrew = {
        casks = [
          "cursor"
        ];
      };
    };

  radojevich.ai.hm =
    { inputs', ... }:
    {
      home.packages = [
        inputs'.nix-claude-code.packages.default
      ];
    };
}
