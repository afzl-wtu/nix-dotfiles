{pkgs, modulesPath,...}:{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];
  environment.systemPackages = with pkgs; [
    disko
    git
    alacritty
    cgdisk
    fzf
    zoxide
    fastfetch
    eza
    ripgrep
    tmux
    meslo-lgs-nf
    fishPlugins.tide
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  networking.networkmanager.enable = true;
  programs.hyprland.enable = true;
  programs.firefox.enable = true;
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      tide configure --auto --style=Rainbow --prompt_colors='True color' --show_time='24-hour format' --rainbow_prompt_separators=Round --powerline_prompt_heads=Slanted --powerline_prompt_tails=Slanted --powerline_prompt_style='Two lines, character and frame' --prompt_connection=Dotted --powerline_right_prompt_frame=No --prompt_connection_andor_frame_color=Darkest --prompt_spacing=Sparse --icons='Many icons' --transient=No
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
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}