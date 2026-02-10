{ den, inputs, ... }:
{
  heitor.neovim = den.lib.parametric {
    includes = [
      (
        { host, ... }:
        {
          ${host.class}.nixpkgs.overlays = [ inputs.neovim.overlays.default ];
        }
      )
      (
        { home, ... }:
        {
          ${home.class}.nixpkgs.overlays = [ inputs.neovim.overlays.default ];
        }
      )
    ];

    homeManager =
      { pkgs, ... }:
      {
        home = {
          packages = [ pkgs.nvim-heitor ];

          sessionVariables = {
            EDITOR = "nvim";
            MANPAGER = "nvim +Man!";
            VISUAL = "nvim";
          };
        };
      };
  };
}
