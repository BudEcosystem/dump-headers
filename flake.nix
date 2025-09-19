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
              infra-debug-tools = pkgs.callPackage ./nix/package.nix { };
              default = self.packages.${system}.infra-debug-tools;
            }
          ))
          (
            forLinuxSystems (
              { system, pkgs }:
              {
                oci-dump-headers = pkgs.callPackage ./nix/oci/dump-headers.nix {
                  infra-debug-tools = self.packages.${system}.infra-debug-tools;
                };
                oci-concurrency-test = pkgs.callPackage ./nix/oci/concurrency-test.nix {
                  infra-debug-tools = self.packages.${system}.infra-debug-tools;
                };
              }
            )
          );

      devShells = forAllSystems (
        { system, pkgs }:
        {
          infra-debug-tools = pkgs.callPackage ./nix/shell.nix {
            infra-debug-tools = self.packages.${system}.infra-debug-tools;
          };
          default = self.devShells.${system}.infra-debug-tools;
        }
      );
    };
}
