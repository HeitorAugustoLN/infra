{
  heitor.gnome =
    {
      inputSources ? [ ],
    }:
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
          home.packages = extensions;

          dconf = {
            enable = true;

            settings =
              let
                g = lib.gvariant;

                wallpaper = {
                  color-shading-type = "solid";
                  picture-options = "zoom";

                  picture-uri =
                    let
                      wallpaper = pkgs.runCommand "catppuccin-mocha-crust.png" {
                        nativeBuildInputs = [ pkgs.imagemagick ];
                      } ''magick -size 1x1 xc:"#11111B" "$out"'';
                    in
                    "file://${wallpaper}";

                  primary-color = "#11111B";
                  secondary-color = "#000000";
                };
              in
              {
                "org/gnome/desktop/background" = wallpaper // {
                  picture-uri-dark = wallpaper.picture-uri;
                };

                "org/gnome/desktop/break-reminders".selected-breaks = [
                  "movement"
                  "eyesight"
                ];

                "org/gnome/desktop/break-reminders/eyesight".play-sound = true;

                "org/gnome/desktop/break-reminders/movement" = {
                  duration-seconds = g.mkUint32 300;
                  interval-seconds = g.mkUint32 1800;
                  play-sound = true;
                };

                "org/gnome/desktop/input-sources" = {
                  sources = map (
                    keyboard:
                    lib.gvariant.mkTuple [
                      "xkb"
                      (
                        if builtins.isString keyboard then
                          keyboard
                        else if keyboard.variant or null == null then
                          keyboard.layout
                        else
                          "${keyboard.layout}+${keyboard.variant}"
                      )
                    ]
                  ) inputSources;

                  xkb-options = [ ];
                };

                "org/gnome/desktop/interface" = {
                  clock-format = "24h";
                  clock-show-weekday = true;
                  color-scheme = "prefer-dark";
                  gtk-enable-primary-paste = false; # Awful behavior, disabled by default in GNOME 50 (finally), but currently it is not.
                };

                "org/gtk/settings/file-chooser".clock-format = "24h";
                "org/gnome/desktop/notifications".show-in-lock-screen = false;

                "org/gnome/desktop/screensaver" = wallpaper // {
                  lock-enabled = true;
                  lock-delay = 0;
                };

                "org/gnome/desktop/session".idle-delay = g.mkUint32 300;

                "org/gnome/desktop/peripherals/mouse" = {
                  accel-profile = "flat";
                  speed = 0.0;
                };

                "org/gnome/desktop/privacy" = {
                  old-files-age = g.mkUint32 30;
                  remove-old-trash-files = true;
                };

                "org/gnome/settings-daemon/plugins/color" = {
                  night-light-enabled = true;
                  night-light-schedule-automatic = false;
                  night-light-schedule-from = 18.0;
                  night-light-schedule-to = 6.0;
                  night-light-temperature = g.mkUint32 1800;
                };

                "org/gnome/settings-daemon/plugins/housekeeping".donation-reminder-enabled = false;

                "org/gnome/shell" = {
                  enabled-extensions = map (extension: extension.extensionUuid) extensions;

                  favorite-apps = map (app: "${app}.desktop") [
                    "org.gnome.Nautilus"
                    "com.mitchellh.ghostty"
                    "firefox"
                  ];
                };

                "org/gnome/shell/weather".automatic-location = true;
                "org/gnome/system/location".enabled = true;
              };
          };
        };
    };
}
