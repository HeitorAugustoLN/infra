{
  den.default.includes = [
    (
      { host, ... }:
      {
        ${host.class}.networking.hostName = host.name;
      }
    )
    (
      { host, ... }:
      {
        nixos.networking.hostId = builtins.substring 0 8 (builtins.hashString "md5" host.name);
      }
    )
  ];
}
