{ pkgs, ... }: {
  home.packages = with pkgs; [
    # bare minimum
    git
    chezmoi

    # shell
    fish
    starship

    # TUIs
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
