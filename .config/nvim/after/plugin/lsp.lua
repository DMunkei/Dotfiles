local Remap = require("dmunkei.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

local status_ok, lsp_config = pcall(require, 'lspconfig')
if not status_ok then
    vim.inspect("fuck")
end

local lspkind = require('lspkind')


--Need to figure out how to make this get passed to ALL of my LSP clients.
local function config(_config)
    return vim.tbl_deep_extend("force", 
    {
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = function()--This is a on_attach signal/event that is being invoked whenever a .py file is loaded in the buffer
            nnoremap("gd", function() vim.lsp.buf.definition() end)
            nnoremap("gT", function() vim.lsp.buf.type_definition() end)
            nnoremap("gi", function() vim.lsp.buf.implementation() end)
            nnoremap("K", function() vim.lsp.buf.hover() end)
            nnoremap("<leader>df", function() vim.diagnostic.goto_next() end)
            nnoremap("<leader>dp", function() vim.diagnostic.goto_prev() end)
            nnoremap("<leader>rn", function() vim.lsp.buf.rename() end)
            nnoremap("<leader>rr", function() vim.lsp.buf.references() end)
            nnoremap("<leader>ws", function() vim.lsp.buf.workspace_symbol() end)
            inoremap("<C-k>", function() vim.lsp.buf.signature_help() end)
            nnoremap("<leader>ca", function() vim.lsp.buf.code_action() end)
            nnoremap("<leader>co", function() vim.lsp.buf.code_action({
                filter = function(code_action)
                    if not code_action or not code_action.data then
                        return false
                    end

                    local data = code_action.data.id
                    return string.sub(data, #data - 1, #data) == ":0"
                end,
                apply = true
            }) end)
        end,
    },
    _config or {})
end

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
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','s'}),
        ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','s'}),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            vim_item.menu = menu
            return vim_item
        end,
    },
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },-- For luasnip user.
		{ name = "buffer" },
	},
})
lsp_config.pyright.setup(config())
