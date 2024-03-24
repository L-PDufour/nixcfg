{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    sway
  ];

wayland.windowManager.sway = {
  enable = true;
  config = rec {
    modifier = "Mod4"; # Super key
    terminal = "wezterm";
      };
  extraConfig = ''
    bindsym Print               exec shotman -c output
    bindsym Print+Shift         exec shotman -c region
    bindsym Print+Shift+Control exec shotman -c window
  '';
};
}

