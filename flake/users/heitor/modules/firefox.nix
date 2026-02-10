{ inputs, ... }:
{
  heitor.firefox.homeManager =
    { config, lib, ... }:
    {
      imports = [ inputs.arkenfox-nix.homeModules.arkenfox ];

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

            "5000" = {
              enable = true;

              "5003" = {
                enable = true;
                "signon.rememberSignons".enable = true;
              };

              "5017" = {
                enable = true;
                "extensions.formautofill.addresses.enabled".enable = true;
                "extensions.formautofill.creditCards.enabled".enable = true;
              };
            };

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

          settings =
            let
              enableDrm = {
                "browser.eme.ui.enabled" = true;
                "media.eme.enabled" = true;
              };

              # https://github.com/Tiagoquix/firefox-annoyances/blob/37af5a9b1db750e13320fb5f77ed28788a587611/annoyances.js#L9-L63
              noAiSlop = {
                "browser.ml.chat.page" = false;
                "browser.translations.enable" = false;
                "browser.ml.enable" = false;
                "browser.ml.chat.enabled" = false;
                "browser.ml.linkPreview.enabled" = false;
                "browser.tabs.groups.smart.enabled" = false;
                "browser.tabs.groups.smart.userEnabled" = false;
                "extensions.ml.enabled" = false;
                "pdfjs.enableAltText" = false;
                "pdfjs.enableAltTextForEnglish" = false;
                "pdfjs.enableGuessAltText" = false;
                "pdfjs.enableAltTextModelDownload" = false;
                "browser.urlbar.quicksuggest.mlEnabled" = false;
                "places.semanticHistory.featureGate" = false;
              };

              # https://github.com/Tiagoquix/firefox-annoyances/blob/37af5a9b1db750e13320fb5f77ed28788a587611/annoyances.js#L65-L95
              noMozillaAdvertising = {
                "browser.contentblocking.report.hide_vpn_banner" = true;
                "browser.contentblocking.report.mobile-android.url" = "";
                "browser.contentblocking.report.mobile-ios.url" = "";
                "browser.contentblocking.report.show_mobile_app" = false;
                "browser.contentblocking.report.vpn-android.url" = "";
                "browser.contentblocking.report.vpn-ios.url" = "";
                "browser.contentblocking.report.vpn-promo.url" = "";
                "browser.contentblocking.report.vpn.url" = "";
                "browser.privatebrowsing.vpnpromourl" = "";
                "browser.promo.focus.enabled" = false;
                "browser.promo.pin.enabled" = false;
                "browser.vpn_promo.enabled" = false;
                "identity.mobilepromo.android" = "";
                "identity.mobilepromo.ios" = "";
                "identity.sendtabpromo.url" = "";
                "browser.preferences.moreFromMozilla" = false;
                "lightweightThemes.getMoreURL" = "";
              };
            in
            lib.mergeAttrsList [
              enableDrm
              noAiSlop
              noMozillaAdvertising
            ];
        };

        policies = {
          Cookies.Allow =
            let
              github = [ "https://github.com" ];

              proton = [
                "https://account.proton.me"
                "https://proton.me"
              ];
            in
            builtins.concatLists [
              github
              proton
            ];

          "3rdparty".Extensions."uBlock0@raymondhill.net".adminSettings =
            let
              importedLists = [
                "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
              ];
            in
            builtins.toJSON {
              userSettings = {
                advancedUserEnabled = true;
                externalLists = builtins.concatStringsSep "\n" importedLists;
                inherit importedLists;
                popupPanelSections = 63; # Show everything in the pop-up panel
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
              ]
              ++ importedLists;

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

                    youtube = [
                      "www.youtube.com google.com * noop"
                      "www.youtube.com google.com.br * noop"
                    ];
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

              userFilters = builtins.concatStringsSep "\n" [ ];
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
