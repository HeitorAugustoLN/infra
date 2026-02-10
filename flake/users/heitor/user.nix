{
  _heitor.user =
    let
      username = "heitor";
    in
    {
      homeManager.home = {
        inherit username;
        homeDirectory = "/home/${username}";
      };

      nixos.users = {
        mutableUsers = false;

        users.${username} = {
          description = "Heitor Augusto";

          extraGroups = [
            "networkmanager"
            "wheel"
          ];

          isNormalUser = true;
          hashedPassword = "$y$j9T$/S5B/tg9PMfK2Uru2s5/b.$0P45sOpCVHYbPSgDtZ9g0Lpblh9w/MIQeV3xp6gjVI1"; # temporary
        };
      };
    };
}
