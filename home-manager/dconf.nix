{
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.lib);
in
  with lib.hm.gvariant; {
    dconf.settings = {
      "org/gnome/desktop/input-sources" = {
        show-all-sources = true;
        sources = [(mkTuple ["xkb" "eu"])];
        xkb-options = ["terminate:ctrl_alt_bksp" "ctrl:nocaps" "ctrl:swapcaps"];
      };
      "org/gnome/desktop/interface" = {
        color-scheme = lib.mkForce "prefer-dark";
      };
      "org/gnome/desktop/wm/preferences" = {
        num-workspaces = 10;
      };
      "org/gnome/desktop/wm/keybindings" = {
        close = ["<Ctrl><Super>q"];
        minimize = [];

        move-to-workspace-1 = ["<Ctrl><Super>1"];
        move-to-workspace-2 = ["<Ctrl><Super>2"];
        move-to-workspace-3 = ["<Ctrl><Super>3"];
        move-to-workspace-4 = ["<Ctrl><Super>4"];
        move-to-workspace-5 = ["<Ctrl><Super>5"];
        move-to-workspace-6 = ["<Ctrl><Super>6"];
        move-to-workspace-7 = ["<Ctrl><Super>7"];
        move-to-workspace-8 = ["<Ctrl><Super>8"];
        move-to-workspace-9 = ["<Ctrl><Super>9"];
        move-to-workspace-10 = ["<Ctrl><Super>0"];

        switch-to-workspace-1 = ["<Super>1"];
        switch-to-workspace-2 = ["<Super>2"];
        switch-to-workspace-3 = ["<Super>3"];
        switch-to-workspace-4 = ["<Super>4"];
        switch-to-workspace-5 = ["<Super>5"];
        switch-to-workspace-6 = ["<Super>6"];
        switch-to-workspace-7 = ["<Super>7"];
        switch-to-workspace-8 = ["<Super>8"];
        switch-to-workspace-9 = ["<Super>9"];
        switch-to-workspace-10 = ["<Super>0"];
      };
      "org/gnome/shell/keybindings" = {
        switch-to-application-1 = [];
        switch-to-application-2 = [];
        switch-to-application-3 = [];
        switch-to-application-4 = [];
        switch-to-application-5 = [];
        switch-to-application-6 = [];
        switch-to-application-7 = [];
        switch-to-application-8 = [];
        switch-to-application-9 = [];
        switch-to-application-10 = [];
      };
    };
  }
