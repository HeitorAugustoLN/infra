{ den, ... }:
{
  den.default.includes = [
    den._.home-manager
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
