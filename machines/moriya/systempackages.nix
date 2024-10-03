{ config, pkgs, ... }:
{
    fonts.packages = with pkgs; [
        nerdfonts
    ];

    environment.systemPackages = with pkgs; [
        python3
        pkgs.gnome-tweaks
        luarocks
        ripgrep
        lua
        gcc
        zig
        nwg-look
        fastfetch
    ];
}

