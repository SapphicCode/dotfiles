{ pkgs, ... }: {
  home.username = "deck";
  home.homeDirectory = "/home/deck";
  home.stateVersion = "23.05";

  imports = [
    ../profile/comfortable.nix
  ];
}
