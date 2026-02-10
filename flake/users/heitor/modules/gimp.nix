{
  heitor.gimp.homeManager =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.gimp ];
    };
}
