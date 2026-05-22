{ inputs, pkgs, ... }: {
  home.packages = [
    inputs.noctalia.packages.${pkgs.system}.default
  ];

  xdg.configFile."noctalia/config.json" = {
    source = ./config.json;
  };

  home.file.".cache/noctalia/wallpapers.json" = {
    source = ./wallpapers.json;
  };
}
