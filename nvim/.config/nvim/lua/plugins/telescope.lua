return {
    "nvim-telescope/telescope.nvim",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "BurntSushi/ripgrep",
        {
            "nvim-telescope/telescope-live-grep-args.nvim",
            -- This will not install any breaking changes.
            -- For major updates, this must be adjusted manually.
            version = "^1.0.0",
        }
    },
    config = function()
        local lga_actions = require("telescope-live-grep-args.actions")
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
                i = {
                    ["<C-k>"] = lga_actions.quote_prompt(),
                    ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                },
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
        require("telescope").load_extension("live_grep_args")

        vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles,
            { desc = '[?] Find recently opened files' })
        vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers,
            { desc = '[ ] Find existing buffers' })
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
        vim.keymap.set('n', '<leader>S',  require('telescope.builtin').live_grep, { desc = '[S]earch by Grep' })
        vim.keymap.set("n", "<leader>sg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
        vim.keymap.set("n", "<leader>gc", require('telescope-live-grep-args.shortcuts').grep_word_under_cursor, {desc = "[G]rab [C]ursor"})
        vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'Type [D]efinition' })
        vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols,
            { desc = '[D]ocument [S]ymbols' })
        vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
            { desc = '[W]orkspace [S]ymbols' })
    end,
}
