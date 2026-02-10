{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          nixos-facter
          sops
          ssh-to-age
        ];
      };
    };
}
