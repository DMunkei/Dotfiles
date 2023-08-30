-- Setting up neodev
-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
})

local lspconfig = require'lspconfig'
local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" , title = "Knowledge Bitch"})
capabilities.textDocument.completion.completionItem.snippetSupport = true
local servers = {
    "pyright", "jedi_language_server", "vuels", "tsserver", "vimls",
    "html", "cssls", "emmet_ls", "clangd", "rust_analyzer" , "bashls",
    "kotlin_language_server",
}
  -- Set up lspconfig.
for _, server in ipairs(servers) do
    if server == "emmet_ls" then
            lspconfig[server].setup{
                capabilities = capabilities,
                filetypes = {
                    "css",
                    "html",
                    "less",
                    "sass",
                    "scss",
                    "htmldjango",
                },
            }
    end
    lspconfig[server].setup{
        capabilities = capabilities
    }
end

lspconfig.gdscript.setup{
    cmd = vim.lsp.rpc.connect("127.0.0.1", 6005)

}
require("dmunkei.custom_server.rust")
require("dmunkei.custom_server.lua_ls")

