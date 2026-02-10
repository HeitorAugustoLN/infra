{ den, ... }:
{
  den.default.includes = [
    (
      { host, user, ... }@ctx:
      den.lib.parametric.fixedTo ctx {
        includes = [ (den.aspects.${user.aspect}._.${host.aspect} or { }) ];
      }
    )
  ];
}
