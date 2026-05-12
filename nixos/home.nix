{ config, pkgs, ...}:

{
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "25.11";
  programs.fish = {
    enable = true;
    shellAliases = {
      fih = "fish && exit";
      nrs = "sudo nixos-rebuild switch --flake /etc/nixos#nixPad";
      nru = "sudo nixos-rebuild switch --upgrade --flake /etc/nixos#nixPad";
      nfu = "cd /etc/nixos/ && sudo nix flake update && cd";
      btw = "echo I use nixos btw";
      hlc = "find ~/.config/hypr/* | fzf --preview='bat {}' | xargs nvim";
      qsc = "find ~/.config/quickshell/* | fzf --preview='bat {}' | xargs nvim";
      nxc = "find /etc/nixos/* | fzf --preview='bat {}' | xargs sudo nvim";
    };
  };
 # programs.hyprland = {
 #   enable = true;
 #   xwayland.enable = true;
 #    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
 #    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
 # };
  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
  };
}
