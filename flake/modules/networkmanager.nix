{
  nodes.networkmanager.nixos.networking.networkmanager = {
    enable = true;
    ethernet.macAddress = "random";

    wifi = {
      macAddress = "random";
      scanRandMacAddress = true;
    };
  };
}
