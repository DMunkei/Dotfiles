-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
local packer = require'packer'

local packer_sync_group = vim.api.nvim_create_augroup("PackerSyncGroup", {clear = true})
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = {"packer.lua"},
    callback = function()
        print "Wassup"
    end,
    group=packer_sync_group
})



return packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Best theme world
  use 'rebelot/kanagawa.nvim'

  use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
  -- comments
  use('terrortylor/nvim-comment')
  -- Telescope
  use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
      -- or                            , branch = '0.1.x',
      requires = {
          {'nvim-lua/plenary.nvim'},
          {'BurntSushi/ripgrep'},
      }
  }
  use{ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use('nvim-treesitter/playground')

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  use("simrat39/symbols-outline.nvim")
  -- LSP
   use {
       "williamboman/mason.nvim",
       "williamboman/mason-lspconfig.nvim",
       "neovim/nvim-lspconfig", -- Helps to manage and connect to different LSPs. Configurations only for different langauges to attach and manage them.
   }
  -- LSP Autocompletion
  use('hrsh7th/nvim-cmp') 
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')

  use('L3MON4D3/LuaSnip')
  use('onsails/lspkind.nvim')

  -- Debugging
  use('mfussenegger/nvim-dap')
  use('nvim-telescope/telescope-dap.nvim')
  use('theHamsta/nvim-dap-virtual-text')
  use('rcarriga/nvim-dap-ui')
  use 'mfussenegger/nvim-dap-python'
  --HARPOOOOOOOOOON
  use('ThePrimeagen/harpoon')
  use("mbbill/undotree")

  -- Things I'm experimeneting with.
  -- Git
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  end)
