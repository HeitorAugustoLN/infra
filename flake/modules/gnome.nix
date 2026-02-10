{
  nodes.gnome.nixos =
    { pkgs, ... }:
    {
      environment.gnome.excludePackages = with pkgs; [
        epiphany
        gnome-tour
        yelp
      ];

      services = {
        desktopManager.gnome.enable = true;
        displayManager.gdm.enable = true;
      };
    };
}
