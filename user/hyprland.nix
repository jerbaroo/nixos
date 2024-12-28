{ inputs, pkgs, system, ... }:
let
  wallpaper = pkgs.fetchurl {
    hash = "sha256-8FaX9qSTZ9Nw12IGwRKPwB1s765dQ/sTPImx6jN4BXE=";
    url = "https://raw.githubusercontent.com/vinceliuice/Orchis-theme/master/wallpaper/4k.jpg";
  };
in
{
  home.packages = with pkgs; [
    grim
    # hyprexpo
    hyprpicker
    slurp
    swappy
    wl-clipboard
  ];
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [{ color = "rgb(30, 30, 46)"; }];
      general.hide_cursor = true;
      input-field = [{
        fade_on_empty = false;
        outline_thickness = 5;
        placeholder_text = "Enter password";
        shadow_passes = 2;
        # Colours.
        check_color = "rgb(245, 194, 231)";
        fail_color = "rgb(245, 194, 231)";
        font_color = "rgb(205, 214, 244)";
        inner_color = "rgb(49, 50, 68)";
        outer_color = "rgb(24, 24, 37)";
      }];
    };
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      preload = [(builtins.toString wallpaper)];
      splash = false;
      wallpaper = [",${(builtins.toString wallpaper)}"];
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${system}.hyprland;
    plugins = [
      # inputs.hyprland-plugins.packages.${system}.hyprexpo
    ];
    settings = {
      "$mod" = "SUPER";
      bind = 
        [ "$mod, C, killactive"
          "$mod, E, exec, emacs"
          "$mod, F, fullscreen"
          # "$mod, T, hyprexpo:expo, toggle"
          "$mod, M, exec, ags -t applauncher"
          "$mod, Q, exec, ags -t powermenu"
          "$mod, RETURN, exec, ghostty"
          "$mod, P, exec, hyprpicker --autocopy"
          "$mod SHIFT, P, exec, hyprpicker --autocopy --render-inactive"
          "$mod, S, exec, grim -g \"$(slurp)\" - | swappy -f -"
          "$mod, T, togglesplit, # dwindle"
          "$mod, V, togglefloating"
          "$mod, W, exec, firefox"
          # Scratch pad.
          # "$mod, S, togglespecialworkspace, magic"
          # "$mod SHIFT, S, movetoworkspace, special:magic"
          # Focus navigation.
          "$mod, H, movefocus, l"
          "$mod, J, movefocus, d"
          "$mod, K, movefocus, u"
          "$mod, L, movefocus, r"
          # Window navigation.
          "$mod CTRL, H, movewindow, l"
          "$mod CTRL, J, movewindow, d"
          "$mod CTRL, K, movewindow, u"
          "$mod CTRL, L, movewindow, r"
          "$mod SHIFT, H, swapwindow, l"
          "$mod SHIFT, J, swapwindow, d"
          "$mod SHIFT, K, swapwindow, u"
          "$mod SHIFT, L, swapwindow, r"
          # Drag/resize windows. TODO: broken.
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizeactive"
          # Switch focus to workspace.
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 0"
          # Move window to workspace.
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 0"
        ];
      decoration = {
        active_opacity = 0.85;
        inactive_opacity = 0.85;
        rounding = 0;
      };
      dwindle = {
        # no_gaps_when_only = 1;
        preserve_split = true;
      };
      exec-once = [ "ags" ];
      general = {
        border_size = 2;
        "col.active_border" = "rgb(f5c2e7)"; # Catppuccin mocha pink.
        # "col.inactive_border" = "rgb(282a36)";
        gaps_in = 0;
        gaps_out = 0;
        resize_on_border = true;
      };
      misc.disable_hyprland_logo = true;
    };
  };
}
