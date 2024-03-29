{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wezterm
  ];

  programs.wezterm.enableZshIntegration = true;
  xdg.configFile."wezterm/wezterm.lua".text = ''
       local wezterm = require("wezterm")

    -- This table will hold the configuration.
    local config = {}

    -- In newer versions of wezterm, use the config_builder which will
    -- help provide clearer error messages
    if wezterm.config_builder then
    	config = wezterm.config_builder()
    end

    -- This is where you actually apply your config choices
    config.default_prog = { '/run/current-system/sw/bin/zsh' }
    config.colors = {}
    config.colors.background = "#111111"
    config.font_size = 16.0
    config.color_scheme = "Tokyo Night"
    config.window_background_opacity = 0.95
    config.enable_tab_bar = false
    config.use_fancy_tab_bar = false
    config.enable_scroll_bar = true
    config.set_environment_variables = {
      TERMINFO_DIRS = "/home/laptop/.nix-profile/share/terminfo"
    }
    config.term = "wezterm"
    config.window_padding = {
    	left = 0,
    	right = 0,
    	top = 0,
    	bottom = 0,
    }
    return config  '';
}

