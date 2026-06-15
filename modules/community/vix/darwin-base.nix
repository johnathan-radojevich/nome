{ inputs, ... }:
{
  flake-file.inputs.darwin.url = "github:LnL7/nix-darwin";

  vix.darwin-base = {
    darwin =
      { pkgs, ... }:
      {
        networking.applicationFirewall.enable = true;
        system.defaults.controlcenter.BatteryShowPercentage = true;
        system.defaults.dock.autohide = true;
        system.defaults.trackpad.Clicking = true;
        system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
        system.keyboard.enableKeyMapping = true;
        system.keyboard.remapCapsLockToEscape = true;
        system.defaults.NSGlobalDomain.AppleIconAppearanceTheme = "RegularAutomatic";
        environment.systemPackages = with inputs.darwin.packages.${pkgs.stdenvNoCC.hostPlatform.system}; [
          darwin-option
          darwin-rebuild
          darwin-version
          darwin-uninstaller
        ];
      };
  };
}
