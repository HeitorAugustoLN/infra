{
  nodes.piper.nixos =
    { pkgs, ... }:
    {
      services.ratbagd.enable = true;
      environment.systemPackages = [ pkgs.piper ];
    };
}
