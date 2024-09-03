{ accent, config, flavor, inputs, pkgs-unstable, stateVersion, pkgs, system, username, ... }: {
  home-manager = {
    backupFileExtension = ".backup";
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = {
      imports = [
        inputs.catppuccin.homeManagerModules.catppuccin
        ../user/ags.nix
        ../user/direnv.nix
        ../user/emacs.nix
        ../user/fish.nix
        ../user/fonts.nix
        (import ../user/firefox.nix { inherit config; inherit username; })
        ../user/git.nix
        (import ../user/hyprland.nix { inherit inputs; inherit pkgs; inherit system; })
        ../user/kitty.nix
        ../user/lsd.nix
        (import ../user/neovim.nix { inherit pkgs; inherit pkgs-unstable; })
        ../user/protonvpn.nix
        ../user/starship.nix
        ../user/tex.nix
        (import ../user/theme.nix { inherit accent; inherit flavor; inherit pkgs; })
        ../user/tmux.nix
      ];
      home.stateVersion = stateVersion;
    };
  };

  users.users.${username} = {
    extraGroups = [ "networkmanager" "wheel" ];
    isNormalUser = true;
  };
}
