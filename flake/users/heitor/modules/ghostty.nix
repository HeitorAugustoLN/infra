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

          keybind = [
            "super+ctrl+shift+j=resize_split:down,10"
            "super+ctrl+shift+h=resize_split:left,10"
            "super+ctrl+shift+l=resize_split:right,10"
            "super+ctrl+shift+k=resize_split:up,10"
            "ctrl+alt+j=goto_split:down"
            "ctrl+alt+h=goto_split:left"
            "ctrl+alt+l=goto_split:right"
            "ctrl+alt+k=goto_split:up"
            "ctrl+shift+h=previous_tab"
            "ctrl+shift+l=next_tab"
            "shift+j=adjust_selection:down"
            "shift+h=adjust_selection:left"
            "shift+l=adjust_selection:right"
            "shift+k=adjust_selection:up"
          ];

          mouse-hide-while-typing = true;
          window-theme = "ghostty";
        };
      };
    };
}
