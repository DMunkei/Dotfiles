require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "sumneko_lua", "rust_analyzer" }
})
-- After setting up mason-lspconfig you may set up servers via lspconfig
require("lspconfig").sumneko_lua.setup {}
require("lspconfig").rust_analyzer.setup {}
-- ...
