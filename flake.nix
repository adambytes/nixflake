{
  description = "A NixOS Implementation by Adam";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, vscode-server, home-manager }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;

      config = {
        allowUnfree = true;
      };
    };
  in
  
  {
    nixosConfigurations = {
      myNixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };
        modules = [
	        ./nixos/configuration.nix

          # To enable vs-server
          vscode-server.nixosModules.default (
            { config, pkgs, ... } : { 
              services.vscode-server.enable = true; 
            })

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.adam = import ./home/default.nix;
          }
        ];
      };
    };
  };
}
