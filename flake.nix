{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";

    user-nvim.url = "github:L-PDufour/user.nvim?ref=nix";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    lix-module,
    stylix,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/laptop/configuration.nix
        ];
      };
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          lix-module.nixosModules.default
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          ./hosts/desktop/configuration.nix
        ];
      };
      server = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/server/configuration.nix
        ];
      };
    };
  };
}
