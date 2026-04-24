{
  heitor.starship.homeManager =
    { config, ... }:
    {
      catppuccin.starship.enable = true;

      programs = {
        nushell.environmentVariables = {
          PROMPT_INDICATOR_VI_INSERT = "";
          PROMPT_INDICATOR_VI_NORMAL = "";
        };

        starship = {
          enable = true;
          enableTransience = config.programs.fish.enable;
        };
      };
    };
}
