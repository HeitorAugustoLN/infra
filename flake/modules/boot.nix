{
  nodes.boot.nixos.boot = {
    initrd.systemd.enable = true;
    tmp.useTmpfs = true;
  };
}
