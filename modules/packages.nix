{ pkgs, ... }:
{
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    alejandra
    gnumake
    ripgrep
    fd
    git
    wget
    curl
    syncthing
    keepassxc
    unzip
    vscode
    vscode.fhs
    go
    postgresql
    via
    qmk
    rofi-screenshot
    xclip
    #Wayland
    swaylock
    light
    swayidle
    wl-clipboard
  ];
}
