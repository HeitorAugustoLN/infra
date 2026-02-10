{
  system.steam = {
    nixos =
      { pkgs, ... }:
      {
        programs.steam = {
          enable = true;
          extraCompatPackages = [ pkgs.proton-ge-bin ];
        };
      };

    homeManager.home.persistence."/persistent".directories = [
      ".local/share/Steam"
      ".steam"
    ];
  };
}
