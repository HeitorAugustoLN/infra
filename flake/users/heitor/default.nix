{ _heitor, nodes, ... }:
{
  den.aspects.heitor.includes = [
    nodes.nix._.trustedUser
    _heitor.user
  ];
}
