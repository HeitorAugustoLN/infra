{
  system.systemd-boot.nixos.boot.loader = {
    efi.canTouchEfiVariables = true;

    systemd-boot = {
      enable = true;
      # Fix a security hole in place for backwards compatibility.
      editor = false;
    };
  };
}
