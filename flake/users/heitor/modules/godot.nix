{
  heitor.godot.homeManager =
    { pkgs, ... }:
    {
      home = {
        packages = with pkgs; [
          godot
          godot-export-templates-bin
        ];

        persistence."/persistent".directories = [
          ".config/godot"
          ".local/share/godot"
        ];
      };
    };
}
