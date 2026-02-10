{
  heitor.starship.homeManager =
    { config, ... }:
    {
      programs.starship = {
        enable = true;
        enableTransience = config.programs.fish.enable;
      };
    };
}
