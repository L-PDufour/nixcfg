{ pkgs, ... }:
{
  # GNOME-related configuration
  services.xserver.enable = true;
  services.xserver.xkb.layout = "eu";
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-text-editor
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-music
    gnome-terminal
    epiphany
    geary
    evince
    gnome-characters
    totem
    tali
    iagno
    hitori
    atomix
    gnome-calculator
    yelp
    gnome-maps
    gnome-weather
    gnome-contacts
    simple-scan
  ]);
  environment.systemPackages = with pkgs; [
    gnomeExtensions.pop-shell
  ];
}


