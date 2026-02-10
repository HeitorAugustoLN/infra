{
  heitor.blender.homeManager =
    { pkgs, ... }:
    {
      home = {
        packages = [ pkgs.blender ];
        persistence."/persistent".directories = [ ".config/blender" ];
      };
    };
}
