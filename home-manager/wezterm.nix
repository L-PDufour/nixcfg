{pkgs, ...}: {
  home.packages = with pkgs; [
    wezterm
  ];

  programs.wezterm.enableZshIntegration = true;
  xdg.configFile."wezterm/wezterm.lua".text = ''
    local wezterm = require 'wezterm'
    local session = require("session")
    local xcursor_size = nil
    local xcursor_theme = nil
    local mux = wezterm.mux

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
    config.hide_tab_bar_if_only_one_tab = true
    config.enable_wayland = true
    config.enable_scroll_bar = true
    config.term = "wezterm"
    config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
    }
    config.leader = { key = 'LeftAlt', mods = 'NONE', timeout_milliseconds = 1000 }

    config.keys = {
    { key = "a", mods = "LEADER", action = wezterm.action_callback(session.toggle) },
    { key = 's', mods = "LEADER", action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES|DOMAINS' } },
    { key = 'n', mods = "ALT", action = wezterm.action.SwitchWorkspaceRelative(1) },
    { key = 'p', mods = "ALT", action = wezterm.action.SwitchWorkspaceRelative(-1) },
    { key = 'N', mods = "LEADER", action = wezterm.action.SwitchToWorkspace },
    { key = 'g', mods = "LEADER", action = wezterm.action.SpawnCommandInNewTab { args = {"lazygit"}}},
    { key = "-",mods   = "LEADER", action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }},
    { key = "=", mods = "LEADER", action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }},
    { key = "m", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
    { key = "Space", mods = "LEADER", action = wezterm.action.RotatePanes "Clockwise" },
    { key = "0", mods = "LEADER", action = wezterm.action.PaneSelect { mode = 'SwapWithActive'}},
    { key = 'h', mods = "SHIFT|ALT", action = wezterm.action.AdjustPaneSize { 'Left', 3 } },
    { key = 'l', mods = "SHIFT|ALT", action = wezterm.action.AdjustPaneSize { 'Right', 3 } },
    { key = 'j', mods = "SHIFT|ALT", action = wezterm.action.AdjustPaneSize { 'Down', 3 } },
    { key = 'k', mods = "SHIFT|ALT", action = wezterm.action.AdjustPaneSize { 'Up', 3 } },

    -- move betweztermeen neovim and wezterm panes
    { key = 'h', mods = "ALT", action = wezterm.action.ActivatePaneDirection 'Left' },
    { key = 'l', mods = "ALT", action = wezterm.action.ActivatePaneDirection 'Right' },
    { key = 'j', mods = "ALT", action = wezterm.action.ActivatePaneDirection 'Down' },
    { key = 'k', mods = "ALT", action = wezterm.action.ActivatePaneDirection   'Up'  },
    }
    config.xcursor_theme = xcursor_theme
    config.xcursor_size = xcursor_size
    config.ssh_domains = wezterm.default_ssh_domains()
    for _, dom in ipairs(config.ssh_domains) do
    dom.assume_shell = 'Posix'
    end

    return config
  '';
  xdg.configFile."wezterm/session.lua".text = ''
    local wezterm = require("wezterm")
    local act = wezterm.action

    local M = {}

    local fd = "/run/current-system/sw/bin/fd"
    local rootPath = "/home/"

    M.toggle = function(window, pane)
    local projects = {}

    local success, stdout, stderr = wezterm.run_child_process({
    fd,
    "-HI",
    "-td",
    "^.git$",
    "--max-depth=4",
    rootPath,
    -- add more paths here
    })

    if not success then
    wezterm.log_error("Failed to run fd: " .. stderr)
    return
    end

    for line in stdout:gmatch("([^\n]*)\n?") do
    local project = line:gsub("/.git/$", "")
    local label = project
    local id = project:gsub(".*/", "")
    table.insert(projects, { label = tostring(label), id = tostring(id) })
    end

    window:perform_action(
    act.InputSelector({
    action = wezterm.action_callback(function(win, _, id, label)
    if not id and not label then
    wezterm.log_info("Cancelled")
    else
    wezterm.log_info("Selected " .. label)
    win:perform_action(
    act.SwitchToWorkspace({ name = id, spawn = { cwd = label } }),
    pane
    )
    end
    end),
    fuzzy = true,
    title = "Select project",
    choices = projects,
    }),
    pane
    )
    end

    return M
  '';
}
