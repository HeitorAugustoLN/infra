{ den, ... }:
{
  den.default = {
    includes = [ den._.define-user ];
    nixos.users.mutableUsers = false;
  };
}
