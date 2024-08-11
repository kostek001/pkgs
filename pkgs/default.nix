{ inputs, ... }: {
  imports = [ inputs.flake-parts.flakeModules.easyOverlay ];

  perSystem = { config, pkgs, ... }: {
    overlayAttrs = {
      inherit (config.packages) plasma-smart-video-wallpaper-reborn wallpaper-engine-kde-plugin alvr slimevr adb-auto-forward ytermusic;
    };

    packages = with pkgs; {
      kde-material-you-colors = callPackage ./desktop/plasma/kde-material-you-colors { };
      plasma-smart-video-wallpaper-reborn = callPackage ./desktop/plasma/plasma-smart-video-wallpaper-reborn { };
      wallpaper-engine-kde-plugin = callPackage ./desktop/plasma/wallpaper-engine-kde-plugin { };

      alvr = callPackage ./games/alvr.nix { };
      slimevr = callPackage ./games/slimevr.nix { };

      adb-auto-forward = callPackage ./programs/adb-auto-forward.nix { };
      ytermusic = callPackage ./programs/ytermusic { };
    };
  };
}
