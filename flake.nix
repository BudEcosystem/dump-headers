{
  inputs.nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      lib = nixpkgs.lib;

      forSystem =
        f: system:
        f {
          inherit system;
          pkgs = import nixpkgs { inherit system; };
        };
      supportedSystems = lib.platforms.unix;
      forAllSystems = f: lib.genAttrs supportedSystems (forSystem f);
      forLinuxSystems = f: lib.genAttrs lib.platforms.linux (forSystem f);
    in
    {

      packages =
        lib.recursiveUpdate
          (forAllSystems (
            { system, pkgs }:
            {
              dh = pkgs.callPackage ./nix/package.nix { };
              default = self.packages.${system}.dh;
            }
          ))
          (
            forLinuxSystems (
              { system, pkgs }:
              {
                oci = pkgs.callPackage ./nix/oci.nix {
                  dh = self.packages.${system}.dh;
                };
              }
            )
          );

      devShells = forAllSystems (
        { system, pkgs }:
        {
          dh = pkgs.callPackage ./nix/shell.nix {
            dh = self.packages.${system}.dh;
          };
          default = self.devShells.${system}.dh;
        }
      );
    };
}
