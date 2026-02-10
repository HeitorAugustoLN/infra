{ inputs, ... }:
{
  system.disko = devicesFile: {
    nixos.imports = [
      inputs.disko.nixosModules.default
      devicesFile
    ];
  };
}
