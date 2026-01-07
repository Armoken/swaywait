{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };
  outputs = { nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
      dmenu-systemd = pkgs.python3Packages.buildPythonApplication {
        pname = "swaywait";
        version = "1.1";

        pyproject = true;
        build-system = [ pkgs.python3Packages.setuptools ];

        propagatedBuildInputs = with pkgs.python3Packages; [
          i3ipc # An improved Python library to control i3wm and sway
        ];

        src = ./.;
      };
      python-with-packages = ((pkgs.python3.withPackages(ps: [
        ps.i3ipc

        ps.ipython
      ])).overrideAttrs (args: { ignoreCollisions = true; doCheck = false; }));
    in {
      defaultPackage = dmenu-systemd;
      devShell       = pkgs.mkShell {
        nativeBuildInputs = [
          python-with-packages

          pkgs.pyright                 # Type checker for the Python language.
          pkgs.fish
        ];
        shellHook = ''
        PYTHONPATH=${python-with-packages}/${python-with-packages.sitePackages}
        # maybe set more env-vars
        '';

        runScript = "fish";
      };
    }
  );
}
