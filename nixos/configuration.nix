{ config, pkgs, nixpkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # For the VS Server fix
  nixpkgs.config.permittedInsecurePackages = [
    "nodejs-16.20.2"
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes"];
  nix.settings.auto-optimise-store = true;
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  # Saving Space
  boot.kernelParams = [
    "modprobe.blacklist=edac_core,aesni_intel,crypto_simd"
  ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # Enable networking
  # networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.vscode-server.enableFHS = true;



  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  services.xserver.enable = true;

  services.xserver.displayManager = {
    # Enable automatic login for the user.
    autoLogin.enable = true;
    autoLogin.user = "adam";

    # Enable the KDE Plasma Desktop Environment.
    sddm.enable =  true;
  };

  services.xserver.desktopManager.plasma5.enable = true;

  # Suspend settings
  services.autosuspend = {
    enable = false;
  
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Adding auxillary groups for dynamic window control.
  users.extraGroups = [
    "libvert"
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.adam = {
    isNormalUser = true;
    description = "Adam Liang";
    extraGroups = [ "wheel" "libvert" ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.variables = { EDITOR = "nvim"; };
  
  environment.systemPackages = with pkgs; [
    vscode-fhs
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    configure = {
      customRC = ''
        set tabstop=2
	      set shiftwidth=2
	      set expandtab
	      syntax on
	      set backspace=indent,eol,start
	      set nocompatible
        set autoindent
      '';
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
    settings.PermitRootLogin = "yes";
  };

  virtualisation.libvirtd = {
    enabled = true;
  };

  # virtualization.emu = {
  #   enable = true;
  #   machines = {
  #     "VMM-Dev" = {
  #       memory = 3070;
  #       cores = 2;
  #       spice = true;
  #     };
  #   };
  # };

  networking.firewall.enable = false;

  system.stateVersion = "unstable"; # Did you read the comment?

}
