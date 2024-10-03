{ config, pkgs, inputs, ... }:

{
imports =
[
  ./hardware-configuration.nix
  ./systempackages.nix
  ./nvidia.nix
];

# NixOS 
system.stateVersion = "24.05"; # dont touch it says
nix.settings.experimental-features = ["nix-command" "flakes"];
home-manager = {
    extraSpecialArgs= { inherit inputs; };
    users = {
        "mvayk" = import ../../users/mvayk/home.nix;
    };
};
nixpkgs.config.allowUnfree = true;

# Bootloader
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;

# Networking
networking.hostName = "moriya";
networking.networkmanager.enable = true;

# Timezone & Keyboard
time.timeZone = "Australia/Sydney";
i18n.defaultLocale = "en_AU.UTF-8";
i18n.extraLocaleSettings = {
LC_ADDRESS = "en_AU.UTF-8";
LC_IDENTIFICATION = "en_AU.UTF-8";
LC_MEASUREMENT = "en_AU.UTF-8";
LC_MONETARY = "en_AU.UTF-8";
LC_NAME = "en_AU.UTF-8";
LC_NUMERIC = "en_AU.UTF-8";
LC_PAPER = "en_AU.UTF-8";
LC_TELEPHONE = "en_AU.UTF-8";
LC_TIME = "en_AU.UTF-8";
};

services.xserver.xkb = {
    layout = "au";
    variant = "";
};

# Desktop Environment
services.xserver.enable = true;
services.displayManager.sddm.enable = true;
services.desktopManager.plasma6.enable = true;
services.xserver.desktopManager.gnome.enable = false;

# Environment
environment.variables.EDITOR = "nvim";

# Services
services.openssh.enable = true;
services.printing.enable = true;
services.tor = {
    enable = true;
    openFirewall = true;
    relay = {
        enable = true;
        role = "relay";
    };
};

services.tor.settings = {
      UseBridges = true;
      ClientTransportPlugin = "obfs4 exec ${pkgs.obfs4}/bin/lyrebird";
      Bridge = "obfs4 IP:ORPort [fingerprint]";
};

 # Audio
hardware.pulseaudio.enable = false;
security.rtkit.enable = true;
services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
};

# Users
users.users.mvayk = {
    isNormalUser = true;
    description = "mvayk";
    extraGroups = [ "networkmanager" "wheel" ];
};

# Programs
programs.neovim.enable = true;
programs.neovim.defaultEditor = true;
programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
};
programs.firefox.enable = true;
}
