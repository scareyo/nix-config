#!/usr/bin/env zsh

case `uname` in
  Darwin)
    nix run nix-darwin -- switch --flake .
  ;;
  Linux)
    echo "Linux init unimplemented"
  ;;
esac

