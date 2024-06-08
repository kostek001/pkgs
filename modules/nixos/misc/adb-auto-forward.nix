{ config, pkgs, lib, ... }:
with lib;

let
  cfg = config.services.adb-auto-forward;
in
{
  options.services.adb-auto-forward = {
    enable = mkEnableOption "ADB Auto Forward";
  };

  config = mkIf cfg.enable {
    # TODO: make module
  };
}
