return {
    "nvim-telescope/telescope.nvim",
  event = 'VimEnter',
  branch = '0.1.x',
    dependencies = {
        "nvim-lua/plenary.nvim",
        "BurntSushi/ripgrep",
    },
    config = function()
        require("telescope").setup {
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown()
                },
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                }
            },
            mappings = { -- extend mappings
            },
            file_ignore_patterns = {
                "^node_modules/",
                "^dist/",
                "^.git/",
                "^.direnv/",
                "^.sqlx/",
                "^zsh/plugins/",
                "^desktop/icons/",
                "%.png",
                "%.jpg",
                "%.jpeg",
                "%.svg",
                "%.ttf",
                "%.otf",
                "%.lock",
                "%-lock.json",
                "%.wasm",
                "%.xml",
                "%.css",
                "%.tmTheme",
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
        require("telescope").load_extension("fzf")

        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', "<leader>ft", "<CMD>TodoTelescope<cr>", {desc = "FindTodos"})
        vim.keymap.set('n', '<leader>?', builtin.oldfiles,
            { desc = '[?] Find recently opened files' })
        vim.keymap.set('n', '<leader><space>', builtin.buffers,
            { desc = '[ ] Find existing buffers' })
        vim.keymap.set('n', '<leader>/', function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = '[/] Fuzzily search in current buffer' })

        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>s/',  builtin.live_grep, { desc = '[S]earch by Grep' })
        vim.keymap.set("n", "<leader>sg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'Type [D]efinition' })
        vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols,
            { desc = '[D]ocument [S]ymbols' })
        -- vim.keymap.set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols,
        --     { desc = '[W]orkspace [S]ymbols' })
    --     -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>f', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
    end,
}
