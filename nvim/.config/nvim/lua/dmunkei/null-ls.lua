local null_ls = require("null-ls")
local linting = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local actions = null_ls.builtins.code_actions
null_ls.setup({
    sources = {
        formatting.stylua,
        formatting.prettier.with({
            extra_args = {'--tab-width=4'}
        }),

        -- linting.gdlint,
        linting.eslint_d,
        linting.flake8.with({

            extra_args = {"--max-line-length=200", "--ignore=E701"}
        }),
        linting.markdownlint,

        actions.eslint_d,
    }
})
