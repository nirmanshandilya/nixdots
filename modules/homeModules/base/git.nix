{ pkgs, ... }: {
  programs.git = {
    enable = true;
    package = pkgs.git.override { withLibsecret = true; };

    # All these were moved inside 'settings'
    settings = {
      user = {
        name = "nirmanshandilya";
        email = "173679367+nirmanshandilya@users.noreply.github.com"; 
      };
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };

    ignores = [
      "*~"
      "*.swp"
      ".DS_Store"
      "desktop.ini"
    ];
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false; 
    
    settings = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
