{
  nodes.kernel.nixos =
    { pkgs, ... }:
    {
      boot.kernelPackages = pkgs.linuxPackages_latest;
      security.protectKernelImage = true;
    };
}
