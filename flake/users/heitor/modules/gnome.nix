{
  heitor.gnome =
    {
      xkb ? {
        layout = null;
        variant = null;
        options = null;
      },
    }:
    let
      xkb' = {
        layout = xkb.layout or null;
        variant = xkb.variant or null;
        options = xkb.options or null;
      };
    in
    {
      homeManager =
        { lib, pkgs, ... }:
        let
          extensions = with pkgs.gnomeExtensions; [
            alphabetical-app-grid
            appindicator # I hate system tray, but some apps keep using this awful behavior.
          ];
        in
        {
          home = {
            packages = extensions;
            persistence."/persistent".directories = [ ".config/dconf" ];
          };

          dconf = {
            enable = true;

            settings =
              let
                wallpaperSettings =
                  let
                    wallpaperUri =
                      let
                        wallpaper = pkgs.runCommand "black-wallpaper.png" { nativeBuildInputs = [ pkgs.imagemagick ]; } ''
                          magick -size 3840x2160 xc:black $out
                        '';
                      in
                      "file://${wallpaper}";
                  in
                  {
                    color-shading-type = "solid";
                    picture-options = "zoom";
                    picture-uri = wallpaperUri;
                    primary-color = "#000000000000";
                    secondary-color = "#000000000000";
                  };
              in
              {
                "org/gnome/desktop/background" = wallpaperSettings // {
                  picture-uri-dark = wallpaperSettings.picture-uri;
                };

                "org/gnome/desktop/break-reminders".selected-breaks = [
                  "movement"
                  "eyesight"
                ];

                "org/gnome/desktop/break-reminders/eyesight".play-sound = true;

                "org/gnome/desktop/break-reminders/movement" = {
                  duration-seconds = lib.gvariant.mkUint32 300;
                  interval-seconds = lib.gvariant.mkUint32 1800;
                  play-sound = true;
                };

                "org/gnome/desktop/input-sources" = lib.mkIf (xkb'.layout != null) (
                  {
                    sources = [
                      (
                        if xkb'.variant == null then
                          lib.gvariant.mkTuple [
                            "xkb"
                            xkb'.layout
                          ]
                        else
                          lib.gvariant.mkTuple [
                            "xkb"
                            xkb'.layout
                            xkb'.variant
                          ]
                      )
                    ];
                  }
                  // lib.optionalAttrs (xkb'.options != null) { xkb-options = xkb'.options; }
                );

                "org/gnome/desktop/interface" = {
                  clock-format = "24h";
                  clock-show-weekday = true;
                  colorscheme = "prefer-dark";
                  gtk-enable-primary-paste = false; # Awful behavior, disabled by default in GNOME 50 (finally), but currently it is not.
                };

                "org/gtk/settings/file-chooser".clock-format = "24h";
                "org/gnome/desktop/notifications".show-in-lock-screen = false;
                "org/gnome/desktop/screensaver" = wallpaperSettings;

                "org/gnome/desktop/peripherals/mouse" = {
                  accel-profile = "flat";
                  speed = 0.0;
                };

                "org/gnome/shell".enabled-extensions = map (extension: extension.extensionUuid) extensions;
              };
          };
        };
    };
}
