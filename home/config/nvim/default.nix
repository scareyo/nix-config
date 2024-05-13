{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      bufferline-nvim
      feline-nvim
      nvim-lspconfig
      telescope-nvim
      nvim-tree-lua
      nvim-web-devicons
    ];
  };

  xdg.configFile.nvim = {  
    source = ./config;  
    recursive = true;  
  };
}
