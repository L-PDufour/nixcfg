{ pkgs, ... }:
{
  networking.networkmanager.enable = true;
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";
  fonts.packages = with pkgs; [
    fira-code-nerdfont
    dejavu_fonts
    noto-fonts-emoji
  ];
  services.printing.enable = true;
  security.polkit.enable = true;
  security.rtkit.enable = true;
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.pop-shell
  ];
}
