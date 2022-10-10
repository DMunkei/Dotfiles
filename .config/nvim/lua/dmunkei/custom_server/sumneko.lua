local lspconfig = require("lspconfig")
local attach  = require('dmunkei.lsp_keymaps').attach

lspconfig.sumneko_lua.setup({
    on_attach = attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = {"vim", "use"},
                disable = {"lowercase-global"}
            },
        },
    },
})
