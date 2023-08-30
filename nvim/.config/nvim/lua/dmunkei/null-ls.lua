local null_ls = require("null-ls")
local linting = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local actions = null_ls.builtins.code_actions
null_ls.setup({
    sources = {
        formatting.stylua,
        formatting.eslint_d,
        -- formatting.prettier.with({
        --     extra_args = {'--tab-width=4'}
        -- }),
        -- linting.gdlint,
        actions.eslint_d,
        linting.eslint_d,
        linting.flake8.with({

            extra_args = {"--max-line-length=200", "--ignore=E701"}
        }),
        linting.markdownlint,
    }
})
