{ config, lib, pkgs, ... }:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = [
  pkgs.totem
  pkgs.epiphany
  pkgs.simple-scan
  pkgs.yelp
  pkgs.evince
  pkgs.gnome-contacts
  pkgs.gnome-logs
  pkgs.gnome-maps
  pkgs.gnome-music
  ];
  environment.systemPackages = with pkgs; [
    gnome-boxes
    gnomeExtensions.tophat
    gnomeExtensions.app-icons-taskbar
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.hide-the-dock-in-overview
    gnomeExtensions.tailscale-qs
  ];
}
