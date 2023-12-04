{ pkgs, ... }: {
  imports = [
    ./comfortable.nix
  ];

  home.packages = with pkgs; [
    # all remaining (occasional use) tools
    lima
    charm
    glow
    skate
    ffmpeg
    exiftool
    libjxl
    nb
    czkawka

    # Python
    python311Full
    python311Packages.black
    python311Packages.isort
    pipx
    ruff

    # Elixir
    elixir

    # Lua
    stylua

    # JS
    bun
  ];
}
