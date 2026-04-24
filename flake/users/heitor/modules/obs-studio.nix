{
  heitor.obs-studio.homeManager =
    { pkgs, ... }:
    {
      programs.obs-studio = {
        enable = true;
        plugins = [ pkgs.obs-studio-plugins.obs-vaapi ];
      };
    };
}
