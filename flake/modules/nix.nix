{ den, inputs, ... }:
{
  system.nix = den.lib.parametric.exactly {
    includes =
      let
        module =
          { lib, ... }:
          {
            # sops.secrets = {
            #   "heitor/nixos-builders-key" = {
            #     inherit (config.users.users.heitor) group;
            #     mode = "0400";
            #     owner = config.users.users.heitor.name;
            #     sopsFile = ../../../secrets/hosts/common/default.yaml;
            #   };

            #   "heitor/darwin-builders-key" = {
            #     inherit (config.users.users.heitor) group;
            #     mode = "0400";
            #     owner = config.users.users.heitor.name;
            #     sopsFile = ../../../secrets/hosts/common/default.yaml;
            #   };
            # };

            nix =
              let
                flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
              in
              {
                # buildMachines =
                #   let
                #     common = {
                #       protocol = "ssh-ng";
                #       sshKey = config.sops.secrets."heitor/nixos-builders-key".path;
                #       sshUser = "heitor";

                #       supportedFeatures = [
                #         "benchmark"
                #         "big-parallel"
                #         "kvm"
                #         "nixos-test"
                #       ];
                #     };
                #   in
                #   map (builder: common // builder) [
                #     {
                #       hostName = "build-box.nix-community.org";
                #       maxJobs = 8;
                #       publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUVsSVE1NHFBeTdEaDYzckJ1ZFlLZGJ6SkhycmJyck1YTFlsN1BrbWs4OEgK";

                #       systems = [
                #         "i686-linux"
                #         "riscv64-linux"
                #         "x86_64-linux"
                #       ];
                #     }
                #     {
                #       hostName = "aarch64-build-box.nix-community.org";
                #       maxJobs = 16;
                #       publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUc5dXlmaHlsaStCUnRrNjR5K25pcXRiK3NLcXVSR0daODdmNFlSYzhFRTEK";

                #       systems = [
                #         "aarch64-linux"
                #         "armv7l-linux"
                #       ];
                #     }
                #     {
                #       hostName = "darwin-build-box.nix-community.org";
                #       maxJobs = 4;
                #       publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUtNSGhsY243ZlVwVXVpT0ZlSWhEcUJ6Qk5Gc2JOcXErTnB6dUdYM2U2enYgCg==";
                #       sshKey = config.sops.secrets."heitor/darwin-builders-key".path;
                #       supportedFeatures = [ "big-parallel" ];

                #       systems = [
                #         "aarch64-darwin"
                #         "x86_64-darwin"
                #       ];
                #     }
                #   ];

                # distributedBuilds = true;

                nixPath = lib.mapAttrsToList (flake: _: "${flake}=flake:${flake}") flakeInputs;
                registry = builtins.mapAttrs (_: flake: { inherit flake; }) flakeInputs;

                settings = {
                  auto-optimise-store = true;
                  builders-use-substitutes = true;
                  connect-timeout = 5;

                  experimental-features = [
                    "flakes"
                    "nix-command"
                    "pipe-operators"
                  ];

                  fallback = true;
                  flake-registry = "/etc/nix/registry.json";
                  substituters = [ "https://heitor.cachix.org" ];
                  trusted-public-keys = [ "heitor.cachix.org-1:IZ1ydLh73kFtdv+KfcsR4WGPkn+/I926nTGhk9O9AxI=" ];
                  use-xdg-base-directories = true;
                };
              };
          };
      in
      [
        ({ OS, host }: den.lib.take.unused OS { ${host.class} = module; })
        ({ OS, host }: den.lib.take.unused OS { ${host.class}.nix.channel.enable = false; })
        ({ HM, home }: den.lib.take.unused HM { ${home.class} = module; })
      ];
  };
}
