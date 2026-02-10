{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          age
          just
          nixos-facter
          sops
          ssh-to-age
        ];
      };
    };
}
