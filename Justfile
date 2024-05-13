switch:
  {{ if os() == "macos" { "darwin" } else { "nixos" } }}-rebuild switch --flake .

hm:
  home-manager switch --flake .

gc:
  sudo nix-collect-garbage --delete-old
