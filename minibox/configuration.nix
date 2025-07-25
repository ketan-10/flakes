{
  config,
  modulesPath,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
    ./service/arr/jellyfin.nix
    ./service/arr/qbittorrent.nix
  ];
  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  services.openssh.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;


  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
    pkgs.firefox
    pkgs.vim
  ];

  age = {
    identityPaths = [ "/etc/ssh/ssh_host_agenix_key" ];
    secrets.secret1.file = ./secrets/secret1.age;
  };
  
  # config.age.secrets.secret1.path == "/run/agenix/secret1"
  users.users.root = {
    hashedPasswordFile = config.age.secrets.secret1.path;
    # initialPassword = "<example>";
  };

  users.users.ketan = {
    isNormalUser = true;
    hashedPasswordFile = config.age.secrets.secret1.path;
    extraGroups = [ "wheel" ];  # add ketan to sudoers file.
  };

  # wayland 
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # programs.sway.enable = true; (sway tiling window manager pure wayland)

  system.stateVersion = "24.05";

  # jellyfin 
  media_server.jellyfin.enable = true;
  media_server.qbittorrent.enable = true;

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };
}