{ inputs, ... }:
{
  heitor.firefox.homeManager =
    { config, lib, ... }:
    {
      imports = [ inputs.arkenfox-nix.homeModules.arkenfox ];

      home = {
        file.".mozilla/native-messaging-hosts".enable = false;

        persistence."/persistent".directories = [
          ".cache/mozilla"
          ".config/mozilla/firefox"
        ];
      };

      programs.firefox = {
        enable = true;
        configPath = "${config.xdg.configHome}/mozilla/firefox";

        arkenfox = {
          enable = true;

          profiles.heitor.settings = {
            "0000".enable = true;
            "0100".enable = true;
            "0200".enable = true;
            "0300".enable = true;
            "0400".enable = true;
            "0600".enable = true;
            "0700".enable = true;
            "0800".enable = true;
            "0900".enable = true;
            "1000".enable = true;
            "1200".enable = true;
            "1600".enable = true;
            "1700".enable = true;
            "2000".enable = true;
            "2400".enable = true;
            "2600".enable = true;
            "2700".enable = true;
            "2800".enable = true;
            "4000".enable = true;
            "4500".enable = true;
            "6000".enable = true;
            "8500".enable = true;
            "9000".enable = true;
          };
        };

        profiles.heitor = {
          isDefault = true;
          name = "Heitor Augusto";

          search = {
            default = "ddg";
            privateDefault = "ddg";
            force = true;

            engines = {
              ddg.metaData.alias = "!d";
              google.metaData.alias = "!g";
              wikipedia.metaData.alias = "!w";

              bing.metaData.hidden = true;
              perplexity.metaData.hidden = true;
              mercadolivre.metaData.hidden = true;
            };

            order = [
              "ddg"
              "google"
              "wikipedia"
            ];
          };
        };

        policies = {
          Cookies.Allow = [ "https://github.com" ];

          "3rdparty".Extensions."uBlock0@raymondhill.net".adminSettings =
            let
              legitimateURLShortener = "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt";
            in
            builtins.toJSON {
              userSettings =
                let
                  importedLists = [ legitimateURLShortener ];
                in
                {
                  advancedUserEnabled = true;
                  externalLists = builtins.concatStringsSep "\n" importedLists;
                  inherit importedLists;
                };

              selectedFilterLists = [
                "user-filters"
                "ublock-filters"
                "ublock-badware"
                "ublock-privacy"
                "ublock-quick-fixes"
                "ublock-unbreak"
                "easylist"
                "easyprivacy"
                "urlhaus-1"
                "plowe-0"
                "spa-1"
                legitimateURLShortener
              ];

              whitelist = [
                "chrome-extension-scheme"
                "moz-extension-scheme"
              ];

              dynamicFilteringString =
                let
                  default = [
                    "behind-the-scene * * noop"
                    "behind-the-scene * inline-script noop"
                    "behind-the-scene * 1p-script noop"
                    "behind-the-scene * 3p-script noop"
                    "behind-the-scene * 3p-frame noop"
                    "behind-the-scene * image noop"
                    "behind-the-scene * 3p noop"
                  ];

                  mediumMode = [
                    "* * 3p-script block"
                    "* * 3p-frame block"
                  ];

                  siteExceptions = {
                    github = [ "github.com githubassets.com * noop" ];
                    youtube = [ "www.youtube.com google.com * noop" ];
                  };
                in
                [
                  default
                  mediumMode
                  (builtins.attrValues siteExceptions)
                ]
                |> lib.flatten
                |> builtins.concatStringsSep "\n";

              hostnameSwitchesString = builtins.concatStringsSep "\n" [
                "no-large-media: behind-the-scene false"
                "no-csp-reports: * true"
              ];

              userFilters = "";
            };

          ExtensionSettings = {
            "*".installation_mode = "blocked";

            "uBlock0@raymondhill.net" = {
              default_area = "navbar";
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
              private_browsing = true;
            };

            "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
              default_area = "navbar";
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
              installation_mode = "force_installed";
            };
          };
        };
      };
    };
}
