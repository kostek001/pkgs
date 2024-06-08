{ inputs, ... }: {
  imports = [ inputs.flake-parts.flakeModules.easyOverlay ];

  perSystem = { config, system, pkgs, ... }: {
    # _module.args.pkgs = import inputs.nixpkgs {
    #   inherit system;
    #   config.allowUnfree = true;
    # };

    overlayAttrs = {
      inherit (config.packages) wallpaper-engine-kde-plugin alvr slimevr adb-auto-forward ytermusic;
    };

    packages = with pkgs; {
      wallpaper-engine-kde-plugin = callPackage ./desktop/plasma/wallpaper-engine-kde-plugin { };

      alvr = callPackage ./games/alvr.nix { };
      slimevr = callPackage ./games/slimevr.nix { };

      adb-auto-forward = callPackage ./programs/adb-auto-forward.nix { };
      ytermusic = callPackage ./programs/ytermusic { };
    };
  };
}
