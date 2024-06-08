{ lib, fetchFromGitHub, rustPlatform, pkgs }:

rustPlatform.buildRustPackage rec {
  pname = "ytermusic";
  version = "6f9384924d17dc2626b5f0f0e1585cd6f6830073";

  src = fetchFromGitHub {
    owner = "ccgauche";
    repo = pname;
    rev = version;
    hash = "sha256-478yGGtD8NxPCWKpBicJV/eMqPj/yBlqzkv49uK6O5k=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    allowBuiltinFetchGit = true;
  };

  postPatch = ''
    rm Cargo.lock
    ln -s ${./Cargo.lock} Cargo.lock
  '';

  nativeBuildInputs = with pkgs; [
    pkg-config
    #rustPlatform.bindgenHook
  ];

  buildInputs = with pkgs; [
    alsa-tools
    alsa-lib
    dbus
  ];

  meta = with lib; {
    description = "YTerMusic";
    homepage = "https://github.com/ccgauche/ytermusic";
    license = licenses.asl20;
    maintainers = [ ];
  };
}
