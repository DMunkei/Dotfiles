-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Best theme world
  use 'rebelot/kanagawa.nvim'
  
  -- Telescope
  use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
      -- or                            , branch = '0.1.x',
      requires = {
          {'nvim-lua/plenary.nvim'},
          {'BurntSushi/ripgrep'},
      }
  }
  use 'nvim-treesitter/nvim-treesitter'
  end)
