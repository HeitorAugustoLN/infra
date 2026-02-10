{
  heitor.nushell = {
    nixos =
      { lib, pkgs, ... }:
      let
        inherit (pkgs) nushell;
      in
      {
        environment.shells = [
          nushell
          (lib.getExe nushell)
        ];

        users.users.heitor.shell = nushell;
      };

    homeManager.programs = {
      carapace.enable = true;

      nushell = {
        enable = true;

        settings = {
          edit_mode = "vi";
          show_banner = false;
        };
      };
    };
  };
}
