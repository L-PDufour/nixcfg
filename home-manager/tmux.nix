{ pkgs, config, ... }:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;
    terminal = "xterm-256color";
    newSession = true;
    customPaneNavigationAndResize = true;
    prefix = "C-Space";
    sensibleOnTop = true;
    plugins = with pkgs; [
      tmuxPlugins.sensible
      # must be before continuum edits right status bar
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10'
        '';
      }
      tmuxPlugins.tmux-fzf
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.yank
    ];
    extraConfig = ''
      set -g set-clipboard on      # use system clipboard
      set-option -ga terminal-overrides ",xterm-256color:Tc"
      # set -sg terminal-overrides ",*:RGB"
      set -g allow-passthrough on
      bind r source ~/.zshrc && source-file ~/.config/tmux.conf \; display-message "Config reloaded..."
      bind-key x kill-pane # skip "kill-pane 1? (y/n)" prompt
      set -g detach-on-destroy off  # don't exit from tmux when closing a session
      bind-key "f" display-popup -E -w 40% "${pkgs.sesh}/bin/sesh connect \"$(
        ${pkgs.sesh}/bin/sesh list -i | ${pkgs.gum}/bin/gum filter --limit 1 --placeholder 'Pick a sesh' --prompt='⚡'
      )\""
    '';
  };
}
# extraConfig = ''
#   set-option -g focus-events on # TODO: learn how this works
#   unbind r
#   bind r source-file ~/.tmux.conf
#   set-option -g default-terminal "screen-256color"
#   set-option -a terminal-features 'xterm-256color:RGB'
#
#   # options
#   unbind C-b
#   set -g prefix C-Space
#   bind C-Space send-prefix
#
#   set-option -g update-environment "DISPLAY SSH_ASKPASS SSH_AUTH_SOCK SSH_AGENT_PID SSH_CONNECTION WINDOWID XAUTHORITY"
#   set -g base-index 1          # start indexing windows at 1 instead of 0
#   set -g pane-base-index 1
#   set -g escape-time 0         # zero-out escape time delay
#   set -g history-limit 1000000 # increase history size (from 2,000)
#   set -g mouse on              # enable mouse support
#   set -g renumber-windows on   # renumber all windows when any window is closed
#   set -g set-clipboard on      # use system clipboard
#   set -as terminal-features ',rxvt-unicode-256color:clipboard'
#   set -g status-interval 3     # update the status bar every 3 seconds
#
#
#   # set -g window-status-current-format '*#[fg=magenta]#W'
#   # set -g window-status-format ' #[fg=gray]#W'
#   #
#   # set -g message-command-style bg=default,fg=yellow
#   # set -g message-style bg=default,fg=yellow
#   # set -g mode-style bg=default,fg=yellow
#   # set -g pane-active-border-style 'fg=magenta,bg=default'
#   # set -g pane-border-style 'fg=brightblack,bg=default'
#
#   bind '%' split-window -c '#{pane_current_path}' -h
#   bind '"' split-window -c '#{pane_current_path}'
#   bind c new-window -c '#{pane_current_path}'
#
#   bind h select-pane -L
#   bind j select-pane -D
#   bind k select-pane -U
#   bind l select-pane -R
#   # Tmux bar
#
#   bind Space last-window
#
#
#   setw -g mode-keys vi
#
#   # set -g status-left "#[fg=blue,bold,bg=#1e1e2e]  #S   "
#   # set -g status-right "#[fg=#b4befe,bold,bg=#1e1e2e]%a %Y-%m-%d 󱑒 %l:%M %p"
#   # set -ga status-right "#($HOME/.config/tmux/scripts/cal.sh)"
#   set -g status-justify left
#   set -g status-left-length 200    # increase length (from 10)
#   set -g status-right-length 200    # increase length (from 10)
#   # set -g status-position top       # macOS / darwin style
#   # set -g status-style 'bg=#1e1e2e' # transparent
#   # set -g window-status-current-format '#[fg=magenta,bg=#1e1e2e] *#I #W'
#   # set -g window-status-format '#[fg=gray,bg=#1e1e2e] #I #W'
#   # set -g window-status-last-style 'fg=white,bg=black'
#   # set -g message-command-style bg=default,fg=yellow
#   # set -g message-style bg=default,fg=yellow
#   # set -g mode-style bg=default,fg=yellow
#   # set -g pane-active-border-style 'fg=magenta,bg=default'
#   # set -g pane-border-style 'fg=brightblack,bg=default'
#
# '';
