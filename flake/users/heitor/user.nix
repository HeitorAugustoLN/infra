{ lib, ... }:
{
  _heitor.user =
    let
      username = "heitor";
    in
    {
      user.description = "Heitor Augusto";
      nixos.sops.secrets."${username}/password".neededForUsers = true;

      includes = [
        (
          { host, ... }:
          lib.optionalAttrs (host.class == "nixos") {
            user =
              { config, ... }:
              {
                extraGroups = [
                  "networkmanager"
                  "wheel"
                ];

                hashedPasswordFile = config.sops.secrets."${username}/password".path;
              };
          }
        )
      ];
    };
}
