{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    dmenu
    waybar
    sway
    playerctl
  ];

wayland.windowManager.sway = {
  enable = true;
  config = rec {
    modifier = "Mod4"; # Super key
    terminal = "wezterm";
    menu = "dmenu_run";
    startup = [
    {command = "systemctl --user start mako.service";} # Start notification daemon
    {command = "blueman-applet";} # Start bluetooth applet for system tray
    ];
    defaultWorkspace = "workspace 1";
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
    bindsym XF86MonBrightnessDown exec light -U 5
bindsym XF86MonBrightnessUp exec light -A 5

# Volume
bindsym XF86AudioRaiseVolume exec amixer set Master 5%+ 
bindsym XF86AudioLowerVolume exec amixer set Master 5%-
bindsym XF86AudioMute exec set Master toggle 
  '';
};
}

