{
  system.firewalld.nixos = {
    services.firewalld.enable = true;
    networking.nftables.enable = true;
  };
}
