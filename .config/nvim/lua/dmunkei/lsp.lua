local lsp_keymaps = require'dmunkei.lsp_keymaps'
local nvim_lsp = require'lspconfig'
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
local servers = {
    "pylsp", "jedi_language_server",  "vuels", "tsserver", "vimls", "html", "cssls", "emmet_ls", "clangd",
    "rust_analyzer"
}
  -- Set up lspconfig.
for _, server in ipairs(servers) do
    nvim_lsp[server].setup{
        on_attach = lsp_keymaps.attach,
        capabilities = capabilities
    }
end

nvim_lsp.sumneko_lua.setup({
    on_attach = lsp_keymaps.attach,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

nvim_lsp.volar.setup{
    on_attach = lsp_keymaps.attach,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    init_options = {
        typescript = {
            serverpath= '/usr/lib/node_modules/typescript/lib/tsserverlibrary.js'
        }
    }
}
