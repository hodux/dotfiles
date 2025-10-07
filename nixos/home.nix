{ config, pkgs, spicetify-nix, zen-browser, ... }:

{
  imports = [
    spicetify-nix.homeManagerModules.default
    zen-browser.homeModules.beta
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "rintaro";
  home.homeDirectory = "/home/rintaro";

  programs.zen-browser.enable = true;
  programs.spicetify =
  let
    spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in
  {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle # shuffle+ (special characters are sanitized out of extension names)
    ];
    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      ncsVisualizer
    ];
    enabledSnippets = with spicePkgs.snippets; [
      rotatingCoverart
      pointer
    ];

    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };


  # Packages that should be installed to the user profile.
  home.packages = [
    pkgs.htop
    pkgs.fortune
    pkgs.cmatrix
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
