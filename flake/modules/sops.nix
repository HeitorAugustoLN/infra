{ inputs, self, ... }:
{
  system.sops = {
    nixos = {
      imports = [ inputs.sops-nix.nixosModules.sops ];
      sops.age.sshKeyFile = "/etc/ssh/host-ed25519-key";
    };

    homeManager =
      { config, ... }:
      {
        imports = [ inputs.sops-nix.homeManagerModules.sops ];

        sops = {
          age.sshKeyFile = "${config.home.homeDirectory}/.ssh/id-ed25519";
          defaultSopsFile = "${self}/secrets/users/${config.home.username}.yaml";
        };
      };
  };
}
