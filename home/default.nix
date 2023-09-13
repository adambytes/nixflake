{ pkgs, home-manager, ... }: 

{
  # Letting HM start my X session to use graphical services.
  xsession.enable = true;

  home.packages = with pkgs; [
    chromium
    
    # CLI
    gh
    zsh
    oh-my-zsh
    fzf-zsh

    # Version Control
    obsidian

    # Development
    conda
    bun
  ];

  programs.git = {
    enable = true;
    userName = "Adam Liang";
    userEmail = "hello@adamliang.dev";
  };

  # Finish Wezterm Config
  programs.wezterm = {
    enable = true;
    extraConfig = {
      import wezterm.lua
    };
    colorSchemes = {};

  };

  # TODO: Aiming for screensaver but not sleep / suspend.
  services = {
    xscreensaver.settings = {
      fadeTicks = 20;
      lock = true;
      mode = "blank";
    };

    xsuspender = {
      enable = true;
    };
  };
  


  home.stateVersion = "23.11";

}