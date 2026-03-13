{ pkgs, inputs, ... }: {
  # 1. SYSTEM LEVEL: Enable the compositor for the display manager
  programs.niri.enable = true;
  programs.niri.package = inputs.niri.packages.${pkgs.system}.niri-stable;

}
