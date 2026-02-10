{
  heitor.starship.homeManager =
    { config, ... }:
    {
      catppuccin.starship.enable = true;

      programs.starship = {
        enable = true;
        enableTransience = config.programs.fish.enable;
      };
    };
}
