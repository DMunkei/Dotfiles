local lsp_keymaps = require'dmunkei.lsp_keymaps'
local nvim_lsp = require'lspconfig'
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
local servers = {
    "pylsp", "jedi_language_server", "vuels", "tsserver", "vimls",
    "html", "cssls", "emmet_ls", "clangd", "rust_analyzer" , "bashls"
}
  -- Set up lspconfig.
for _, server in ipairs(servers) do
    nvim_lsp[server].setup{
        on_attach = lsp_keymaps.attach,
        capabilities = capabilities
    }
end

require("dmunkei.custom_server.rust")
require("dmunkei.custom_server.sumneko")
