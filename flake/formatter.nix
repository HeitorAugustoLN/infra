{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem.treefmt = {
    projectRootFile = "flake.nix";

    programs = {
      just.enable = true;
      keep-sorted.enable = true;

      nixf-diagnose = {
        enable = true;
        priority = -1;
      };

      nixfmt = {
        enable = true;
        strict = true;
      };

      prettier = {
        enable = true;
        includes = [ "*.md" ];
      };

      shellcheck.enable = true;
      shfmt.enable = true;
      stylua.enable = true;
      taplo.enable = true;
      yamlfmt.enable = true;
    };

    settings.on-unmatched = "info";
  };
}
