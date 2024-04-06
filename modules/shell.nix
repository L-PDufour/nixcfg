{pkgs, ...}:
{
  programs.zsh.enable = true;
  programs.zsh.autosuggestions.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  environment.pathsToLink = [ "/share/zsh" ];
}
