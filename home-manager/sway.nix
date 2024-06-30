# https://github.com/KubqoA/dotfiles/blob/new/users/jakub/default.nix
{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    hyprlock
    waybar
  ];
  wayland.windowManager.sway = {
    wrapperFeatures = {
      gtk = true;
      base = true;
    };
    extraSessionCommands = ''
      export _JAVA_AWT_WM_NONREPARENTING=1
      export QT_QPA_PLATFORM=wayland
      export XDG_CURRENT_DESKTOP=sway
    '';
    enable = true;
    config = rec {
      modifier = "Mod4";
      window.titlebar = false;
      terminal = "wezterm";
      bars = [
        {
          command = "waybar";
          fonts = {size = 16.0;};
        }
      ];
      fonts = {
        size = 16.0;
      };
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in
        lib.mkOptionDefault {
          "${modifier}+l" = "exec hyprlock";
          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +10%";
          "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -10%";
          "XF86AudioMute" = "exec set-volume toggle-mute";
          "XF86AudioStop" = "exec ${pkgs.playerctl}/bin/playerctl stop";
          "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
          "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
          "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";

          "XF86MonBrightnessDown" = "exec brightnessctl set 15%-";
          "XF86MonBrightnessUp" = "exec brightnessctl set +15%";
        };
      input."*" = {
        xkb_layout = "eu";
        xkb_options = "terminate:ctrl_alt_bksp,ctrl:nocaps,ctrl:swapcaps";
      };
      defaultWorkspace = "workspace number 1";
      startup = [
        # Launch Firefox on start
        # {command = "firefox";}
      ];
    };
  };
}
