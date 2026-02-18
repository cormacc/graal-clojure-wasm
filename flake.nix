{
  description = "A Nix-flake-based Graal/Clojure/Wasm development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:

    let
      overlays = [
        (final: prev: rec {
          # Using graalvm-oracle rather than graalvm-ce, as the latter doesn't include svm-wasm (as of v25.0.1 at least)
          jdk = prev.graalvmPackages.graalvm-oracle;
          clojure = prev.clojure.override { inherit jdk; };
        })
      ];
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs {
          inherit overlays system;
          config.allowUnfree = true;
        };
      });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            clojure
            binaryen
          ];
        };
      });
    };
}
