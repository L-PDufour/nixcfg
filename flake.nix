{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    dwm = {
      url = "github:L-PDufour/dwm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dmenu = {
      url = "github:L-PDufour/dmenu";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    st = {
      url = "github:L-PDufour/st";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dwmblocks = {
      url = "github:L-PDufour/dwmblocks-async";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
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
