# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ self, inputs, ... }: {
  flake.nixosModules.hostMain =
    { pkgs, ... }:
    {
      imports = [
        # Import disko configuration
        #        inputs.disko.nixosModules.disko
        #        self.diskoConfigurations.hostMain
        ../../browsers/_zen-browser.nix
      ];

      programs = {
        vim.enable = true;
        nano.enable = false;
      };
      # Bootloader.
      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
          # Hide the OS choice for bootloaders.
          # It's still possible to open the bootloader list by pressing any key
          # It will just not appear on screen unless a key is pressed
          timeout = 0;
        };

        # For plymouth. See https://wiki.nixos.org/wiki/Plymouth
        plymouth = {
          enable = true;
        };

        # For plymouth
        consoleLogLevel = 3;
        initrd.verbose = false;

        kernelParams = [
          "zswap.enabled=1" # enables zswap
          "zswap.compressor=zstd" # compression algorithm
          "zswap.max_pool_percent=20" # maximum percentage of RAM that zswap is allowed to use
          "zswap.shrinker_enabled=1" # whether to shrink the pool proactively on high memory pressure
          # "i915.enable_guc=3" # Enabling xe now creates some problems in gaming

          # Plymouth specific
          "quiet"
          "splash"
          "rd.udev.log_level=3"
          "rd.systemd.show_status=auto"
        ];
        kernelPackages = pkgs.linuxPackages_latest;
      };

      networking.hostName = "nixos"; # Define your hostname.
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      # Configure network proxy if necessary
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

      services = {
        # Enable touchpad support (enabled default in most desktopManager).
        libinput.enable = true;
        # Enable CUPS to print documents.
        # printing.enable = true;
        # Enable btrfs autoscrub service for btrfs managed machines
        btrfs.autoScrub = {
          enable = false;
          interval = "weekly";
          fileSystems = [ "/" ];
        };
      };

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      # Some programs need SUID wrappers, can be configured further or are
      # started in user sessions.
      # programs.mtr.enable = true;
      # programs.gnupg.agent = {
      #   enable = true;
      #   enableSSHSupport = true;
      # };

      # List services that you want to enable:

      # Enable the OpenSSH daemon.
      # services.openssh.enable = true;

      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      # networking.firewall.enable = false;

      # host specific cpu settings
      nix.settings = {
        cores = 4;
        max-jobs = 1;
      };

      # ----------------- auto-mount HDD -------------------
      fileSystems."/mnt" = {
        device = "/dev/disk/by-uuid/4CF809A7F809907E";
        fsType = "ntfs-3g";
        options = [
          "rw"
          "uid=1000"
          "gid=1000"
          "nofail"
        ];
      };

      hardware = {
        bluetooth.enable = true;
        enableRedistributableFirmware = true;
        # intel-gpu-tools.enable = true;
        graphics = {
          enable = true;

          /*
            package = pkgs.mesa;
            extraPackages = with pkgs; [
              intel-media-driver
              intel-compute-runtime
              vpl-gpu-rt
              vulkan-loader
              vulkan-validation-layers
              libvpl
            ];
          */
        };
      };
      environment.systemPackages = with pkgs; [
        bluetui

        signal-desktop
        vscode
        postman
        p7zip
      ];
    };
}
