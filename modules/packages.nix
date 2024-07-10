{pkgs, ...}: {
  programs.nix-ld.enable = true;
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
    vscode
    vscode.fhs
    go
    postgresql
    via
    qmk
    zed-editor
    nodePackages.typescript-language-server
    rofi-screenshot
    xclip
    xsel
    flameshot
  ];
}
