{ inputs, ... }:
{
  heitor.helium.homeManager =
    { pkgs, ... }:
    {
      home.packages = [ inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default ];
    };
}