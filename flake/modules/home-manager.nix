{ lib, ... }:
{
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  den.ctx.host.includes = [
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
}
