local lspconfig = require("lspconfig")
-- local attach  = require('dmunkei.lsp_keymaps').attach

lspconfig.lua_ls.setup({
    on_attach = attach,
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace"

            },
            diagnostics = {
                globals = {"vim", "use", "app"},
                disable = {"lowercase-global"}
            },
        },
    },
})
