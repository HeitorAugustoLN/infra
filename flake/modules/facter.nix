{
  nodes.facter = reportPath: {
    nixos.hardware.facter = {
      detected.dhcp.enable = false;
      inherit reportPath;
    };
  };
}
