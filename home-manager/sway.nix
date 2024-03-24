{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    dmenu
    sway
  ];

wayland.windowManager.sway = {
  enable = true;
  config = rec {
    modifier = "Mod4"; # Super key
    terminal = "wezterm";
    menu = "dmenu_run";
    # startup = [
    # { command = "systemctl --user restart waybar"; always = true;}
    # ];
    input ={
    "type:keyboard" = {
    xkb_layout = "eu";
    xkb_options = "ctrl:nocaps,ctrl:swapcaps";
    };
    };
    bars = [
      { 
        position = "top";
        command = "waybar";
      }
    ];  
    };
  extraConfig = ''
   bindsym Print               exec shotman -c output
    bindsym Print+Shift         exec shotman -c region
    bindsym Print+Shift+Control exec shotman -c window
  '';
};
}

