{ pkgs, ... }: {
  home.packages = with pkgs; [
    # bare minimum
    git
    delta # pager for git
    chezmoi

    # shell
    fish
    starship
    direnv

    # TUIs
    tmux
    htop
    ncdu
    neovim

    # tools
    fd
    age
    zstd
    jq
    yq-go
    rclone

    # dev tools
    nixpkgs-fmt
  ];
  programs.home-manager.enable = true;
}
