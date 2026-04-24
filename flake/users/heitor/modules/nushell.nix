{ den, ... }:
{
  heitor.nushell = {
    includes = [
      (den.lib.perHost (
        { host }:
        {
          ${host.class} =
            { lib, pkgs, ... }:
            {
              # TODO: Upstream a NixOS module for Nushell?
              environment = {
                systemPackages = [ pkgs.nushell ];

                shells = [
                  (lib.getExe pkgs.nushell)
                  "/run/current-system/sw/bin/nu"
                ];
              };
            };
        }
      ))
    ];

    user =
      { pkgs, ... }:
      {
        shell = pkgs.nushell;
      };

    homeManager = {
      catppuccin.nushell.enable = true;

      programs = {
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
  };
}
