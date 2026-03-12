{ inputs, pkgs, ... }:
{
  imports = [
    # 1. Hardware and Base
    ./hardware-configuration.nix
    ../../base/nix.nix
    ../../base/users.nix
    ../../base/locale.nix
    ../../base/stylix.nix

    # 2. Features (Compositor and Login)
    ../../features/niri.nix
    ../../features/greeter.nix

    # 3. Gaming (NVIDIA)
    # ../../features/gaming.nix
  ];

  # --- HOST IDENTITY ---
  # This sets the network name for this specific machine.
  networking.hostName = "nixos";

  # --- BOOT & KERNEL ---
  # systemd-boot: Modern UEFI bootloader.
  # kernelParams: Fixes for your specific backlight and ACPI issues.
  boot.initrd.systemd.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [
    "i2c-dev"
    "i2c-piix4"
  ];
  boot.kernelParams = [
    "acpi_enforce_rsources=lax"
  ];

  # --- HARDWARE SERVICES ---
  systemd.services.NetworkManager-wait-online.enable = false;
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.i2c.enable = true;
  services.gvfs.enable = true; # Needed for mounting drives/phones in Thunar
  services.tumbler.enable = true;

  # --- SYSTEM PACKAGES ---
  # These are available to all users.
  # We moved Zsh and Niri specifics out, keeping general tools here.
  environment.systemPackages = with pkgs; [
    brightnessctl # Screen brightness control
    playerctl # Media (play/pause) control
    git # Version control
    blueman # Bluetooth manager GUI
    libmtp # Phone connection support
    powertop # Battery usage analysis
    i2c-tools # Hardware debugging
    usbutils # lsusb command
    libnotify # notify-send
  ];

  # --- auto mount HDD (/dev/sda1) at /mnt ---
  fileSystems."/mnt" = {
    device = "/dev/disk/by-uuid/4CF809A7F809907E";
    fsType = "ntfs3";
    options = [
      "rw"
      "uid=1000"
      "gid=100"
      "nofail"
    ];
  };

  # --- BATTERY CONSERVATION MODE TOGGLE ---
  security.sudo.extraRules = [
    {
      users = [ "jawknee" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004\\:00/conservation_mode";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  # --- FONTS ---
  fonts = {
    # Preferable to set to false, but maybe, I might try setting
    # it to true and see what happens
    enableDefaultPackages = false;
    fontDir.enable = true;
    packages = with pkgs; [
      # Google Noto Fonts for normal day to day tasks
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji

      # Nerd Fonts
      maple-mono.NF # NOTE: looped l may not show due to Italics not being used
      nerd-fonts.symbols-only

      # For document-like fonts
      inter
    ];

    fontconfig = {
      antialias = true;
      hinting = {
        enable = true;
        style = "slight";
      };
      subpixel = {
        rgba = "rgb";
      };

      defaultFonts = {
        serif = [
          "Noto Serif"
        ];
        sansSerif = [
          "Inter"
          "Noto Sans"
          "Noto Sans CJK"
        ];
        monospace = [
          "Maple Mono NF"
          "Noto Sans Mono"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  # --- PROGRAMS & SECURITY ---
  # Thunar: File manager with plugins for archives and volumes.
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman
      thunar-archive-plugin
    ];
  };

  # --- PAM Services for Swaylock ---
  security.pam.services.swaylock = { };

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # <--- Add/Change this here
    pulse.enable = true;
  };

  # SSH: Starts the ssh-agent for key management.
  programs.ssh.startAgent = true;
  services.gnome.gcr-ssh-agent.enable = false;

  # Android & Misc
  programs.adb.enable = true;
  security.polkit.enable = true;

  # --- FIREWALL ---
  # Opens port 53317 for LocalSend (TCP/UDP).
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [ 53317 ];
  };

  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };

  # --- HOME MANAGER ---
  # This links your human user 'jawknee' to the home.nix config.
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.jawknee = import ../../../../home.nix;
  };

  # --- VERSIONING ---
  # This must stay the same as when you first installed.
  system.stateVersion = "25.11";
}
