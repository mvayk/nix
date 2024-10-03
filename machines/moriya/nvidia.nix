{ config, pkgs, ... }:

{
services.xserver.videoDrivers = ["nvidia"];

environment.variables = {
    LIBVA_DRIVER_NAME="nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
}; 

hardware.graphics = {
    enable = true;
};

hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
    open = false;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
};

boot.kernelParams = [
    "nvidia-drm.modeset=0"
];
}
