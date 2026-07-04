{ pkgs, ... }:
let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "jake_the_dog"; # current sddm theme name
    themeConfig = {
      ScreenWidth = "1920";
      ScreenHeight = "1080";
      FontSize = "14";
      FontName = "Open Sans";
    };
  };
in {
  services.displayManager = {
    defaultSession = "niri";
    sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "sddm-astronaut-theme";
      wayland.enable = true;
      extraPackages = [
        sddm-astronaut
        pkgs.kdePackages.qtmultimedia
        pkgs.kdePackages.qtsvg
      ];
    };
  };

  environment.systemPackages = [ sddm-astronaut ];
}
