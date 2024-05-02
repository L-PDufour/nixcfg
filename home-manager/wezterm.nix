{pkgs, ...}: {
  home.packages = with pkgs; [
    wezterm
  ];

  programs.wezterm.enableZshIntegration = true;
  xdg.configFile."wezterm/wezterm.lua".text = ''
        local wezterm = require 'wezterm'


        local xcursor_size = nil
        local xcursor_theme = nil

        local success, stdout, stderr = wezterm.run_child_process({"gsettings", "get", "org.gnome.desktop.interface", "cursor-theme"})
        if success then
        xcursor_theme = stdout:gsub("'(.+)'\n", "%1")
        end

        local success, stdout, stderr = wezterm.run_child_process({"gsettings", "get", "org.gnome.desktop.interface", "cursor-size"})
        if success then
        xcursor_size = tonumber(stdout)
        end

        -- Define your WezTerm configuration
        -- In newer versions of wezterm, use the config_builder which will
        -- help provide clearer error messages
        if wezterm.config_builder then
          config = wezterm.config_builder()
        end

        -- This is where you actually apply your config choices
        config.default_prog = { '/run/current-system/sw/bin/zsh' }
        config.colors = {}
        config.colors.background = "#111111"
        config.font = wezterm.font 'Fira Code'
        config.font_size = 16.0
        config.color_scheme = "Tokyo Night"
        config.window_background_opacity = 0.95
        config.enable_tab_bar = false
        config.enable_wayland = true
        config.use_fancy_tab_bar = false
        config.enable_scroll_bar = true
        config.term = "wezterm"
        config.window_padding = {
          left = 0,
          right = 0,
          top = 0,
          bottom = 0,
        }
        config.ssh_domains = {
      {
        name = 'homeserver',
        remote_address = '192.168.50.173',
        username = 'server',
      },
    }

    -- Merge the cursor configuration into the main configuration
    config.xcursor_theme = xcursor_theme
    config.xcursor_size = xcursor_size
    config.ssh_domains = wezterm.default_ssh_domains()
    for _, dom in ipairs(config.ssh_domains) do
      dom.assume_shell = 'Posix'
    end
    -- Return the merged configuration
    return config
  '';
}
