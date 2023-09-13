return {
	"stevearc/oil.nvim",

	priority = 1000,
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			columns = { "icon", "size" },
			-- Window-local options to use for oil buffers
			win_options = {
				wrap = false,
				signcolumn = "no",
				cursorcolumn = false,
				foldcolumn = "0",
				spell = false,
				list = false,
				conceallevel = 3,
				concealcursor = "n",
			},
			-- Restore window options to previous values when leaving an oil buffer
			restore_win_options = true,
			-- Skip the confirmation popup for simple operations
			skip_confirm_for_simple_edits = false,
			-- Selecting a new/moved/renamed file or directory will prompt you to save changes first
			prompt_save_on_select_new_entry = true,
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-s>"] = "actions.select_vsplit",
				["<C-h>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-l>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["g."] = "actions.toggle_hidden",
			},
			-- Set to false to disable all of the above keymaps
			use_default_keymaps = true,
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = true,
				-- This function defines what is considered a "hidden" file
				is_hidden_file = function(name, bufnr)
					return vim.startswith(name, ".")
				end,
				-- This function defines what will never be shown, even when `show_hidden` is set
				is_always_hidden = function(name, bufnr)
					return false
				end,
			},
		})
		vim.keymap.set("n", "<Leader>e", "<cmd>Oil<cr>")
	end,
}
