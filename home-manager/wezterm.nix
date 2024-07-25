{ pkgs, ... }:
{
  programs.wezterm.enable = true;
  programs.wezterm.extraConfig = ''
    return {
      font = wezterm.font("FiraCode Nerd Font Mono", {weight="DemiBold"})
    }
  '';
  programs.wezterm.enableZshIntegration = true;
}
