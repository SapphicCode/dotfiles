{ pkgs, ... }: {
  imports = [
    ./comfortable.nix
  ];

  home.packages = with pkgs; [
    # more shells!
    xonsh

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
    ruff
    poetry
    pdm
    python311Packages.ipython
    pipx # in case of fire break glass

    # Elixir
    elixir

    # Lua
    stylua

    # JS
    bun
  ];
}
