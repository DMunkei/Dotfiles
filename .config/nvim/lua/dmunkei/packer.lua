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
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- LSP
  use('neovim/nvim-lspconfig') -- Helps to manage and connect to different LSPs. Configurations only for different langauges to attach and manage them.
  -- LSP Autocompletion
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/nvim-cmp') 
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')
  use('L3MON4D3/LuaSnip')

  --HARPOOOOOOOOOON
  use('ThePrimeagen/harpoon')
  end)
