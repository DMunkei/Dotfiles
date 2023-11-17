return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = {"BufReadPre", "BufNewFile"},
	dependencies = {
 		"p00f/nvim-ts-rainbow",
 		"nvim-treesitter/nvim-treesitter-context",
 		"nvim-treesitter/nvim-treesitter-textobjects",
 	},
    config = function()
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup ({
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "python",
                "javascript",
                "markdown",
                "html",
                "yaml",
                "json",
                "lua",
                "css",
                "bash",
                "sql",
                "vim",
            },
            enabled = false,
            sync_install = false,
            playground = { enable=true },
            textobjects = {
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<c-space>',
                        node_incremental = '<c-space>',
                        scope_incremental = '<c-s>',
                        node_decremental = '<M-space>',
                    },
                },
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ['aa'] = '@parameter.outer',
                        ['ia'] = '@parameter.inner',
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        [']m'] = '@function.outer',
                        [']]'] = '@class.outer',
                    },
                    goto_next_end = {
                        [']M'] = '@function.outer',
                        [']['] = '@class.outer',
                    },
                    goto_previous_start = {
                        ['[m'] = '@function.outer',
                        ['[['] = '@class.outer',
                    },
                    goto_previous_end = {
                        ['[M'] = '@function.outer',
                        ['[]'] = '@class.outer',
                    },
                }
            }
        })
         end,
}
