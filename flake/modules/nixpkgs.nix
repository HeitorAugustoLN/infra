{
  system.nixpkgs.nixos.nixpkgs.config = {
    allowAliases = false;
    allowBroken = false;
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };
}
