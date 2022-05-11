{
  description = "Procedural Wallpapers";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let pkgs = import nixpkgs { inherit system; }; in
    {
      # TODO(jared): generate matrix of common resolutions
      packages = pkgs.lib.genAttrs
        [ "clouds" "fern" "flow" "islands" "landscape" "lightning" "marrowlike" "mesh" "tangles" "water" "wood" "zebra" ]
        (wallpaper: pkgs.callPackage (import ./wallpaper.nix { inherit wallpaper; }) { });
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [ imagemagick gcc ];
      };
    });
}
