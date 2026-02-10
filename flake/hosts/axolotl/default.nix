{ heitor, nodes, ... }:
{
  den = {
    hosts.x86_64-linux.axolotl.users.heitor = { };

    aspects = {
      axolotl.includes = with nodes; [
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
        nix
        nixpkgs
        openssh
        piper
        pipewire
        sops
        steam
        systemd-boot
        (timezone "America/Sao_Paulo")
        xdg
        zram
      ];

      heitor.includes = with heitor; [
        blender
        catppuccin
        direnv
        discord
        firefox
        gh
        ghostty
        gimp
        git
        (gnome { inputSources = [ "br" ]; })
        godot
        kdenlive
        mullvad-browser
        neovim
        obs-studio
        proton-vpn
        starship
        tor-browser
        zsh
      ];
    };
  };
}
