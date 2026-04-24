{ den, ... }:
{
  nodes.nh.includes = [
    (den.lib.perHost (
      { host }:
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
    ))
    (den.lib.perHome (
      { home }:
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
    ))
  ];
}
