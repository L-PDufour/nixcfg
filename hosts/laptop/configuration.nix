# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  imports =
    [ # Include the results of the hardware scan.
      inputs.nixvim.nixosModules.nixvim
      # ./../../home-manager/greetd.nix
      ./hardware-configuration.nix
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
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
gnome-photos
gnome-tour
gnome-text-editor
  ]) ++ (with pkgs.gnome; [
cheese # webcam tool
gnome-music
gnome-terminal
epiphany # web browser
geary # email reader
evince # document viewer
gnome-characters
totem # video player
tali # poker game
iagno # go game
hitori # sudoku game
atomix # puzzle game
gnome-calculator
yelp # help viewer
gnome-maps
gnome-weather
gnome-contacts
simple-scan
]);
  boot.initrd.luks.devices."luks-6401cefc-fbcc-45f1-bab1-89f14a105ba1".device = "/dev/disk/by-uuid/6401cefc-fbcc-45f1-bab1-89f14a105ba1";
  # services.blueman.enable = true;
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # programs.sway.enable = true;
  # programs.sway.wrapperFeatures.gtk = true;
  # programs.sway.package = null;
#    xdg.portal = {
#     enable = true;
#     wlr.enable = true;
#     # gtk portal needed to make gtk apps happy
#     extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
#   };  
# security.polkit.enable = true;
# hardware.opengl.enable = true; 
fonts.packages = with pkgs; [
  fira-code
  fira-code-symbols
];
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.laptop = {
    isNormalUser = true;
    description = "laptop";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

# programs.waybar.enable = true;

environment.pathsToLink = [ "/share/zsh" ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    lazygit
    gnomeExtensions.pop-shell
    ripgrep
    fd
    git
    wget
    curl  
    unzip
    starship
    pavucontrol
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
  # services.openssh.enable = true;

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
