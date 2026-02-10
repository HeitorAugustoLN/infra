{ den, ... }:
{
  nodes.nh = den.lib.parametric {
    includes = [
      (
        { host, ... }:
        {
          ${host.class}.programs.nh = {
            enable = true;
            flake = "/home/heitor/infra"; # temp

            clean = {
              enable = true;
              extraArgs = "--keep-since 7d";
              dates = "weekly";
            };
          };
        }
      )
      (
        { home, ... }:
        {
          ${home.class} =
            { config, ... }:
            {
              programs.nh = {
                enable = true;
                flake = "${config.home.homeDirectory}/infra"; # temp

                clean = {
                  enable = true;
                  extraArgs = "--keep-since 7d";
                  dates = "weekly";
                };
              };
            };
        }
      )
    ];
  };
}
