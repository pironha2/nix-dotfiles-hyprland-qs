{
  description = "tak fr to nwm";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager ={
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      # add ?ref=<tag> to track a tag
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    # };
  };

  outputs = { nixpkgs, home-manager, ...}: {
    nixosConfigurations.nixPad = nixpkgs.lib.nixosSystem {
      # specialArgs = { inherit inputs; }; # this is the important part
      modules = [
        ./configuration.nix 
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.user = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
