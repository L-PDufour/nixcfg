# https://github.com/KubqoA/dotfiles/blob/new/users/jakub/default.nix
{
  config,
  pkgs,
  inputs,
  ...
}: let
  light = "${pkgs.light}/bin/light";
  wofi = "${pkgs.wofi}/bin/wofi --insensitive";
  bemenu = "BEMENU_BACKEND=wayland ${pkgs.bemenu}/bin/bemenu-run -H 16 -p execute: -b --fn 'Terminus 9' --tf '#FFFFFF' --scf '#FFFFFF' --ff '#FFFFFF' --tb ''#FFFFFF --nf '#FFFFFF' --hf '#FFFFFF' --nb '#000000' --tb '#000000' --fb '#000000'";
  launcher = bemenu;
  pamixer = "${pkgs.pamixer}/bin/pamixer";
  swaylockcmd = "${pkgs.swaylock}/bin/swaylock -c '#000000'";
  idlecmd = pkgs.writeShellScript "swayidle.sh" ''
    ${pkgs.swayidle}/bin/swayidle \
    before-sleep "${swaylockcmd}" \
    lock "${swaylockcmd}" \
    timeout 500 "${swaylockcmd}" \
    timeout 1000 "${pkgs.systemd}/bin/systemctl suspend"
  '';
in {
  config = {
    programs.wlogout.enable = true;
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures = {
        gtk = true;
      };
      extraSessionCommands = ''
        export _JAVA_AWT_WM_NONREPARENTING=1
        export QT_QPA_PLATFORM=wayland
        export XDG_CURRENT_DESKTOP=sway
      '';
      xwayland = true;
      config = rec {
        terminal = "wezterm";
        bars = [
          {
            fonts = {
              size = 9.0;
            };

            position = "top";
            statusCommand = "i3status-rs $HOME/.config/i3status-rust/config-top.toml";
            extraConfig = "height 16";
          }
        ];

        focus.followMouse = "always";
        # gaps = {
        #   outer = 5;
        #   inner = 10;
        # };

        window = {
          titlebar = false;
          border = 1;
        };
        # colors.focused = {
        #   background = "#4c7899";
        #   border = "#4c7899";
        #   childBorder = "#4c7899";
        #   indicator = "#2e9ef4";
        #   text = "#ffffff";
        # };
        input."*" = {
          xkb_layout = "eu";
          xkb_options = "terminate:ctrl_alt_bksp,ctrl:nocaps,ctrl:swapcaps";
        };
        defaultWorkspace = "workspace number 1";
        startup = [
          {
            always = true;
            command = "${pkgs.systemd}/bin/systemd-notify --ready || true";
          }
          {
            always = true;
            command = "${pkgs.mako}/bin/mako --default-timeout 3000";
          }
          {
            always = true;
            command = "touch $SWAYSOCK.wob && tail -n0 -f $SWAYSOCK.wob | ${pkgs.wob}/bin/wob";
          }

          {
            command = "exec ${idlecmd}";
            always = true;
          }
        ];
        modifier = "Mod4";
        keybindings = {
          "ctrl+shift+c" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -d)\" - | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png";
          "${modifier}+Shift+S" = "grim -g '$(slurp)'";

          "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+x" = "exec ${swaylockcmd}";
          "${modifier}+c" = "kill";
          "${modifier}+Shift+r" = "reload";
          "${modifier}+t" = "layout toggle tabbed split";
          "${modifier}+Shift+q" = "exec ${pkgs.wlogout}/bin/wlogout";

          "${modifier}+b" = "splith";
          "${modifier}+v" = "splitv";
          "${modifier}+f" = "fullscreen toggle";
          "${modifier}+space" = "floating toggle";
          "${modifier}+w" = "sticky toggle";
          "${modifier}+a" = "focus parent";
          "${modifier}+g" = "exec chromium"; # test
          "${modifier}+d" = "exec ${launcher}";
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";

          "${modifier}+Shift+minus" = "move scratchpad";
          "${modifier}+minus" = "scratchpad show";

          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";

          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+0" = "workspace number 10";

          "${modifier}+Ctrl+Right" = "resize shrink width 3 px or 3 ppt";
          "${modifier}+Ctrl+Down" = "resize grow height 3 px or 3 ppt";
          "${modifier}+Ctrl+Up" = "resize shrink height 3 px or 3 ppt";
          "${modifier}+Ctrl+Left" = "resize grow width 3 px or 3 ppt";

          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";
          "${modifier}+Shift+0" = "move container to workspace number 10";

          #Audio and Light
          "XF86MonBrightnessUp" = "exec ${light} -A 5 && ${light} -G | cut -d'.' -f1 > $SWAYSOCK.wob";
          "XF86MonBrightnessDown" = "exec ${light} -U 5 && ${light} -G | cut -d'.' -f1 > $SWAYSOCK.wob";
          "XF86AudioRaiseVolume" = "exec ${pamixer} -ui 2 && ${pamixer} --get-volume > $SWAYSOCK.wob";
          "XF86AudioLowerVolume" = "exec ${pamixer} -ud 2 && ${pamixer} --get-volume > $SWAYSOCK.wob";
          "XF86AudioMute" = "exec ${pamixer} --toggle-mute && ( ${pamixer} --get-mute && echo 0 > $SWAYSOCK.wob ) || ${pamixer} --get-volume > $SWAYSOCK.wob";
          "XF86AudioStop" = "exec ${pkgs.playerctl}/bin/playerctl stop";
          "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
          "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
          "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        };
      };
    };
  };
}
# {
#   pkgs,
#   lib,
#   config,
#   ...
# }: {
#   home.packages = with pkgs; [
#     hyprlock
#     waybar
#   ];
#   wayland.windowManager.sway = {
#     wrapperFeatures = {
#       gtk = true;
#       base = true;
#     };
#     extraSessionCommands = ''
#       export _JAVA_AWT_WM_NONREPARENTING=1
#       export QT_QPA_PLATFORM=wayland
#       export XDG_CURRENT_DESKTOP=sway
#     '';
#     enable = true;
#     config = rec {
#       modifier = "Mod4";
#       window.titlebar = false;
#       terminal = "wezterm";
#       bars = [
#         {
#           command = "waybar";
#           fonts = {size = 16.0;};
#         }
#       ];
#       fonts = {
#         size = 16.0;
#       };
#       keybindings = let
#         modifier = config.wayland.windowManager.sway.config.modifier;
#       in
#         lib.mkOptionDefault {
#           "${modifier}+l" = "exec hyprlock";
#           "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +10%";
#           "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -10%";
#           "XF86AudioMute" = "exec set-volume toggle-mute";
#           "XF86AudioStop" = "exec ${pkgs.playerctl}/bin/playerctl stop";
#           "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
#           "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
#           "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
#
#           "XF86MonBrightnessDown" = "exec brightnessctl set 15%-";
#           "XF86MonBrightnessUp" = "exec brightnessctl set +15%";
#         };
#       startup = [
#         # Launch Firefox on start
#         # {command = "firefox";}
#       ];
#     };
#   };
# }

