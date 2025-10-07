
{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  # Pick only one of the below networking options.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rintaro = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };

  # Programs
  programs.fish.enable = true;
  programs.hyprland.enable = true;
  programs.waybar.enable = true;
  programs.firefox.enable = true;

  # Services
  services.displayManager.ly.enable = true;
  services.mpd.enable = true;

  # Keybindings
  services.keyd.enable = true;
  services.keyd.keyboards.default.settings.main.capslock = "overload(control, esc)";
  
  # Allow unfree apps
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    # Terminal Emulators
    kitty
    foot

    # Shell
    fish

    # Dev + CLIs
    git
    python314
    nodejs_24
    go
    zulu8
    docker
    kubectl
    krew
    kubernetes-helm
    fastfetch
    mpd
    rmpc
    yad
    glances
    discordo
    gcc
    unzip
    gnumake
    rustc
    cargo

    # Dev
    tmux
    ripgrep
    ranger

    # IDEs
    neovim
    vscode
    jetbrains.idea-community

    # System
    hyprpaper
    hyprshot
    hyprlock
    hypridle
    hyprcursor
    ly
    xfce.thunar
    rofi
    nwg-drawer
    wleave
    brightnessctl
    playerctl
    swaynotificationcenter
    wl-clipboard
    pavucontrol
    pamixer
    home-manager
    yad
    wallust
    adwaita-icon-theme

    # Apps
    discord
    spotify

    # Browser
    firefox
    librewolf
    qutebrowser

  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts

    # Extra
    font-awesome
    nerd-fonts.jetbrains-mono
    cozette
    source-code-pro
  ];

  # NEVER CHANGE THIS
  system.stateVersion = "25.05";

}
