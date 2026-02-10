{ inputs, ... }:
{
  system.secure-boot.nixos =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

      environment = {
        persistence."/persistent".directories = [ config.boot.lanzaboote.pkiBundle ];
        systemPackages = [ pkgs.sbctl ];
      };

      boot = {
        lanzaboote = {
          enable = true;
          pkiBundle = "/var/lib/sbctl";

          autoEnrollKeys = {
            enable = true;
            autoReboot = true;
          };

          autoGenerateKeys.enable = true;
        };

        loader = {
          efi.canTouchEfiVariables = true;
          systemd-boot.enable = lib.mkForce false;
        };
      };
    };
}
