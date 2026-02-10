{
  den,
  inputs,
  self,
  ...
}:
{
  nodes.sops = den.lib.parametric {
    includes =
      let
        mkHomeAspect = type: {
          ${type.class} =
            { config, ... }:
            {
              imports = [ inputs.sops-nix."${type.class}Modules".sops ];

              sops = {
                age.sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id-ed25519" ];
                defaultSopsFile = "${self}/secrets/users/${type.userName}.yaml";
              };
            };
        };
      in
      [
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
        ({ user, ... }: mkHomeAspect user)
        ({ home, ... }: mkHomeAspect home)
      ];
  };
}
