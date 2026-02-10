{
  heitor.git.homeManager =
    { config, ... }:
    {
      programs.git = {
        enable = true;

        settings = {
          commit.gpgsign = true;
          gpg.format = "ssh";
          init.defaultBranch = "main";

          user = {
            name = "Heitor Augusto";
            signingkey = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
          };
        };

        includes = [
          {
            condition = "hasconfig:remote.*.url:git@github.com:*/**";
            contents.user.email = "44377258+HeitorAugustoLN@users.noreply.github.com";
          }
        ];
      };
    };
}
