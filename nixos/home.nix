{ config, pkgs, spicetify-nix, zen-browser, caelestia-shell, caelestia-cli, ... }:

{
  imports = [
    spicetify-nix.homeManagerModules.default
    zen-browser.homeModules.beta
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "rintaro";
  home.homeDirectory = "/home/rintaro";

  # Zen
  programs.zen-browser.enable = true;

  # Spicetify
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
      # rotatingCoverart
      pointer
    ];

    theme = spicePkgs.themes.dribbblishDynamic;
  };

  # Default apps
  xdg.mimeApps = let
    value = let
      zen-browser = zen-browser.packages.nixos.beta; # or twilight
    in
      zen-browser.meta.desktopFileName;

    associations = builtins.listToAttrs (map (name: {
	inherit name value;
      }) [
	"application/x-extension-shtml"
	"application/x-extension-xhtml"
	"application/x-extension-html"
	"application/x-extension-xht"
	"application/x-extension-htm"
	"x-scheme-handler/unknown"
	"x-scheme-handler/mailto"
	"x-scheme-handler/chrome"
	"x-scheme-handler/about"
	"x-scheme-handler/https"
	"x-scheme-handler/http"
	"application/xhtml+xml"
	"application/json"
	"text/plain"
	"text/html"
      ]);
  in {
    associations.added = associations;
    defaultApplications = associations;
  };

  # Packages that should be installed to the user profile.
  home.packages = [
    pkgs.qutebrowser
    caelestia-shell.packages.x86_64-linux.with-cli
    caelestia-cli.packages.x86_64-linux.with-shell
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
