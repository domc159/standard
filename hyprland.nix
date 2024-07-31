# arch.nix
{ config, pkgs, ... }:

let
  hyprlandDeps = [
    # Fonts
    pkgs.adobe-source-code-pro
    pkgs.noto-fonts-emoji
    pkgs.font-awesome
    pkgs.droid
    pkgs.fira-code
    pkgs.jetbrains-mono
    pkgs.jetbrains-mono-nerd

    # Main Hyprland packages
    pkgs.hyprland
    pkgs.hyprcursor

    # Nvidia
    pkgs.linuxPackages.nvidiaPackages.dkms
    pkgs.nvidia-settings
    pkgs.nvidia-utils
    pkgs.libva
    pkgs.libva-utils

    # Audio
    pkgs.pipewire
    pkgs.wireplumber
    pkgs.pipewire-alsa
    pkgs.pipewire-pulse

    # SDDM
    pkgs.qt6.qt6Compat
    pkgs.qt6.qt6Declarative
    pkgs.qt6.qt6Svg
    pkgs.sddm

    # Thunar
    pkgs.thunar
    pkgs.thunar-volman
    pkgs.tumbler
    pkgs.ffmpegthumbnailer
    pkgs.file-roller
    pkgs.thunar-archive-plugin

    # XDG
    pkgs.xdg-desktop-portal
    pkgs.xdg-desktop-portal-gtk

    # Zsh
    pkgs.eza
    pkgs.zsh
    pkgs.zsh-completions
    pkgs.fzf

    # Other
    pkgs.aylurs-gtk-shell
    pkgs.cliphist
    pkgs.curl
    pkgs.grim
    pkgs.gvfs
    pkgs.gvfs-mtp
    pkgs.hypridle
    pkgs.hyprlock
    pkgs.imagemagick
    pkgs.inxi
    pkgs.jq
    pkgs.kitty
    pkgs.kvantum
    pkgs.nano
    pkgs.networkmanagerapplet
    pkgs.pamixer
    pkgs.pavucontrol
    pkgs.playerctl
    pkgs.polkit_gnome
    pkgs.python3
    pkgs.python3Packages.requests
    pkgs.python3Packages.pyquery
    pkgs.pyprland
    pkgs.qt5ct
    pkgs.qt6ct
    pkgs.rofi-wayland
    pkgs.slurp
    pkgs.swappy
    pkgs.swaync
    pkgs.swww
    pkgs.wallust
    pkgs.waybar
    pkgs.wget
    pkgs.wl-clipboard
    pkgs.wlogout
    pkgs.xdg-user-dirs
    pkgs.xdg-utils
    pkgs.yad
    pkgs.nnn
    pkgs.nemo
    pkgs.brightnessctl
    pkgs.btop
    pkgs.cava
    pkgs.eog
    pkgs.fastfetch
    pkgs.gnome-system-monitor
    pkgs.mousepad
    pkgs.mpv
    pkgs.mpv-scripts.mpv-mpris
    pkgs.nvtop
    pkgs.nwg-look
    pkgs.vim
    pkgs.yt-dlp
  ];
in {
  imports = [
    ./arch.nix
  ];

  environment.systemPackages = with pkgs; hyprlandDeps;

  services = {
    xserver = {
      enable = true;
      windowManager.hyprland = {
        enable = true;
        package = pkgs.hyprland;
      };
    };
    sddm = {
      enable = true;
      theme = "breeze";
    };
  };

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaPackage = pkgs.linuxPackages.nvidiaPackages.dkms;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.pulseaudio.package = pkgs.pipewire;
  hardware.pulseaudio.support32Bit = true;

  programs.zsh = {
    enable = true;
    ohMyZsh.enable = true;
    enableDefaultShell = true;
  };

  users.defaultUserShell = pkgs.zsh;
}
