{
  heitor.godot.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        godot
        godot-export-templates-bin
      ];
    };
}
