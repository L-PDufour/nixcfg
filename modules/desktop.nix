{pkgs, ...}: {
  networking.networkmanager.enable = true;
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
  ];
  services.printing.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  # programs.sway.enable = true;
  # programs.sway.wrapperFeatures.gtk = true;
  security.polkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  #   environment.gnome.excludePackages =
  #     (with pkgs; [
  #       gnome-photos
  #       gnome-tour
  #       gnome-text-editor
  #     ])
  #     ++ (with pkgs.gnome; [
  #       cheese
  #       gnome-music
  #       gnome-terminal
  #       epiphany
  #       geary
  #       evince
  #       gnome-characters
  #       totem
  #       tali
  #       iagno
  #       hitori
  #       atomix
  #       gnome-calculator
  #       yelp
  #       gnome-maps
  #       gnome-weather
  #       gnome-contacts
  #       simple-scan
  #     ]);
  #   environment.systemPackages = with pkgs; [
  #     gnome.gnome-tweaks
  #     gnomeExtensions.pop-shell
  #   ];
}
