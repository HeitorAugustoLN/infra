{
  heitor.blender.homeManager =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.blender ];
    };
}
