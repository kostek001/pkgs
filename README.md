# kostek001-pkgs

Collection of Nix packages and modules in a flake.

## Features

Modules:

- Home Manager
  - `adb-auto-forward`

Packages:

- [`kde-material-you-colors`](https://github.com/luisbocanegra/kde-material-you-colors) v1.9.3 – contains only backend  
  `kde-material-you-colors.widget` – contains widget and screenshot_helper
- [`plasma-smart-video-wallpaper-reborn`](https://github.com/luisbocanegra/plasma-smart-video-wallpaper-reborn) [commit](https://github.com/luisbocanegra/plasma-smart-video-wallpaper-reborn/tree/6e36385b08372da5b0a45fb1f32eedf8337f08eb)
- [`wallpaper-engine-kde-plugin`](https://github.com/catsout/wallpaper-engine-kde-plugin) [commit](https://github.com/catsout/wallpaper-engine-kde-plugin/tree/1e604105c586c7938c5b2c19e3dc8677b2eb4bb4)
- [`alvr`](https://github.com/alvr-org/ALVR) v20.8.1
- [`slimevr`](https://github.com/SlimeVR/SlimeVR-Server) v0.12.1
- [`ytermusic`](https://github.com/ccgauche/ytermusic) [commit](https://github.com/ccgauche/ytermusic/tree/6f9384924d17dc2626b5f0f0e1585cd6f6830073)
- [`adb-auto-forward`](https://github.com/kostek001/adb-auto-forward) v0.1.1

⚠️ For `wallpaper-engine-kde-plugin` and `plasma-smart-video-wallpaper-reborn` packages add `qt6.qtwebsockets`, `qt6.qtmultimedia` packages too.

## Usage

Add `github:kostek001/pkgs` to your flake inputs:

```nix
inputs = {
  # ...
  kostek001-pkgs = {
    url = "github:kostek001/pkgs";
    # Only if using nixpkgs-unstable
    inputs.nixpkgs.follows = "nixpkgs";
  };
};
```

### Add packages

With `inputs.kostek001-pkgs.packages.${pkgs.system}.<package>`

or apply `nixpkgs` overlay

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
