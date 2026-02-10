{
  heitor.proton-vpn = {
    nixos.networking.firewall.checkReversePath = false;

    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.protonvpn-gui ];
      };
  };
}
