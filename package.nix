{
  pkgs ? import <nixpkgs> {},
  lib,
  ...
}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "safecat";
  version = "0.1.0";
  src = ./.;

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      # "acme2-0.5.2" = lib.fakeSha256;
    };
  };

  # cargoBuildHook = ''
  # buildPhase = ''
  #   cargo build --release
  # '';
  # installPhase = ''
  #   mkdir -p $out/bin
  #   install -t target/release/${pname} $out/bin
  # '';
  # disable tests
  checkType = "debug";
  doCheck = false;

  nativeBuildInputs = with pkgs; [
    installShellFiles
    openssl.dev
    pkg-config
    rustc
    cargo
  ];
  PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";

  # postInstall = with lib; ''
  #   installShellCompletion --cmd ${pname}\
  #     --bash ./autocompletion/${pname}.bash \
  #     --fish ./autocompletion/${pname}.fish \
  #     --zsh  ./autocompletion/_${pname}
  # '';
}
