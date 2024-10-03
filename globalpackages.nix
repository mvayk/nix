{ config, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        neovim 
        git
        keepassxc
        unzip
        xclip
        kitty
        starship
        fish
        eza
    ];
}
