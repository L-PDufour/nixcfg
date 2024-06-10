{pkgs, ...}: {
  services.udev.enable = true;
  services.udev.packages = [pkgs.via pkgs.qmk-udev-rules];
  programs.zsh.enable = true;
  programs.zsh.autosuggestions.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [zsh];
  environment.pathsToLink = ["/share/zsh"];
}
