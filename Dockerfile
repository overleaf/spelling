FROM nixos/nix:2.2.1 as builder

WORKDIR /app

COPY . /app

RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs && \
    nix-channel --update && \
    nix-shell --run 'npm install --quiet --only=prod'


FROM node:10.16.0

COPY --from=builder /app /app

WORKDIR /app
RUN chmod 0755 ./install_deps.sh && ./install_deps.sh
USER node

CMD ["node", "--expose-gc", "app.js"]
