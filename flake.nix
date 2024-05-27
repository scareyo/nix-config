{
  description = "A scarey flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";

    nix-virt.url = "https://flakehub.com/f/AshleyYakeley/NixVirt/*.tar.gz";
    nix-virt.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;

    systems = [
      "x86_64-linux"
      "aarch64-darwin"
    ];

    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosConfigurations = {
      teseuka = nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/teseuka ];
        specialArgs = { inherit inputs outputs; };
      };
    };

    darwinConfigurations = {
      vegapunk = nix-darwin.lib.darwinSystem {
        modules = [ ./hosts/vegapunk ];
        specialArgs = { inherit inputs outputs; };
      };
    };

    homeConfigurations = {
      "scarey@teseuka" = home-manager.lib.homeManagerConfiguration {
        modules = [ ./hosts/teseuka/home.nix ];
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs outputs; };
      };
      "scarey@vegapunk" = home-manager.lib.homeManagerConfiguration {
        modules = [ ./hosts/vegapunk/home.nix ];
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        extraSpecialArgs = { inherit inputs outputs; };
      };
    };
  };
}
