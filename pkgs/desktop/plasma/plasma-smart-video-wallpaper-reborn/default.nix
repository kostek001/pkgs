{ stdenv
, fetchFromGitHub
, cmake
, kdePackages
, qt6
, lib
}:

stdenv.mkDerivation rec {
  pname = "plasma-smart-video-wallpaper-reborn";
  version = "6e36385b08372da5b0a45fb1f32eedf8337f08eb";

  src = fetchFromGitHub {
    owner = "luisbocanegra";
    repo = pname;
    rev = version;
    hash = "sha256-S3TKI0mBTKYeo/195NiM9Kr5C6cteT1hhoJ+MEfy/Sc=";
  };

  patches = [ ./cmake.patch ];

  nativeBuildInputs = [
    cmake
    qt6.wrapQtAppsHook
    kdePackages.extra-cmake-modules
  ];

  propagatedBuildInputs = [
    qt6.qtbase
    qt6.qtmultimedia
  ] ++ (with kdePackages; [
    libplasma
    kdeclarative
    qt5compat
    plasma5support
    kirigami
    kcoreaddons
  ]);
  strictDeps = true;

  meta = with lib; {
    description = "Plasma 6 Wallpaper plugin to play videos on your Desktop/Lock Screen.";
    homepage = "https://github.com/luisbocanegra/plasma-smart-video-wallpaper-reborn";
    license = licenses.gpl2;
  };
}
