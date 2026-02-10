{ inputs, ... }:
{
  heitor.catppuccin.homeManager = {
    imports = [ inputs.catppuccin.homeModules.catppuccin ];

    catppuccin = {
      accent = "blue";
      flavor = "mocha";
    };
  };
}
