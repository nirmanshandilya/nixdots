{ config, lib, pkgs, ... }:

{
  # Enable unfree packages for the NVIDIA driver
  nixpkgs.config.allowUnfree = true;

  # Instruct X11/Wayland to use the NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    
    # Use the proprietary, closed-source driver
    open = false; 
    nvidiaSettings = true;

    # Hybrid Graphics Configuration (Optimus Offload)
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      
      nvidiaBusId = "PCI:1:0:0"; 
      amdgpuBusId = "PCI:5:0:0"; 
    };
  };
}
