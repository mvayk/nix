{ config, pkgs, ... }:
{
    fonts.packages = with pkgs; [
        nerdfonts
    ];

    environment.systemPackages = with pkgs; [
        tor
        tor-browser
        python3
        pkgs.gnome-tweaks
        luarocks
        ripgrep
        lua
        gcc
        zig
        nwg-look
        obsidian
        fastfetch
    ];
}

