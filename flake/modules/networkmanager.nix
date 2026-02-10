{
  system.networkmanager.nixos = {
    networking.networkmanager = {
      enable = true;

      ethernet.macAddress = "random";

      wifi = {
        macAddress = "random";
        scanRandMacAddress = true;
      };
    };

    environment.persistence."/persistent".directories = [ "/etc/NetworkManager/system-connections" ];
  };
}
