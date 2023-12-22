{
  description = "Home Manager configuration of sapphiccode";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    {
      homeConfigurations."sapphiccode@Maeve" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
        modules = [ ./host/Maeve.nix ];
      };
      homeConfigurations."deck@hollydeck" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [ ./host/hollydeck.nix ];
      };
      homeConfigurations."generic-server-arm64" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."aarch64-linux";
        modules = [ ./host/generic-server.nix ];
      };
      homeConfigurations."generic-server-amd64" = home-manager.lib.homeMangerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [ ./host/generic-server.nix ];
      };
    };
}
