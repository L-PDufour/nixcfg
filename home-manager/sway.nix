# https://github.com/KubqoA/dotfiles/blob/new/users/jakub/default.nix
{ pkgs, ... }:
let
  light = "${pkgs.light}/bin/light";
  wpctl = "${pkgs.wireplumber}/bin/wpctl";
  swaylockcmd = "${pkgs.swaylock}/bin/swaylock -c '#000000'";
  idlecmd = pkgs.writeShellScript "swayidle.sh" ''
    ${pkgs.swayidle}/bin/swayidle \
    before-sleep "${swaylockcmd}" \
    lock "${swaylockcmd}" \
    timeout 500 "${swaylockcmd}" \
    timeout 1000 "${pkgs.systemd}/bin/systemctl suspend"
  '';
in
{
  # Output daemon
  services.kanshi.enable = true;

  # Notification daemon
  services.mako.enable = true;
  services.wob.enable = true;
  services.wlsunset.enable = true;
  services.wlsunset.latitude = 46.9;
  services.wlsunset.longitude = -71.2;

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 26;
        modules-left = [
          "sway/workspaces"
          "sway/mode"
        ];
        modules-center = [ "sway/window" ];
        modules-right = [ "clock" ];
        "sway/window" = {
          "max-length" = 50;
        };
        clock = {
          "format-alt" = "{:%a, %d. %b  %H:%M}";
        };
      };
    };
  };
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
      bars = [ { } ];
      focus.followMouse = "always";
      window = {
        titlebar = false;
        border = 1;
      };
      input."*" = {
        xkb_layout = "eu";
        xkb_options = "terminate:ctrl_alt_bksp,ctrl:nocaps,ctrl:swapcaps";
      };
      defaultWorkspace = "workspace number 1";
      startup = [
        {
          command = "systemctl --user restart waybar.service";
          always = true;
        }
        {
          command = "pkill swaybar";
          always = true;
        }
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
      modifier = "Mod1";
      gaps = {
        inner = 5;
        outer = 5;
      };

      keybindings = {
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+x" = "exec ${swaylockcmd}";
        "${modifier}+Shift+c" = "kill";
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
        "${modifier}+d" = "exec rofi -show drun";
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+Tab" = "workspace back_and_forth";

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
        "XF86AudioRaiseVolume" = "exec ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%+ && ${wpctl} get-volume @DEFAULT_AUDIO_SINK@ | sed 's/^Volume: //;s/\.//;s/$//' > $SWAYSOCK.wob";
        "XF86AudioLowerVolume" = "exec ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%- && ${wpctl} get-volume @DEFAULT_AUDIO_SINK@ | sed 's/^Volume: //;s/\.//;s/$//' > $SWAYSOCK.wob";
        "XF86AudioMute" = "exec ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle && (${wpctl} get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo 0 > $SWAYSOCK.wob) || (${wpctl} get-volume @DEFAULT_AUDIO_SINK@ | sed 's/^Volume: //;s/\.//;s/$//' > $SWAYSOCK.wob)";
        "XF86MonBrightnessUp" = "exec ${light} -A 5 && ${light} -G | cut -d'.' -f1 > $SWAYSOCK.wob";
        "XF86MonBrightnessDown" = "exec ${light} -U 5 && ${light} -G | cut -d'.' -f1 > $SWAYSOCK.wob";
        "XF86AudioStop" = "exec ${pkgs.playerctl}/bin/playerctl stop";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
      };
    };
  };
}
