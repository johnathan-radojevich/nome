{ den, radojevich, ... }:

let
  commonSsh = onePassPath: {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks."*" = {
      forwardAgent = false;
      addKeysToAgent = "no";
      compression = false;
      serverAliveInterval = 0;
      serverAliveCountMax = 3;
      hashKnownHosts = false;
      userKnownHostsFile = "~/.ssh/known_hosts";
      controlMaster = "no";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "no";
    };

    extraConfig = ''
      Host *
          IdentityAgent "${onePassPath}"
    '';
  };

  commonGit = program: {
    enable = true;
    settings = {
      gpg.format = "ssh";
      gpg.ssh = {
        program = program;
      };
      commit.gpgsign = true;
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMkUPXUK1HFtEDsrFTAnat+a9ah5vZ8wkpGVEJRzGUCV";
    };
  };

in
{
  flake-file.inputs._1password-shell-plugins.url = "github:1Password/shell-plugins";

  radojevich.everywhere.includes = [ radojevich.secrets ];

  den.aspects.radojevich.includes = [
    (den.provides.unfree [
      "1password-cli"
      "1password"
      "raycast"
    ])
  ];

  radojevich.secrets = {
    darwin = {
      programs = {
        _1password.enable = true;
        _1password-gui.enable = true;
      };
    };

    nixos =
      { inputs, pkgs, ... }:
      {
        imports = [ inputs._1password-shell-plugins.nixosModules.default ];

        programs = {
          _1password-shell-plugins = {
            enable = true;
            plugins = with pkgs; [
              gh
              awscli2
              cachix
            ];
          };

          _1password-cli.enable = true;
          _1password-gui = {
            enable = true;
            polkitPolicyOwners = [ "radojevich" ];
          };
        };
      };

    hmDarwin =
      { pkgs, ... }:
      let
        onePassPath = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
      in
      {
        home.sessionVariables.SSH_AUTH_SOCK = onePassPath;

        programs.git = commonGit "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";

        programs.ssh = commonSsh onePassPath;

        home.packages = [
          pkgs.yubikey-manager
        ];
      };

    hmLinux =
      { lib, pkgs, ... }:
      let
        onePassPath = "~/.config/.1password/agent.sock";
      in
      {
        home.sessionVariables.SSH_AUTH_SOCK = onePassPath;

        programs.git = commonGit (lib.getExe' pkgs._1password-gui "op-ssh-sign");

        programs.ssh = commonSsh onePassPath;
      };
  };
}
