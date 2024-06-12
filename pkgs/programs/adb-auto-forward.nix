{ python3Packages
, fetchFromGitHub
, android-tools
, coreutils
, lib
}:

python3Packages.buildPythonApplication rec {
  pname = "adb-auto-forward";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "kostek001";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-gcbPjSAORHypy6WkQ32GU8EZJrPrclx7gE2ABb6kYvI=";
  };

  dependencies = with python3Packages; [
    pyudev
  ];

  propagatedBuildInputs = [
    android-tools
    coreutils
  ];

  doCheck = false;

  meta = with lib; {
    description = "Automatically forward TCP ports using ADB on device connection";
    homepage = "https://github.com/kostek001/adb-auto-forward";
    changelog = "https://github.com/kostek001/adb-auto-forward/releases/tag/v${version}";
    license = licenses.gpl3;
  };
}
