{ config, pkgs, lib, ... }:

{
  
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager = {
    backupFileExtension = "xxx";
    users.hrm = { pkgs, ... }: {
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


