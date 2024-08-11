{ lib
, python3Packages
, fetchFromGitHub
, kdePackages
, writeShellScriptBin
}:

python3Packages.buildPythonApplication rec {
  pname = "kde-material-you-colors";
  version = "1.9.3";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "luisbocanegra";
    repo = "kde-material-you-colors";
    rev = "v${version}";
    hash = "sha256-hew+aWbfWmqTsxsNx/0Ow0WZAVl0e6OyzDxcKm+nlzQ=";
  };

  build-system = with python3Packages; [
    setuptools
  ];

  dependencies = with python3Packages; [
    dbus-python
    numpy
    pillow
    materialyoucolor
  ];

  propagatedBuildInputs = [
    (writeShellScriptBin "qdbus6" ''${kdePackages.qttools}/bin/qdbus "$@"'')
  ];

  dontWrapQtApps = true;

  passthru.widget = kdePackages.callPackage ./widget { inherit version src; };

  meta = with lib; {
    description = "Automatic color scheme generator from your wallpaper for KDE Plasma powered by Material You";
    homepage = "https://github.com/luisbocanegra/kde-material-you-colors";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ kostek001 ];
  };
}
