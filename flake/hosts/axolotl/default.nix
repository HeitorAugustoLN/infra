{ heitor, system, ... }:
{
  den.hosts.x86_64-linux.axolotl.users.heitor = { };

  den.aspects = {
    axolotl.includes = with system; [
      (disko ./_disk-configuration.nix)
      (facter ./facter.json)
      firewalld
      geoclue
      gnome
      ibus
      impermanence
      kernel
      (keymap "br-abnt2")
      (locale "pt_BR.UTF-8")
      networkmanager
      nix
      nixpkgs
      openssh
      piper
      pipewire
      secure-boot
      sops
      steam
      (timezone "America/Sao_Paulo")
      userborn
      xdg
      zram
    ];

    heitor.includes = with heitor; [
      blender
      catppuccin
      davinci-resolve
      direnv
      discord
      firefox
      gh
      ghostty
      git
      (gnome {
        xkb = {
          layout = "br";
          options = [ "terminate:ctrl_alt_bksp" ];
        };
      })
      godot
      mullvad-browser
      neovim
      nushell
      obs-studio
      proton-vpn
      starship
      tor-browser
    ];
  };
}
