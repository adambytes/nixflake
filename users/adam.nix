{ pkgs, home-manager, ... }: 

{
  # Letting HM start my X session to use graphical services.
  xsession.enable = true;

  home.packages = with pkgs; [
    firefox
    
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

  programs.wezterm = {
    enable = true;
    extraConfig = 
    colorSchemes = {};

  }

  home.stateVersion = "23.11";

}