{ buildFHSEnv, fetchzip, writeText, fetchurl }:
let
  name = "alvr";
  version = "20.8.1";

  src = fetchzip {
    url = "https://github.com/alvr-org/ALVR/releases/download/v${version}/alvr_streamer_linux.tar.gz";
    hash = "sha256-8bQpEnzK4ZGE5P49Gh/fmxgyCBFTzD511q6aZxe0B/Y=";
  };

  desktopFile = writeText "alvr.desktop" ''
    [Desktop Entry]
    Version=1.0
    Type=Application
    Name=ALVR
    GenericName=VR Streamer
    Comment=ALVR is an open source remote VR display which allows playing SteamVR games on a standalone headset such as Gear VR or Oculus Go/Quest.
    Exec=${name}
    Icon=alvr
    Categories=Game;
    StartupNotify=true
    PrefersNonDefaultGPU=true
    X-KDE-RunOnDiscreteGpu=true
    StartupWMClass=ALVR
    X-AppImage-Version=20.6.1
  '';

  desktopIcon = fetchurl {
    url = "https://raw.githubusercontent.com/alvr-org/ALVR/73af025f617366046fdb456959e0cef7bbdb8917/resources/alvr.png";
    hash = "sha256-SnUtyS/eDne09SRzd+Kj5Ux/XENJcIHShptkMAyfi98=";
  };
in
buildFHSEnv {
  inherit name;

  targetPkgs = pkgs: (with pkgs; [
    ffmpeg
    libva
    alsa-lib
    egl-wayland
    libxkbcommon
    libGL
    wayland
  ]);

  extraInstallCommands = ''
    install -m 444 -D ${desktopFile} $out/share/applications/alvr.desktop

    install -m 444 -D ${desktopIcon} \
      $out/share/icons/hicolor/256x256/apps/alvr.png
  '';

  runScript = "${src}/bin/alvr_dashboard";
}
