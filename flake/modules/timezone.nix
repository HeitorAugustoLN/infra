{ den, ... }:
{
  nodes.timezone.provides = {
    automatic.nixos.services.automatic-timezoned.enable = true;

    manual = timeZone: {
      includes = [
        (den.lib.perHost (
          { host }:
          {
            ${host.class}.time = { inherit timeZone; };
          }
        ))
      ];
    };
  };
}
