FROM nixos/nix:2.2.1

WORKDIR /app

COPY package*.json /app/

RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
RUN nix-channel --update

COPY . /app

RUN nix-shell --run 'npm install --quiet --only=prod'

ENTRYPOINT nix-shell --run 'node --expose-gc app.js'
