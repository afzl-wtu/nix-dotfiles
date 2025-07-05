{ pkgs, lib, config, ... }: {

  environment.systemPackages = with pkgs; [
    intel-gpu-tools
  ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libva-vdpau-driver
      intel-compute-runtime-legacy1
      intel-media-sdk
      intel-ocl
    ];
  };
}

