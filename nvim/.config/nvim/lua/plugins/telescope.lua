return {
	"nvim-telescope/telescope.nvim",

	dependencies = { "nvim-lua/plenary.nvim" ,  "BurntSushi/ripgrep" },
	
	config = function()
		require("telescope").setup {
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown()
				}
			},
			defaults = {
				preview = {
					treesitter = {
						disable = {
							"css",
							"javascript",
						},
					},
				},
			}
		}
		require("telescope").load_extension("ui-select")

        vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
        vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
        vim.keymap.set('n', '<leader>/', function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = '[/] Fuzzily search in current buffer' })

        vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>S', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, {desc =  'Type [D]efinition'})
        vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, {desc=  '[D]ocument [S]ymbols'})
        vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, {desc =  '[W]orkspace [S]ymbols'})
	end,
}