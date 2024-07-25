# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  pkgs,
  lib,
  config,
  ...
}: let
  system = pkgs.system;
  mkHomeManager = inputs.user-nvim.lib.mkHomeManager;
  in
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    # You can also split up your configuration and import pieces of it here:
    ./../../home-manager/gui.nix
    ./../../home-manager/tui.nix
    ./../../home-manager/nixvim
    # ./../../home-manager/sway.nix
    # ./../../home-manager/neovim
    ./../../home-manager/emacs.nix
    # ./../../home-manager/neovim.nix
    # ./../../nvim/default.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./changehello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };
  # TODO: Set your username
  home = {
    username = "desktop";
    homeDirectory = "/home/desktop";
  };
  programs.gpg.enable = true;

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  # programs.qutebrowser.enable = true;

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.neovim = mkHomeManager {inherit system;};

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";

  #---------------------------------------------------------------------
  # home
  #---------------------------------------------------------------------

  #---------------------------------------------------------------------
  # programs
  #---------------------------------------------------------------------

  programs.autorandr = {
    enable = true;
  };

  # programs.i3status = {
  #   enable = true;
  #
  #   modules = {
  #     ipv6.enable = false;
  #     "wireless _first_".enable = false;
  #     "battery all".enable = false;
  #   };
  # };
  #

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      pulseSupport = true;
      githubSupport = true;
      i3Support = true;
    };
    script = "polybar &";
    #     General colors
    # Default background: base00
    # Alternate background: base01
    # Selection background: base02
    # Default text: base05
    # Alternate text: base04
    # Warning: base0A
    # Error: base08
    # Urgent: base09
    config = {
      "global/wm" = {
        margin-top = 0;
        margin-bottm = 0;
      };
      #====================BARS====================#
      "bar/main" = {
        width = "100%";
        height = "28pt";
        bottom = false;
        # padding = 50;

        fixed-center = true;
        foreground = config.lib.stylix.colors.base05;
        # background = config.lib.stylix.colors.base00;
        font-0 = "FiraCode Nerd Font Mono:style=SemiBold:size=16;3";
        font-1 = "Noto Color Emoji:scale=10;2";
        separator = " ";
        background = "#00000000";
        module-margin = 0;
        modules-left = "i3 title";
        # modules-center = "title";
        modules-right = "network memory cpu pulseaudio date tray";
      };
      "module/i3" = {
        type = "internal/i3";
        # pin-workspaces = true;
        show-urgent = true;
        # strip-wsnumbers = true;
        # index-sort = true;
        fuzzy-match = true;
        label-focused-background = config.lib.stylix.colors.base0D; # Blue for focused
        label-focused-foreground = config.lib.stylix.colors.base00; # Blue for focused
        label-unfocused-foreground = config.lib.stylix.colors.base05; # Dimmer text for unfocused
        label-visible-foreground = config.lib.stylix.colors.base00; # Normal text for visible
        label-urgent-background = config.lib.stylix.colors.base08;
        # label-focused-underline = config.lib.stylix.colors.base0D;
        label-focused-padding = 1;
        label-unfocused-padding = 1;
        label-visible-padding = 1;
        label-urgent-padding = 1;
        label-focused = "%name%";
        label-unfocused = "%name%";
        label-visible = "%name%";
        label-urgent = "%name%";
        # label-focused-min-width = 20;
        # label-unfocused-min-width = 20;
        # label-visible-min-width = 20;
        # label-urgent-min-width = 20;
        # label-focused = "%index%";
        # label-focused-alignment = "center";
        # label-unfocused = "%index%";
        # label-unfocused-alignment = "center";
        # label-visible = "%index%";
        # label-visible-alignment = "center";
        # label-urgent = "%index%";
        # label-urgent-alignment = "center";
      };
      "module/title" = {
        type = "internal/xwindow";
        # format-foreground = config.lib.stylix.colors.base01;
        # format-background = config.lib.stylix.colors.base02;
        format-padding = 2;
      };
      "module/temperature" = {
        type = "internal/temperature";
        format-foreground = config.lib.stylix.colors.base00;
        format-background = config.lib.stylix.colors.base0F;
        format-padding = 1;
      };
      "module/network" = {
        type = "internal/network";
        interface-type = "wired";
        interval = 3;
        format-connected = "<label-connected>";
        format-disconnected = "<label-disconnected>";
        label-connected = "%downspeed:8% 󰇚 %upspeed:8% 󰕒";
        label-disconnected = "󰖪 disconnected";
        format-connected-foreground = config.lib.stylix.colors.base00;
        format-connected-background = config.lib.stylix.colors.base0B;
        format-disconnected-foreground = config.lib.stylix.colors.base00;
        format-disconnected-background = config.lib.stylix.colors.base08;
        format-connected-padding = 1;
        format-disconnected-padding = 1;
        # speed-unit = "MB/s";
      };
      "module/memory" = {
        type = "internal/memory";
        interval = 5;
        format-foreground = config.lib.stylix.colors.base00;
        format-background = config.lib.stylix.colors.base0C;
        format-padding = 1;
        format-prefix = "RAM ";
        label = "%percentage_used:2%";
      };
      "module/cpu" = {
        type = "internal/cpu";
        interval = 5;
        format-foreground = config.lib.stylix.colors.base00;
        format-background = config.lib.stylix.colors.base0D;
        format-padding = 1;
        format-prefix = "CPU ";
        label = "%percentage:2%";
      };
      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        use-ui-max = "false";
        format-volume-foreground = config.lib.stylix.colors.base01;
        format-volume-background = config.lib.stylix.colors.base0E;
        format-volume-padding = 1;
        format-volume-prefix = "VOL ";
        format-volume = "<label-volume>";
        format-muted = "<label-muted>";
        label-volume = "%percentage:2%";
        label-muted = "VOL muted";
        label-muted-foreground = config.lib.stylix.colors.base01;
        label-muted-background = config.lib.stylix.colors.base0E;
      };
      "module/date" = {
        type = "internal/date";
        interval = 60;
        date = "%d-%m%";
        time = "%H:%M";
        label = "%time% %date%";
        format-foreground = config.lib.stylix.colors.base00;
        format-background = config.lib.stylix.colors.base0A;
        format-padding = 1;
      };
      "module/tray" = {
        type = "internal/tray";
        format-padding = 1;
      };
    };
  };
  programs.rofi = {
    enable = true;
    extraConfig = {
      disable-history = false;
      display-Network = " 󰤨  Network";
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 﩯  Window";
      drun-display-format = "{icon} {name}";
      hide-scrollbar = true;
      icon-theme = "Oranchelo";
      location = 0;
      modi = "run,drun,window";
      show-icons = true;
      sidebar-mode = true;
      terminal = "kitty";
    };
  };

  #---------------------------------------------------------------------
  # services
  #---------------------------------------------------------------------

  services.autorandr.enable = true;
  services.dunst = {
    enable = true;
    settings = {
      global = {
        sticky_history = "yes";
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action close_current";
        mouse_right_click = "close_all";
        timeout = 0;
      };
    };
  };
  #---------------------------------------------------------------------
  # xsession
  #---------------------------------------------------------------------

  xsession.windowManager.i3 = {
    enable = true;

    config = rec {
      modifier = "Mod1";
      menu = "rofi -show drun";
      terminal = "wezterm";
      gaps = {
        inner = 5;
        outer = 5;
      };

      keybindings = lib.mkOptionDefault {
        "XF86AudioMute" = "exec amixer set Master toggle";
        "XF86AudioLowerVolume" = "exec amixer set Master 5%-";
        "XF86AudioRaiseVolume" = "exec amixer set Master 5%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
        "${modifier}+Tab" = "workspace back_and_forth";

        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";

        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";
      };

      defaultWorkspace = "workspace number 1";
      startup = [
        {
          command = "systemctl --user restart polybar.service";
          always = true;
          notification = false;
        }
        {
          command = "pkill i3bar";
          always = true;
          notification = false;
        }
      ];
    };

    extraConfig = ''
      default_border pixel 3
      smart_borders on
      smart_gaps on
    '';
  };
}
