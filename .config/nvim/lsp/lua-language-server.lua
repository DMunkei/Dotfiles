local ok, blink = pcall(require, "blink.cmp")
if not ok then
	return {}
end
local capabilities = blink.get_lsp_capabilities()
return {
	capabilities = capabilities,
	cmd = { "lua-language-server" },
	root_markers = {
		".luarc.json",
		".luarc.jsonc",
		".luacheckrc",
		".stylua.toml",
		"stylua.toml",
		"selene.toml",
		"selene.yml",
		".git",
	},
	filetypes = { "lua" },
	settings = {
		Lua = {
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
			runtime = { version = "LuaJIT" },
			completion = {
				callSnippet = "Replace",
			},
			diagnostics = {
				globals = { "vim", "use", "app", "api" },
				disable = { "lowercase-global" },
			},
		},
	},
}
