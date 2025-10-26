return {
	cmd = { "bash-language-server", "start" },
	filetypes = { "bash", "sh" },
	root_markers = { ".git" },
	single_file_support = true,
	settings = {
		bashIde = {
			globPattern = "*@(.sh|.inc|.bash|.command)",
		},
	},
}
