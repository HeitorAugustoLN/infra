{
  heitor.zsh = {
    includes = [
      (
        { host, ... }:
        {
          ${host.class}.programs.zsh.enable = true;
        }
      )
    ];

    user =
      { pkgs, ... }:
      {
        shell = pkgs.zsh;
      };

    homeManager =
      { config, pkgs, ... }:
      {
        catppuccin.zsh-syntax-highlighting.enable = true;

        programs.zsh = {
          enable = true;
          dotDir = "${config.xdg.configHome}/zsh";

          autosuggestion.enable = true;
          enableCompletion = true;
          syntaxHighlighting.enable = true;

          history = {
            size = 10000;
            path = "${config.xdg.dataHome}/zsh/history";
            ignoreDups = true;
            ignoreAllDups = true;
            share = true;
          };

          plugins = [
            {
              name = "vi-mode";
              src = pkgs.zsh-vi-mode;
              file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
            }
          ];
        };
      };
  };
}
