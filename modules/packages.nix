{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lazygit
    ripgrep
    fd
    git
    wget
    curl
    syncthing
    keepassxc
    unzip
    starship
  ];
}
