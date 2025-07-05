{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "macbook-m4";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Karachi";

  users.mutableUsers = false;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;  
  users.users.hrm = {
    isNormalUser = true;
    shell = pkgs.fish;
    hashedPasswordFile = "/home/hrm/nix-dotfiles/secrets/hrm-password";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  programs.firefox.enable = true;
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      fastfetch --config examples/13
    '';
  shellAliases = {
    "ls" = "eza --icons";
    "tree" = "eza --icons -T";
  };
    };
  services.tailscaleAuth.enable = true;
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user="hrm";
  };
  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
    HandleLidSwitchExternalPower=ignore
  '';
  
  environment.systemPackages = with pkgs; [
    wget
    brave
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    ripgrep
    eza
    fastfetch
    aria2
    p7zip
    rclone
    iw
    tmux
    meslo-lgs-nf
    alacritty
    fishPlugins.tide
  ];

  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  system.stateVersion = "25.05"; # Did you read the comment?
}

