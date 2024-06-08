{ python3Packages
, fetchFromGitHub
, android-tools
, coreutils
}:

python3Packages.buildPythonApplication rec {
  pname = "adb-auto-forward";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "kostek001";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-JFZmCssyIYGl5BHVCh8yTtbpH68QG2+FqfBA6fH+uUU=";
  };

  dependencies = with python3Packages; [
    pyudev
  ];

  propagatedBuildInputs = [
    android-tools
    coreutils
  ];

  doCheck = false;
}
