# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  outputs,
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.nixvim.nixosModules.nixvim
    ./../../modules/desktop.nix
    ./../../modules/packages.nix
    ./../../modules/shell.nix
    inputs.home-manager.nixosModules.home-manager
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
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  programs.gamemode.enable = true;
  environment.systemPackages = with pkgs; [
    libusb1
    protonup
    xorg.libXext
    inputs.dmenu.packages."x86_64-linux".default
    inputs.st.packages."x86_64-linux".default
    # inputs.dwmblocks.packages."x86_64-linux".default
  ];
  services = {
    xserver = {
      enable = true;
      xkb.layout = "eu";
      xkb.options = "terminate:ctrl_alt_bksp,ctrl:nocaps,ctrl:swapcaps";
      windowManager.i3.enable = true;
    };
  };
  services.displayManager.defaultSession = "sway";
  services.displayManager.sddm.enable = true;
  services.libinput.enable = true;
  programs.dconf.enable = true;

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  stylix.enable = true;
  stylix.autoEnable = true;
  # stylix.targets.nixvim.enable = false;
  stylix.homeManagerIntegration.autoImport = true;
  stylix.homeManagerIntegration.followSystem = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  stylix.image = ./Rainnight.jpg;
  stylix.polarity = "dark";
  stylix.fonts = {
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };

    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };

    monospace = {
      package = pkgs.fira-code-nerdfont;
      name = "FiraCode Nerd Font Mono";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };
  stylix.fonts.sizes = {
    applications = 16;
    terminal = 12;
    desktop = 16;
    popups = 16;
  };

  stylix.cursor.package = pkgs.catppuccin-cursors;
  stylix.cursor.name = "mochaMauve";

  boot.initrd.luks.devices."luks-8c8aff92-306c-42fe-8b4a-74f97f7b5edb".device = "/dev/disk/by-uuid/8c8aff92-306c-42fe-8b4a-74f97f7b5edb";
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0d28", MODE="0664", GROUP="plugdev"
  '';
  users.users.desktop = {
    isNormalUser = true;
    description = "desktop";
    extraGroups = ["networkmanager" "wheel" "docker"];
  };
  services.postgresql = {
    enable = true;
    ensureDatabases = ["mydatabase"];
    authentication = pkgs.lib.mkOverride 10 ''
            #type database  DBuser  auth-method
            local all       all     trust
      host    blogator    postgres    ::1/128    trust

    '';
  };
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  #DOCKER
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    backupFileExtension = "backup"; # Add this line to handle existing files
    users = {
      # Import your home-manager configuration
      "desktop" = import ./home.nix;
    };
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
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
