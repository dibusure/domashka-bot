{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = with pkgs;[
    ruby_3_1
    pry
    gem
    bundix
  ];
}
