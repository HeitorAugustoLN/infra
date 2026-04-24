{ heitor, nodes, ... }:
{
  den = {
    hosts.x86_64-linux.axolotl.users.heitor = { };

    aspects = {
      axolotl = {
        includes = with nodes; [
          boot
          (disko ./_disk-configuration.nix)
          (facter ./facter.json)
          firewalld
          geoclue
          gnome
          ibus
          kernel
          (keymap "br-abnt2")
          locale
          networkmanager
          nh
          nix._.flakes
          nix._.remoteBuilders
          nix._.settings
          openssh
          piper
          pipewire
          sops
          steam
          systemd-boot
          timezone._.automatic
          zram
        ];

        provides.to-users.includes = [ nodes.xdg ];
      };

      heitor.provides.axolotl.includes = with heitor; [
        catppuccin
        direnv
        discord
        firefox
        gh
        ghostty
        gimp
        git
        (gnome { inputSources = [ "br" ]; })
        helium
        kdenlive
        helix
        mullvad-browser
        nushell
        obs-studio
        proton-vpn
        starship
        tor-browser
      ];
    };
  };
}
