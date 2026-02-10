{
  heitor.direnv.homeManager = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    home.persistence."/persistent".directories = [ ".local/share/direnv" ];
  };
}
