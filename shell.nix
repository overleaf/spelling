with import <nixpkgs> {};

stdenv.mkDerivation {
    name = "node";
    buildInputs = [
        aspell
        nodejs
        python
    ];
    shellHook = ''
        export PATH="$PWD/node_modules/.bin/:$PATH"
    '';
}
