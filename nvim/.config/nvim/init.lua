-- Load `./lua/options.lua`
require("options")

-- Load `./lua/keymaps.lua`
require("keymaps")

-- Load `./lua/autocmds.lua`
require("autocmds")
--
-- Load `./lua/usercmds.lua`
require("usercmds")

-- Default installation path for lazy -- this will resolve to `~/.local/share/nvim`.
-- See `:help stdpath()`
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local lazy_setup = function()
	-- Add lazy to neovim's runtime path, this is where neovim looks for files and shit
	-- See `:help rtp`
	vim.opt.runtimepath:prepend(lazy_path)

	-- Read about these options in `:help lazy.nvim-lazy.nvim-configuration` or here:
	-- <https://github.com/folke/lazy.nvim#%EF%B8%8F-configuration>
	--
	-- The first argument (vvvvvvv) tells lazy where to look for plugin configs, and it's relative to
	-- `./lua`
	require("lazy").setup("plugins", {
		defaults = {
			-- Disable lazy loading by default so it doesn't fuck anything up
			lazy = false,
		},

		install = {
			-- Install missing plugins automatically
			missing = true,
		},

		ui = {
			-- Cool border for lazy floaty window yes
			border = "solid",
		},
	})
end

-- Is lazy already installed?
local lazy_installed = vim.loop.fs_stat(lazy_path)

if lazy_installed then
	lazy_setup()
else
	-- Clone lazy into `lazy_path`
	vim.fn.system({
		"git", "clone", "--branch=stable",
		"https://github.com/folke/lazy.nvim",
		lazy_path,
	})

	vim.notify("Installed lazy.nvim")
	lazy_setup()
end

	-- -- Treesitter
	-- {
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	dependencies = {
	-- 		"p00f/nvim-ts-rainbow",
	-- 		"nvim-treesitter/nvim-treesitter-context",
	-- 		"nvim-treesitter/nvim-treesitter-textobjects",
	-- 	},
	-- 	build = ":TSUpdate",
	-- },
	-- "nvim-treesitter/nvim-treesitter-context",
	-- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	--
	-- -- LSP
	-- "neovim/nvim-lspconfig",
	-- "j-hui/fidget.nvim",
	-- "simrat39/rust-tools.nvim",
	-- "windwp/nvim-autopairs",
	--
	-- --Tests
	-- {
	-- 	"nvim-neotest/neotest",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"antoinemadec/FixCursorHold.nvim",
	-- 		"nvim-neotest/neotest-python",
	-- 		"rouge8/neotest-rust",
	-- 		"haydenmeade/neotest-jest",
	-- 	},
	-- },
	--
	-- -- Debugging
	-- "mfussenegger/nvim-dap",
	-- "nvim-telescope/telescope-dap.nvim",
	-- "theHamsta/nvim-dap-virtual-text",
	-- "rcarriga/nvim-dap-ui",
	-- "mfussenegger/nvim-dap-python",
	--
	-- -- formatter
	-- "sbdchd/neoformat",
	--
	-- -- useful
	-- "ThePrimeagen/harpoon",
	-- "mbbill/undotree",
	-- { "lewis6991/gitsigns.nvim",
	-- 	config = function()
	-- 		require("gitsigns").setup()
	-- 	end,
	-- },
	-- "terrortylor/nvim-comment",
	-- "iamcco/markdown-preview.nvim",
	--
	-- "lukas-reineke/indent-blankline.nvim",
	-- { "kosayoda/nvim-lightbulb",
	-- 	dependencies = "antoinemadec/FixCursorHold.nvim",
	-- },
	-- {
	-- 	"folke/zen-mode.nvim",
	-- 	config = function()
	-- 		require("zen-mode").setup({ })
	-- 	end,
	-- },
	-- -- Tpope
	-- "tpope/vim-dadbod",
	--     "kristijanhusak/vim-dadbod-ui",
	--     "kristijanhusak/vim-dadbod-completion",
	-- "tpope/vim-fugitive",
	-- "tpope/vim-rhubarb",
	-- "tpope/vim-surround",
	--
	-- -- lua dev
	-- "folke/neodev.nvim",
	-- "h-hg/fcitx.nvim",
	-- --
	-- -- {
	-- -- 	"sourcegraph/sg.nvim",
	-- -- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- -- 	cmd = { "cargo", "build", "--workspace" },
	-- -- },
	-- "uga-rosa/ccc.nvim",
    -- "folke/trouble.nvim",
    -- "jose-elias-alvarez/null-ls.nvim",
	-- "stevearc/oil.nvim",
