{
  den,
  inputs,
  lib,
  ...
}:
{
  nodes.nix.provides = {
    flakes.includes =
      let
        common =
          let
            flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
          in
          {
            nix = {
              nixPath = lib.mapAttrsToList (flake: _: "${flake}=flake:${flake}") flakeInputs;
              registry = builtins.mapAttrs (_: flake: { inherit flake; }) flakeInputs;

              settings = {
                experimental-features = [
                  "nix-command"
                  "flakes"
                ];

                flake-registry = "/etc/nix/registry.json";
              };
            };
          };
      in
      [
        (den.lib.perHost (
          { host }:
          {
            ${host.class} = common // {
              nix.channel.enable = false;
            };
          }
        ))
        (den.lib.perHome (
          { home }:
          {
            ${home.class} = common;
          }
        ))
      ];

    remoteBuilders.includes =
      let
        common =
          { config, ... }:
          {
            sops.secrets =
              let
                key = {
                  inherit (config.users.users.heitor) group;
                  mode = "0400";
                  owner = config.users.users.heitor.name;
                  sopsFile = ../../secrets/hosts/common.yaml;
                };
              in
              {
                "heitor/darwin-builders-key" = key;
                "heitor/nixos-builders-key" = key;
              };

            nix = {
              buildMachines =
                let
                  common = {
                    protocol = "ssh-ng";
                    sshKey = config.sops.secrets."heitor/nixos-builders-key".path;
                    sshUser = "heitor";

                    supportedFeatures = [
                      "benchmark"
                      "big-parallel"
                      "kvm"
                      "nixos-test"
                    ];
                  };
                in
                map (builder: common // builder) [
                  {
                    hostName = "build-box.nix-community.org";
                    maxJobs = 8;
                    publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUVsSVE1NHFBeTdEaDYzckJ1ZFlLZGJ6SkhycmJyck1YTFlsN1BrbWs4OEgK";

                    systems = [
                      "i686-linux"
                      "riscv64-linux"
                      "x86_64-linux"
                    ];
                  }
                  {
                    hostName = "aarch64-build-box.nix-community.org";
                    maxJobs = 16;
                    publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUc5dXlmaHlsaStCUnRrNjR5K25pcXRiK3NLcXVSR0daODdmNFlSYzhFRTEK";

                    systems = [
                      "aarch64-linux"
                      "armv7l-linux"
                    ];
                  }
                  {
                    hostName = "darwin-build-box.nix-community.org";
                    maxJobs = 4;
                    publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUtNSGhsY243ZlVwVXVpT0ZlSWhEcUJ6Qk5Gc2JOcXErTnB6dUdYM2U2enYgCg==";
                    sshKey = config.sops.secrets."heitor/darwin-builders-key".path;
                    supportedFeatures = [ "big-parallel" ];

                    systems = [
                      "aarch64-darwin"
                      "x86_64-darwin"
                    ];
                  }
                ];

              distributedBuilds = true;
            };
          };
      in
      [
        (den.lib.perHost (
          { host }:
          {
            ${host.class} = common;
          }
        ))
        (den.lib.perHome (
          { home }:
          {
            ${home.class} = common;
          }
        ))
      ];

    settings.includes =
      let
        settings =
          let
            KB = 1000;
            MB = KB * 1000;
            GB = MB * 1000;
          in
          {
            auto-optimise-store = true;
            builders-use-substitutes = true;
            connect-timeout = 5;
            experimental-features = [ "pipe-operators" ];
            fallback = true;
            http-connections = 128;
            log-lines = 30;
            max-free = 25 * GB; # 25 GB
            min-free = 5 * GB; # 5 GB
            max-jobs = "auto";
            max-substitution-jobs = 128;
            substituters = [ "https://heitor.cachix.org" ];
            trusted-public-keys = [ "heitor.cachix.org-1:IZ1ydLh73kFtdv+KfcsR4WGPkn+/I926nTGhk9O9AxI=" ];
            use-xdg-base-directories = true;
          };
      in
      [
        (den.lib.perHost (
          { host }:
          {
            ${host.class}.nix = { inherit settings; };
          }
        ))
        (den.lib.perHome (
          { home }:
          {
            ${home.class}.nix = { inherit settings; };
          }
        ))
      ];

    trustedUser.includes = [
      (den.lib.perUser (
        { host, user }:
        {
          ${host.class}.nix.settings.trusted-users = lib.mkAfter [ user.userName ];
        }
      ))
      (den.lib.perHome (
        { home }:
        {
          ${home.class}.nix.settings.trusted-users = lib.mkAfter [ home.userName ];
        }
      ))
    ];
  };
}
