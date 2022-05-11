{
  description = "Procedural Wallpapers";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    {
      overlays.default = final: prev: {
        # TODO(jared): generate matrix of common resolutions
        wallpapers = prev.lib.genAttrs
          [ "clouds" "fern" "flow" "islands" "landscape" "lightning" "marrowlike" "mesh" "tangles" "water" "wood" "zebra" ]
          (wallpaper: prev.callPackage (import ./wallpaper.nix { inherit wallpaper; }) { });
      };
    } //
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          overlays = [ self.overlays.default ];
          inherit system;
        };
      in
      {
        packages = pkgs.wallpapers;
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [ imagemagick gcc ];
        };
      });
}
