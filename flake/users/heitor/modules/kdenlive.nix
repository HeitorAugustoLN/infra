{
  den,
  lib,
  self,
  ...
}:
{
  flake.overlays.kdenlive = final: prev: {
    kdePackages = prev.kdePackages.overrideScope (
      kdeFinal: kdePrev: {
        kdenlive = kdePrev.kdenlive.overrideAttrs (oldAttrs: {
          qtWrapperArgs = oldAttrs.qtWrapperArgs ++ [
            "--prefix"
            "PATH"
            ":"
            (lib.makeBinPath [
              (prev.python3.withPackages (
                p: with p; [
                  opencv4
                  requests
                  numpy
                  openai-whisper
                  torch
                  srt
                  sam2
                ]
              ))
            ])
            "--suffix"
            "XDG_DATA_DIRS"
            ":"
            "${prev.gtk3}/share/gsettings-schemas/${prev.gtk3.name}"
          ];
        });
      }
    );
  };

  heitor.kdenlive = den.lib.parametric {
    includes = [
      (
        { host, ... }:
        {
          ${host.class}.nixpkgs.overlays = [ self.overlays.kdenlive ];
        }
      )
      (
        { home, ... }:
        {
          ${home.class}.nixpkgs.overlays = [ self.overlays.kdenlive ];
        }
      )
    ];

    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.kdePackages.kdenlive ];
      };
  };
}
