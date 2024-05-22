# https://github.com/KubqoA/dotfiles/blob/new/users/jakub/default.nix
{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    hyprlock
  ];
  wayland.windowManager.sway = {
    # wrapperFeatures.gtk = true;
    enable = true;
    config = rec {
      modifier = "Mod4";
      window.titlebar = false;
      terminal = "wezterm";
      fonts = {
        size = 12.0;
      };
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in
        lib.mkOptionDefault {
          "${modifier}+l" = "exec hyprlock";
        };
      input."*" = {
        xkb_layout = "eu";
        xkb_options = "terminate:ctrl_alt_bksp,ctrl:nocaps,ctrl:swapcaps";
      };
      startup = [
        # Launch Firefox on start
        {command = "firefox";}
      ];
    };
  };
}
