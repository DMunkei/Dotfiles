function get_config(name)
	return string.format('require("dmunkei/%s")', name)
end

function get_default(name)
	return string.format('require("%s").setup()', name)
end

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])
local packer = require("packer")

return packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Best theme world
	use("rebelot/kanagawa.nvim")

	use({ "nvim-lualine/lualine.nvim", requires = { "nvim-tree/nvim-web-devicons" } })
	-- Telescope
	use({ "nvim-telescope/telescope-ui-select.nvim" })
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "BurntSushi/ripgrep" },
		},
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = {
			"p00f/nvim-ts-rainbow",
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		run = ":TSUpdate",
	})
	use("nvim-treesitter/nvim-treesitter-context")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- LSP
	use("neovim/nvim-lspconfig")
	use("j-hui/fidget.nvim")
	use("simrat39/rust-tools.nvim")
	-- CMP
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-omni",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-emoji",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"f3fora/cmp-spell",
		},
		config = get_config("cmp"),
	})
	use("windwp/nvim-autopairs")

	--Tests
	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-python",
			"rouge8/neotest-rust",
			"haydenmeade/neotest-jest",
		},
	})

	-- Debugging
	use("mfussenegger/nvim-dap")
	use("nvim-telescope/telescope-dap.nvim")
	use("theHamsta/nvim-dap-virtual-text")
	use("rcarriga/nvim-dap-ui")
	use("mfussenegger/nvim-dap-python")

	-- formatter
	use("sbdchd/neoformat")

	-- useful
	use("ThePrimeagen/harpoon")
	use("mbbill/undotree")
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})
	use("terrortylor/nvim-comment")
	use("iamcco/markdown-preview.nvim")

	use("lukas-reineke/indent-blankline.nvim")
	use({
		"kosayoda/nvim-lightbulb",
		requires = "antoinemadec/FixCursorHold.nvim",
	})
	use({
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})
	-- Tpope
	use("tpope/vim-dadbod")
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")
	use("tpope/vim-surround")

	-- lua dev
	use("folke/neodev.nvim")
	use("h-hg/fcitx.nvim")

	use({
		"sourcegraph/sg.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		cmd = { "cargo", "build", "--workspace" },
	})
	-- use({
	--   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	--   config = function()
	--     require("lsp_lines").setup()
	--   end,
	-- })
	use("uga-rosa/ccc.nvim")
	use("stevearc/oil.nvim")
	use("jose-elias-alvarez/null-ls.nvim")
	use("cmp-nvim-lsp-signature-help")
	use("folke/trouble.nvim")
end)
