{ lib, ... }:
{
  den = {
    ctx.hm-host.includes = [
      (
        { host, ... }:
        {
          ${host.class}.home-manager = {
            backupFileExtension = "bak";
            overwriteBackup = true;
            useGlobalPkgs = true;
            useUserPackages = true;
            verbose = true;
          };
        }
      )
    ];

    schema.user.classes = lib.mkDefault [ "homeManager" ];
  };
}
