{
  system.openssh.nixos = {
    services.openssh = {
      enable = true;

      hostKeys = [
        {
          path = "/etc/ssh/host-ed25519-key";
          type = "ed25519";
        }
      ];

      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    environment.persistence."/persistent".files = [
      "/etc/ssh/host-ed25519-key"
      "/etc/ssh/host-ed25519-key.pub"
    ];
  };
}
