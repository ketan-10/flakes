
# yescrypt your password
mkpasswd --method=yescrypt

# run agenix 
cd minibox/secrets
sudo nix run github:ryantm/agenix -- -e secret1.age

sudo nix run nixpkgs#nixos-anywhere -- \
        --flake ./minibox#minibox \
        --generate-hardware-config nixos-generate-config ./minibox/hardware-configuration.nix \
        --extra-files ./minibox/extra-files \
        nixos@192.168.29.144
        
# --impure (--option pure-eval false)
