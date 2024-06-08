# nixos-pkgs

Nix packages and modules

## Usage

Add `github:kostek001/nixos-pkgs` to your flake inputs:
```nix
inputs = {
  kostek001-pkgs = {
    url = "github:kostek001/nixos-pkgs";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};
```
