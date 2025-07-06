{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
    sha256 = "0h38ii2g1i54h243jx7ghbr5asfc46ai3q53qzylsksk4v72qsmm";
  };
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager = {
    backupFileExtension = "xxx";
    users.hrm = { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;
      home = {
        stateVersion = "25.05";
        packages = with pkgs; [
          go
	];
      };
      programs = {
        vscode = {
          enable = true;
          profiles.default.extensions = with pkgs.vscode-extensions; [
    	      golang.go
            pkief.material-icon-theme
            dart-code.flutter
            jnoortheen.nix-ide
            # hzgood.dart-data-class-generator
  	  ];
        };
        git = {
          enable = true;
          userName = "Afzal Tahir Wattu";
          userEmail = "afzl.wtu@hotmail.com";
        };
      };
    };
  };
}


