{
  nodes.systemd-boot.nixos.boot.loader = {
    efi.canTouchEfiVariables = true;

    systemd-boot = {
      enable = true;
      editor = false; # Fix a security hole in place for backwards compatibility.
    };
  };
}
