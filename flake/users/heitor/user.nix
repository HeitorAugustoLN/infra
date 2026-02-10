{
  _heitor.user =
    let
      username = "heitor";
    in
    {
      homeManager.home = {
        homeDirectory = "/home/${username}";
        inherit username;
      };

      nixos =
        { config, ... }:
        {
          sops.secrets."heitor/password".neededForUsers = true;

          users = {
            mutableUsers = false;

            users.${username} = {
              description = "Heitor Augusto";

              extraGroups = [
                "networkmanager"
                "wheel"
              ];

              hashedPasswordFile = config.sops.secrets."heitor/password".path;
              isNormalUser = true;
            };
          };
        };
    };
}
