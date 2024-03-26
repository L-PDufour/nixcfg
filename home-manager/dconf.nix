{ pkgs, ...}:
{
  dconf.settings = {
  "org/gnome/desktop/wm/keybindings" = {
  switch-to-workspace-1 = ['<Super>1']  
  };
  };
}
