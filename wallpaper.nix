{ width ? 1920, height ? 1080, wallpaper }:
{ stdenv
, imagemagick
}:
stdenv.mkDerivation {
  pname = "procedural-wallpapers";
  version = "0.0.1";
  buildInputs = [ imagemagick ];
  src = builtins.path { path = ./.; };
  buildPhase = ''
    gcc \
      -s -Ofast -lm src/lib/* \
      -DWID=${toString width} \
      -DHEI=${toString height} \
      src/${wallpaper}.c \
      -o ${wallpaper}.o
      ./${wallpaper}.o wallpaper.ppm
    convert wallpaper.ppm wallpaper.jpg
  '';
  installPhase = ''
    mkdir -p $out
    cp wallpaper.jpg $out/
  '';
}
