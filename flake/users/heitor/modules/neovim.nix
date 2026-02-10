{ den, inputs, ... }:
{
  heitor.neovim = den.lib.parametric.exactly {
    includes = [
      (
        { OS, host }:
        den.lib.take.unused OS { ${host.class}.nixpkgs.overlays = [ inputs.neovim.overlays.default ]; }
      )
      (
        { HM, home }:
        den.lib.take.unused HM { ${home.class}.nixpkgs.overlays = [ inputs.neovim.overlays.default ]; }
      )
    ];

    homeManager =
      { pkgs, ... }:
      {
        home =
          let
            appName = "nvim-heitor";
          in
          {
            packages = [ pkgs.${appName} ];

            persistence."/persistent".directories = [ ".cache/${appName}" ];

            sessionVariables = {
              EDITOR = "nvim";
              MANPAGER = "nvim +Man!";
              VISUAL = "nvim";
            };
          };
      };
  };
}
