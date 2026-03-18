{ den, ... }:
{
  den.ctx.host.includes = [
    den._.hostname
    (
      { host, ... }:
      {
        nixos.networking.hostId = builtins.substring 0 8 (builtins.hashString "md5" host.hostName);
      }
    )
  ];
}
