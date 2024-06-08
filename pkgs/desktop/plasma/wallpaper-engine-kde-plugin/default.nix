{ stdenv
, fetchFromGitHub
, cmake
, qt6
, kdePackages
, pkg-config
, vulkan-headers
, mpv
, libass
, lz4
, fribidi
, python3
}:

let
  wallpaper-scene-renderer = fetchFromGitHub {
    owner = "catsout";
    repo = "wallpaper-scene-renderer";
    rev = "eeaff7036526c87cb7dd46c849a5e9bd8e26e5f7";
    hash = "sha256-qE9K//tNRdFKEHV7liQemERta45cgd/jc5CNkAI6e5c=";
    fetchSubmodules = true;
  };
  pythonPath = python3.withPackages (p: [ p.websockets ]);
in
stdenv.mkDerivation rec {
  pname = "wallpaper-engine-kde-plugin";
  version = "96230de92f1715d3ccc5b9d50906e6a73812a00a";

  src = fetchFromGitHub {
    owner = "catsout";
    repo = pname;
    rev = version;
    hash = "sha256-KDNL6PNGSkpA+Zq0jzBoodJcbskAKR2onY+kYjgzEG8=";
  };

  patches = [ ./cmake.patch ];

  cmakeFlags = [
    "-DQT_MAJOR_VERSION=6"
  ];

  nativeBuildInputs = [
    cmake
    qt6.wrapQtAppsHook
    kdePackages.extra-cmake-modules
    pkg-config
  ];

  postPatch = ''
    rm -r src/backend_scene
    ln -s ${wallpaper-scene-renderer} src/backend_scene
  '';

  propagatedBuildInputs = [
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtwebsockets
    qt6.qtwebchannel

    vulkan-headers    
    mpv
    libass
    lz4
    fribidi
  ] ++ (with kdePackages; [
    libplasma
    kdeclarative
    qt5compat
    plasma5support
    kirigami
    kcoreaddons
  ]);
  strictDeps = true;

  postInstall = ''
    substituteInPlace $out/share/plasma/wallpapers/com.github.catsout.wallpaperEngineKde/contents/ui/Pyext.qml \
      --replace "/usr/share" "$out/share" \
      --replace "python3" "${pythonPath}/bin/python3"
  '';
}
