{ pkgs, ... }: {

  users.users.jawknee = {
    isNormalUser = true;
    description = "jawknee";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "i2c" "video" ];
    shell = pkgs.zsh;
  };

  # The Greeter user for tuigreet
  users.users.greeter = {
    isSystemUser = true;
    group = "greeter";
    extraGroups = [ "video" ]; 
  };

  users.groups.greeter = {};

  programs.zsh.enable = true;
  programs.zsh.enableGlobalCompInit = false;
}
