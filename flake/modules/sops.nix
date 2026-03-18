{ inputs, self, ... }:
{
  nodes.sops = {
    homeManager =
      { config, ... }:
      {
        imports = [ inputs.sops-nix.homeModules.sops ];

        sops = {
          age.sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id-ed25519" ];
          defaultSopsFile = "${self}/secrets/users/${config.home.username}.yaml";
        };
      };

    includes = [
      (
        { host, ... }:
        {
          ${host.class} =
            { config, ... }:
            {
              imports = [ inputs.sops-nix."${host.class}Modules".sops ];

              sops = {
                age.sshKeyPaths =
                  config.services.openssh.hostKeys
                  |> builtins.filter (key: key.type == "ed25519")
                  |> map (key: key.path);

                defaultSopsFile = "${self}/secrets/hosts/${host.hostName}.yaml";
              };
            };
        }
      )
    ];
  };
}
