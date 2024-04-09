{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    stylua
    isort
    black
    nodePackages_latest.prettier
    prettierd
    alejandra
    gnumake
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
