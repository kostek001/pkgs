{ lib
, stdenv
, cmake
, extra-cmake-modules
, libplasma
, plasma5support
  # Shared values
, version
, src
}:

stdenv.mkDerivation rec {
  pname = "kde-material-you-colors-widget";
  inherit version src;

  patches = [ ./fixBackendCommand.patch ];

  nativeBuildInputs = [
    cmake
    extra-cmake-modules
  ];

  buildInputs = [
    libplasma
    plasma5support
  ];

  dontWrapQtApps = true;
  cmakeFlags = [ "-DINSTALL_PLASMOID=ON" ];

  meta = with lib; {
    description = "Widget for kde-material-you-colors";
    homepage = "https://github.com/luisbocanegra/kde-material-you-colors";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ kostek001 ];
  };
}
