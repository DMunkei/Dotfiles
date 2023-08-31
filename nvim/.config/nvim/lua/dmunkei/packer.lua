function get_config(name)
	return string.format('require("dmunkei/%s")', name)
end

function get_default(name)
	return string.format('require("%s").setup()', name)
end

require('lazy').setup({
	-- Best theme world
	"rebelot/kanagawa.nvim",

	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
	-- Telescope
    "nvim-telescope/telescope-ui-select.nvim",
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "BurntSushi/ripgrep" },
		},
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"p00f/nvim-ts-rainbow",
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},
	"nvim-treesitter/nvim-treesitter-context",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	-- LSP
	"neovim/nvim-lspconfig",
	"j-hui/fidget.nvim",
	"simrat39/rust-tools.nvim",
	-- CMP
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
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
	},
	"windwp/nvim-autopairs",

	--Tests
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-python",
			"rouge8/neotest-rust",
			"haydenmeade/neotest-jest",
		},
	},

	-- Debugging
	"mfussenegger/nvim-dap",
	"nvim-telescope/telescope-dap.nvim",
	"theHamsta/nvim-dap-virtual-text",
	"rcarriga/nvim-dap-ui",
	"mfussenegger/nvim-dap-python",

	-- formatter
	"sbdchd/neoformat",

	-- useful
	"ThePrimeagen/harpoon",
	"mbbill/undotree",
	{ "lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	"terrortylor/nvim-comment",
	"iamcco/markdown-preview.nvim",

	"lukas-reineke/indent-blankline.nvim",
	{ "kosayoda/nvim-lightbulb",
		dependencies = "antoinemadec/FixCursorHold.nvim",
	},
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({ })
		end,
	},
	-- Tpope
	"tpope/vim-dadbod",
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"tpope/vim-surround",

	-- lua dev
	"folke/neodev.nvim",
	"h-hg/fcitx.nvim",
	--
	-- {
	-- 	"sourcegraph/sg.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	cmd = { "cargo", "build", "--workspace" },
	-- },
	"uga-rosa/ccc.nvim",
	"stevearc/oil.nvim",
	"jose-elias-alvarez/null-ls.nvim",
	"folke/trouble.nvim",
})
