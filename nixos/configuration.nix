
{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Plymouth for splashscreen
  boot.plymouth.enable = true;
  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "udev.log_priority=3"
    "rd.systemd.show_status=auto"
  ];
  boot.loader.timeout = 0;

  networking.hostName = "nixos";
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
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

  # Services
  services.displayManager.ly = {
    enable = true;

    settings = {
      # DOOM PSX fire
      animate = true;
      animation = "0";

      # Hide F1–F12 hints
      hide_key_hints = true;
      # Hide version
      hide_version_string = true;

      # Add a clock
      bigclock = true;
    };
  };

  # Daemon to update firmware UEFI
  services.fwupd.enable = true;

  # Keybindings
  services.keyd.enable = true;
  services.keyd.keyboards.default.settings.main.capslock = "overload(control, esc)";
  
  # Allow unfree apps
  nixpkgs.config.allowUnfree = true;

  # NixOS Modules
  programs.fish.enable = true;
  programs.hyprland.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    # Terminal Emulators
    kitty
    foot

    # Dev + CLIs
    git
    tmux
    ripgrep
    javaPackages.compiler.temurin-bin.jdk-8
    adoptopenjdk-icedtea-web
    python314
    nodejs_24
    go
    docker
    kubectl
    krew
    yamllint
    fastfetch
    glances
    cmatrix
    htop
    btop
    openssl
    gcc
    unzip
    gnumake
    rustc
    cargo
    gvfs
    smbclient-ng
    aichat
    starship
    eza
    zoxide
    direnv

    # Editors
    neovim
    vscode
    jetbrains.idea-community
    zed-editor

    # System
    hyprshot
    hyprpicker
    wl-clipboard
    ly
    xfce.thunar
    brightnessctl
    playerctl
    pavucontrol
    home-manager
    adwaita-icon-theme
    papirus-icon-theme
    emote

    # Apps
    obsidian
    discord
    spotify
    feishin
    onlyoffice-desktopeditors
    vmware-workstation
    qemu

  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
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

  nixpkgs.config.permittedInsecurePackages = [
    "electron-36.9.5"
  ];

  # NEVER CHANGE THIS
  system.stateVersion = "25.05";

}
