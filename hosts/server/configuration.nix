# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  outputs,
  lib,
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.nixvim.nixosModules.nixvim
    # ./../../modules/desktop.nix
    ./../../modules/packages.nix
    ./../../modules/shell.nix
  ];

  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  boot.initrd.luks.devices."luks-bf8c52ac-5d36-45b3-b5fb-f6a6211efbdd".device = "/dev/disk/by-uuid/bf8c52ac-5d36-45b3-b5fb-f6a6211efbdd";
  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  boot.loader.grub.enableCryptodisk = true;

  boot.initrd.luks.devices."luks-548eacfe-ef8c-440c-8823-f905920a116a".keyFile = "/crypto_keyfile.bin";
  boot.initrd.luks.devices."luks-bf8c52ac-5d36-45b3-b5fb-f6a6211efbdd".keyFile = "/crypto_keyfile.bin";

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  #Laptop settings
  services.logind.lidSwitchExternalPower = "ignore";

  #Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Configure keymap in X11
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
  ];

  services.xserver = {
    xkb.layout = "eu";
    xkb.options = "ctrl:swapcaps";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.server = {
    isNormalUser = true;
    description = "server";
    extraGroups = ["networkmanager" "wheel" "docker"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    tailwindcss
    cloudflared
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;

  #cloudflared
  services.cloudflared = {
    enable = true;
    user = "server";
    tunnels = {
      "8e5b30fa-03cd-4255-9fec-577230d25ac6" = {
        #     originRequest.noTLSVerify = true;
        credentialsFile = "/home/server/.cloudflared/8e5b30fa-03cd-4255-9fec-577230d25ac6.json";
        default = "http_status:404";
        #     ingress = {
        #       "dev.lpdufour.xyz" = "http://localhost:8001";
        #       "probono.lpdufour.xyz" = "https://192.168.50.173:8443";
        #     };
      };
    };
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    backupFileExtension = "backup"; # Add this line to handle existing files
    users = {
      # Import your home-manager configuration
      "server" = import ./home.nix;
    };
  };
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [8080 8443 5555 5432 7331 8001];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
