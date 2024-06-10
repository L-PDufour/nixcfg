{pkgs, ...}: {
  services.emacs = {
    enable = true;
    package = pkgs.emacs-gtk; # replace with emacs-gtk, or a version provided by the community overlay if desired.
  };
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk; # replace with pkgs.emacs-gtk, or a version provided by the community overlay if desired.
    extraPackages = epkgs: [epkgs.magit epkgs.evil epkgs.evil-collection epkgs.general epkgs.toc-org epkgs.org-bullets epkgs.which-key];
  };

  xdg.configFile."emacs" = {
    source = ./emacs;
    recursive = true;
  };
}
