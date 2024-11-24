{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nhaja";
  home.homeDirectory = "/Users/nhaja";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  home.packages = [
  ]; 

  # Manage dotfiles with Home Manager
  home.file = {
    ".zshrc".source = ~/dotfiles/zshrc/.zshrc;
    ".p10k.zsh".source = ~/dotfiles/powerlevel10k/.p10k.zsh;
    ".config/nvim".source = ~/dotfiles/nvim;
    ".config/wezterm".source = ~/dotfiles/wezterm;
    ".config/nix".source = ~/dotfiles/nix;
    ".config/nix-darwin".source = ~/dotfiles/nix-darwin;
    ".config/tmux".source = ~/dotfiles/tmux;
    ".config/kitty".source = ~/dotfiles/kitty;
    ".config/zellij".source = ~/dotfiles/zellij;
    ".config/aerospace".source = ~/dotfiles/aerospace;
    ".lima/arm64/lima.yaml".source = ~/dotfiles/lima/templates/ros_humble/lima.yaml;
  };

  home.sessionVariables = {
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
  ];
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = ''
      # Add any additional configurations here
      export PATH=/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';
  };
}
