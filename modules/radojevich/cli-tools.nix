{ radojevich, ... }:
{
  radojevich.everywhere.includes = [ radojevich.cli-tools ];

  radojevich.cli-tools.darwin =
    { pkgs, ... }:
    {
      environment.shells = [
        pkgs.nushell
      ];
    };

  radojevich.cli-tools.hm =
    { pkgs, config, ... }:
    {
      programs.nh.enable = true;

      programs.zsh.enable = true;
      programs.zsh.dotDir = "${config.xdg.configHome}/zsh";
      programs.zsh.initContent = ''
        if ! [ "$TERM" = "dumb" ] && [ -z "$BASH_EXECUTION_STRING" ]; then
          exec nu
        fi
      '';

      programs.nushell = {
        enable = true;

        configFile = {
          text = ''
            $env.config.show_banner = false

            def gcr [] {
              git checkout --orphan temp-branch
              git add -A
              git commit -m "initial commit"
              git branch -D main
              git branch -m main
              git push --force-with-lease origin main
            }

            def gc [] {
                let ghostty_dir = ($env.HOME | path join ".config" "ghostty")

                let files = (
                    ls $ghostty_dir
                    | where {|row| $row.type == "file" and (($row.name | path basename) != "config")}
                    | get name
                )

                let selection = (
                    $files
                    | each {|p| $p | path relative-to $ghostty_dir }
                    | str join "\n"
                    | fzf --preview $"cat '($ghostty_dir)/{}'"
                )

                if ($selection | is-empty) {
                    return
                }

                let config_file = ($ghostty_dir | path join "config")

                let content = (
                    open $config_file
                    | str replace -r '(config-file = [^/]+)/.*' ($'$1/' + $selection)
                )

                $content | save --force $config_file

                ^osascript [
                  -e 'tell application "Ghostty" to activate'
                  -e 'tell application "System Events" to keystroke "," using {command down, shift down}'
                 ]
            }
          '';
        };
      };

      programs.zoxide = {
        enable = true;
        enableBashIntegration = true;
        enableNushellIntegration = true;
        enableZshIntegration = true;
      };

      home.packages = with pkgs; [
        bat
        bottom
        duf
        devenv
        dust
        eza
        fd
        fzf
        glow
        htop
        ispell
        kubectl
        multimarkdown
        ouch
        procs
        ripgrep
        sd
        sshs
        tealdeer
        television
        tokei
        yazi
        zellij
      ];
    };
}
