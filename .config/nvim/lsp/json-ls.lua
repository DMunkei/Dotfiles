local ok, blink = pcall(require, "blink.cmp")
if not ok then
	return {}
end
local capabilities = blink.get_lsp_capabilities()
return {
	capabilities = capabilities,
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	schemas = require("schemastore").json.schemas(),
	validate = { enable = true },
	init_options = {
		provideFormatter = true,
	},
	single_file_support = true,
	root_markers = function(fname)
		return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
	end,
}
