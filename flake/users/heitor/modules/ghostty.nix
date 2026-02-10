{
  heitor.ghostty.homeManager =
    { pkgs, ... }:
    {
      catppuccin.ghostty.enable = true;
      home.packages = [ pkgs.nerd-fonts.geist-mono ];
      xdg.terminal-exec.settings.default = [ "ghostty.desktop" ];

      programs.ghostty = {
        enable = true;

        settings = {
          font-family = "GeistMono Nerd Font";
          font-size = 13;
          mouse-hide-while-typing = true;
          shell-integration = "none"; # home-manager does this automatically
          window-theme = "ghostty";
        };
      };
    };
}
