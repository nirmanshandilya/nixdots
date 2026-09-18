# Battery module (for laptops)
# Use the battery module if host is a laptop
{
  flake.nixosModules.battery = {
    powerManagement.powertop.enable = true;
    services = {
      upower = {
        enable = true;
        usePercentageForPolicy = true;
        percentageCritical = 20;
      };
      thermald.enable = true;
      power-profiles-daemon.enable = true;
    };
  };
}
