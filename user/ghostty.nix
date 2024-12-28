{ inputs, pkgs, system, ... }: {
  programs.ghostty = {
    enable = true;
    package = inputs.ghostty.packages.${system}.default;
    settings = {
      command = "${pkgs.fish}/bin/fish";
      config-file = [
        (inputs.color-schemes + "/ghostty/catppuccin-mocha")
      ];
      confirm-close-surface = false;
      font-size = 22;
      scrollback-limit = 1000000;
      window-decoration = false;
    };
  };
}