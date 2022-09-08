local Remap = require("dmunkei.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

local status_ok, lsp_config = pcall(require, 'lspconfig')
if not status_ok then
    vim.inspect("fuck")
end

-- Need to figure out how to make this get passed to ALL of my LSP clients.
--`local function config(_config)
--`    return vim.tbl_deep_extend("force", {
--`    on_attach = function()--This is a on_attach signal/event that is being done whenever a .py file is loaded in the buffer
--`        nnoremap("gd", function() vim.lsp.buf.definition() end)
--`        nnoremap("gT", function() vim.lsp.buf.type_definition() end)
--`        nnoremap("gi", function() vim.lsp.buf.implementation() end)
--`        nnoremap("K", function() vim.lsp.buf.hover() end)
--`        nnoremap("<leader>df", function() vim.diagnostics.goto_next() end)
--`        nnoremap("<leader>rn", function() vim.lsp.buf.rename() end)
--`        nnoremap("<leader>rr", function() vim.lsp.buf.references() end)
--`        nnoremap("<leader>ws", function() vim.lsp.buf.workspace_symbol() end)
--`        inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
--`    end,
--`}, _config or {})
--`end

-- Setup nvim-cmp.
local cmp = require("cmp")
local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	path = "[Path]",
}

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)-- For `luasnip` user.
		end,
	},
	mapping = cmp.mapping.preset.insert({
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
	}),

	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },-- For luasnip user.
		{ name = "buffer" },
	},
})
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
lsp_config.pyright.setup{
    capabilities = capabilities,
    on_attach = function()--This is a on_attach signal/event that is being done whenever a .py file is loaded in the buffer
        nnoremap("K", function() vim.lsp.buf.hover() end)
        nnoremap("gd", function() vim.lsp.buf.definition() end)
        nnoremap("gT", function() vim.lsp.buf.type_definition() end)
        nnoremap("gi", function() vim.lsp.buf.implementation() end)
        nnoremap("<leader>dn", function() vim.diagnostic.goto_next() end)
        nnoremap("<leader>dp", function() vim.diagnostic.goto_prev() end)
        nnoremap("<leader>r", function() vim.lsp.buf.rename() end)
        nnoremap("<leader>rr", function() vim.lsp.buf.references() end)
        nnoremap("<leader>ws", function() vim.lsp.buf.workspace_symbol() end)
        inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
    end,
} 
