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
, lib
}:

let
  pythonPath = python3.withPackages (p: [ p.websockets ]);
in
stdenv.mkDerivation rec {
  pname = "wallpaper-engine-kde-plugin";
  version = "1e604105c586c7938c5b2c19e3dc8677b2eb4bb4";

  src = fetchFromGitHub {
    owner = "catsout";
    repo = pname;
    rev = version;
    hash = "sha256-bKGQxyS8gUi+37lODLVHphMoQwLKZt/hpSjR5MN+5GA=";
    fetchSubmodules = true;
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

  meta = with lib; {
    description = "A wallpaper plugin integrating wallpaper engine into kde wallpaper setting.";
    homepage = "https://github.com/catsout/wallpaper-engine-kde-plugin";
    license = licenses.gpl2;
  };
}
