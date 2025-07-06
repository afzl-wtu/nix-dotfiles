{pkgs,modulesPath,...}:{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];
  environment.systemPackages = [
    disko
    git
    alacritty
    cgdisk
    fzf
    zoxide
    fastfetch
    eza
    ripgrep
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  networking.networkmanager.enable = true;
  programs.hyprland.enable = true;
  programs.firefox.enable = true;
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      fastfetch --config examples/13
      zoxide init fish | source
      fzf --fish | source
    '';
  shellAliases = {
    "ls" = "eza --icons";
    "tree" = "eza --icons -T";
  };
    };

  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}