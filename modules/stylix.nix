{ pkgs, ... }:
{
  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.homeManagerIntegration.autoImport = true;
  stylix.homeManagerIntegration.followSystem = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
  stylix.image = ../cozy.jpg;
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
      package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
      name = "FiraCode Nerd Font";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };
  stylix.fonts.sizes = {
    #   applications = 16;
    terminal = 16;
    #   desktop = 16;
    popups = 15;
  };
  stylix.opacity = {
    # applications = 0.8;
    terminal = 0.9;
    # desktop = 0.8;
    popups = 0.5;
  };
}
