{ pkgs, ... }: # NOTE: Why pass top-level attrset twice? Use a nil and nixd as lsp for nix
{
  # 1. SYSTEM LEVEL: Enable the compositor for the display manager
  programs.niri.enable = true;

  # WARN: Lot of things missing here from the niri-flake repo, expect some problems
}
