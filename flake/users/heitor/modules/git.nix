{
  heitor.git.homeManager.programs.git = {
    enable = true;

    settings = {
      init.defaultBranch = "main";
      user.name = "Heitor Augusto";
    };

    includes = [
      {
        condition = "hasconfig:remote.*.url:git@github.com:*/**";
        contents.user.email = "44377258+HeitorAugustoLN@users.noreply.github.com";
      }
    ];
  };
}
