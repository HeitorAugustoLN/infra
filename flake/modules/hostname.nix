{
  den.default.includes = [
    (
      { host, ... }:
      {
        ${host.class}.networking.hostName = host.hostName;
      }
    )
    (
      { host, ... }:
      {
        nixos.networking.hostId = builtins.substring 0 8 (builtins.hashString "md5" host.hostName);
      }
    )
  ];
}
