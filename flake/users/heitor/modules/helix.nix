{ den, inputs, ... }:
{
  heitor.helix = {
    includes = [
      (den.lib.perUser (
        { host, ... }:
        {
          ${host.class}.nixpkgs.overlays = [ inputs.helix.overlays.default ];
        }
      ))
      (den.lib.perHome (
        { home }:
        {
          ${home.class}.nixpkgs.overlays = [ inputs.helix.overlays.default ];
        }
      ))
    ];

    homeManager =
      { pkgs, ... }:
      {
        home = {
          packages = [ pkgs.hx ];

          sessionVariables = {
            EDITOR = "hx";
            VISUAL = "hx";
          };
        };
      };
  };
}
