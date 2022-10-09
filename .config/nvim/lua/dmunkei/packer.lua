function get_config(name) return string.format('require("dmunkei/%s")', name) end
function get_default(name) return string.format('require("%s").setup()', name) end
--
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
local packer = require'packer'

return packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Best theme world
  use 'rebelot/kanagawa.nvim'

  use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
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
  use 'nvim-treesitter/nvim-treesitter-context'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- LSP
   use { "neovim/nvim-lspconfig"}

    -- CMP
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            {"tzachar/cmp-tabnine", run = "./install.sh"},
            "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-omni", "hrsh7th/cmp-calc", "hrsh7th/cmp-emoji",
            "L3MON4D3/LuaSnip", 'saadparwaiz1/cmp_luasnip',
            "rafamadriz/friendly-snippets", "f3fora/cmp-spell"
        },
        config = get_config("cmp")
    })
  use('onsails/lspkind.nvim')
  use'windwp/nvim-autopairs'

  --Tests
    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim", "nvim-neotest/neotest-go",
            "nvim-neotest/neotest-python", "rouge8/neotest-rust",
            "haydenmeade/neotest-jest"
        }
    }


  -- Debugging
  use('mfussenegger/nvim-dap')
  use('nvim-telescope/telescope-dap.nvim')
  use('theHamsta/nvim-dap-virtual-text')
  use('rcarriga/nvim-dap-ui')
  use 'mfussenegger/nvim-dap-python'


  -- formatter
  use 'sbdchd/neoformat'
 -- use 'jose-elias-alvarez/null-ls.nvim'
  -- useful
  use('ThePrimeagen/harpoon')
  use("mbbill/undotree")
  use "lukas-reineke/indent-blankline.nvim"
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  use {
      'kosayoda/nvim-lightbulb',
      requires = 'antoinemadec/FixCursorHold.nvim',
  }
  use {
      'lewis6991/gitsigns.nvim',
      config = function()
          require('gitsigns').setup()
      end
  }
  use('terrortylor/nvim-comment')
  end)
