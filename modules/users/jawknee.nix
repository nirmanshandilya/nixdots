{
  flake.nixosModules.jawknee = { pkgs, ... }: {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users."jawknee" = {
      isNormalUser = true;
      description = "jawknee";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      shell = pkgs.zsh;
      initialPassword = "1234";
    };
  };

  flake.homeModules.jawknee = {
    home = {
      username = "jawknee";
      homeDirectory = "/home/jawknee";
      stateVersion = "26.05";
    };

    programs.home-manager.enable = true;
  };
}
