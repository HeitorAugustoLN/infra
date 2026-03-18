{
  nodes.timezone.provides = {
    automatic.nixos.services.automatic-timezoned.enable = true;

    manual = timeZone: {
      includes = [
        (
          { host, ... }:
          {
            ${host.class}.time.timeZone = timeZone;
          }
        )
      ];
    };
  };
}
