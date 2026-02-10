{
  heitor.davinci-resolve = {
    nixos.hardware.amdgpu.opencl.enable = true;

    homeManager =
      { pkgs, ... }:
      {
        home = {
          packages = [ pkgs.davinci-resolve ];

          persistence."/persistent".directories = [
            ".cache/DaVinci_Resolve_Welcome"
            ".local/share/DaVinciResolve"
          ];
        };
      };
  };
}
