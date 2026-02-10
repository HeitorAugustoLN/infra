{ den, ... }:
{
  system.timezone =
    timeZone:
    den.lib.parametric {
      includes = [
        (
          { host, ... }:
          {
            ${host.class}.time.timeZone = timeZone;
          }
        )
      ];
    };
}
