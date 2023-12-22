{ pkgs, ... }: {
  home.username = "sapphiccode";
  home.homeDirectory = "/Users/sapphiccode";
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    coreutils
    gnugrep
  ];

  services.syncthing.enable = true;

  imports = [
    ../profile/everything.nix
  ];
}
