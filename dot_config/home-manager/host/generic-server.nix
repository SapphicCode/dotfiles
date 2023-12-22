{ pkgs, ... }: {
  home.username = "sapphiccode";
  home.homeDirectory = "/home/sapphiccode";
  home.stateVersion = "23.05";

  imports = [
    ../profile/comfortable.nix
  ];
}
