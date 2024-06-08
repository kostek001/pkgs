{ inputs, ... }: {
  imports = [ inputs.flake-parts.flakeModules.easyOverlay ];

  perSystem = { system, pkgs, ... }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
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
