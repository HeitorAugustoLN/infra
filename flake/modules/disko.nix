{ inputs, ... }:
{
  nodes.disko = devicesFile: {
    nixos.imports = [
      inputs.disko.nixosModules.default
      devicesFile
    ];
  };
}
