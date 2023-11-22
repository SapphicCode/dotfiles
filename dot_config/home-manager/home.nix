{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sapphiccode";
  home.homeDirectory = "/Users/sapphiccode";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    coreutils # macOS
    gnugrep

    git
    chezmoi

    fish
    nushell
    starship

    neovim
    efm-langserver

    fd
    age
    zstd
    jq
    yq-go

    btop
    ncdu

    charm
    ffmpeg
    glow
    skate
    exiftool
    nb
    lima
    libjxl

    nixpkgs-fmt

    python311Full
    # python311Packages.pip
    python311Packages.black
    python311Packages.isort
    pipx
    ruff

    elixir

    stylua
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
