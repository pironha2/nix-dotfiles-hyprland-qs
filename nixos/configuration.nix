# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  networking.hostName = "nixPad";
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
    };
    efi.canTouchEfiVariables = true;
  };
  console.keyMap = "pl";

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable Ly Dm
  services.displayManager.ly = {
    enable = true;
    settings = {
      animate = true;
      animation = "colormix";
      battery_id = "BAT0";
      hide_version_string = true;
    };
  };
  
  services.upower = {
    enable = true;
  };

  # Enable Bluetooth
  hardware.bluetooth.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        tree 
    ];
  };
  
  programs.fish = { 
    enable = true;
    interactiveShellInit = ''
    clear 
    nitch
    '';
  };

  programs.hyprland = { 
    enable = true;  
    xwayland.enable = true; 
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    mpv
    firefox
    youtube-tui
    playerctl
    awww
    localsend
    grim
    yt-dlp
    ffmpeg
    python3
    upower
    powertop
    rmpc
    bat
    fzf
    fsel
    foot
    pango
    brightnessctl
    nwg-look
    qt6Packages.qt6ct
    qutebrowser
    nautilus
    fuzzel
    btop
    hyprcursor
    hyprpaper
    tmux
    fastfetch
    nitch
    zsh
    fish
    matugen
    quickshell
    ghostty
    neovim
    git
    wget
    lf
    wl-clipboard
    unzip
    cliphist
    bluetuith
    kitty
  ];
  
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.geist-mono
    inter
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}

