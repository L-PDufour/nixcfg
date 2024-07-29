{
  programs.wezterm.enable = true;
  programs.wezterm.extraConfig = ''
    if wezterm.config_builder then
    config = wezterm.config_builder()
    end

    config.font = wezterm.font("FiraCode Nerd Font Mono", {weight="DemiBold"})
    config.hide_tab_bar_if_only_one_tab = true
    config.leader = { key = 'LeftAlt', mods = 'NONE', timeout_milliseconds = 1000 }

    config.keys = {
    { key = 's', mods = "LEADER", action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES|DOMAINS' } },
    }
    config.ssh_domains = wezterm.default_ssh_domains()
    for _, dom in ipairs(config.ssh_domains) do
    dom.assume_shell = 'Posix'
    end

    return config
  '';
  programs.wezterm.enableZshIntegration = true;
  programs.wezterm.enableBashIntegration = true;
}
