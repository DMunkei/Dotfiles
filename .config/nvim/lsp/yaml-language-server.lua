local ok, blink = pcall(require, "blink.cmp")
if not ok then
	return {}
end
local capabilities = blink.get_lsp_capabilities()
return {
	capabilities = capabilities,
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
	root_markers = function(fname)
		return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
	end,
	settings = {
		schemaStore = {
			enable = false,
			url = "",
		},
		schemas = require("schemastore").yaml.schemas(),
		redhat = {
			telemetry = {
				enabled = false,
			},
		},
	},
}
