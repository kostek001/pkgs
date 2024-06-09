# nixos-pkgs

Nix packages and modules

# Features

Modules:

- Home Manager
  - `adb-auto-forward`

Packages:
- [`plasma-smart-video-wallpaper-reborn`](https://github.com/luisbocanegra/plasma-smart-video-wallpaper-reborn) [commit](https://github.com/luisbocanegra/plasma-smart-video-wallpaper-reborn/tree/6e36385b08372da5b0a45fb1f32eedf8337f08eb)
- [`wallpaper-engine-kde-plugin`](https://github.com/catsout/wallpaper-engine-kde-plugin) [commit](https://github.com/catsout/wallpaper-engine-kde-plugin/tree/96230de92f1715d3ccc5b9d50906e6a73812a00a)
- [`alvr`](https://github.com/alvr-org/ALVR) v20.8.1
- [`slimevr`](https://github.com/SlimeVR/SlimeVR-Server) v0.12.1
- [`ytermusic`](https://github.com/ccgauche/ytermusic) [commit](https://github.com/ccgauche/ytermusic/tree/6f9384924d17dc2626b5f0f0e1585cd6f6830073)
- [`adb-auto-forward`](https://github.com/kostek001/adb-auto-forward) v0.1.0

## Usage

Add `github:kostek001/nixos-pkgs` to your flake inputs:

```nix
inputs = {
  # ...
  kostek001-pkgs = {
    url = "github:kostek001/nixos-pkgs";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};
```

### Apply NixOS overlay

```nix
{ inputs, ... }:
{
  nixpkgs.overlays = [ inputs.kostek001-pkgs.overlays.default ];
}
```

### Add modules

```nix
{ inputs, ... }:
{
  # NixOS module
  imports = [ inputs.kostek001-pkgs.nixosModules.<module> ];
  # Home Manager module
  home-manager.sharedModules = [ inputs.kostek001-pkgs.homeManagerModules.<module> ];
}
```
