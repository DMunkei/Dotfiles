return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		vim.diagnostic.config({
			update_in_insert = false,
			float = {
				border = "single",
				style = "minimal",
			},
		})

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "single",
			style = "minimal",
			title = "Knowledge Bitch",
		})

		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = "single",
			style = "minimal",
		})

		require("lspconfig.ui.windows").default_options = {
			border = "single",
		}

		local function diagnostics_handler(err, result, ctx)
			if err ~= nil then
				error("Failed to request diagnostics: " .. vim.inspect(err))
			end

			if result == nil then
				return
			end

			local buffer = vim.uri_to_bufnr(result.uri)
			local namespace = vim.lsp.diagnostic.get_namespace(ctx.client_id)

			local diagnostics = vim.tbl_map(function(diagnostic)
				local resultLines = vim.split(diagnostic.message, "\n")
				local output = vim.fn.reverse(resultLines)
				return {
					bufnr = buffer,
					lnum = diagnostic.range.start.line,
					end_lnum = diagnostic.range["end"].line,
					col = diagnostic.range.start.character,
					end_col = diagnostic.range["end"].character,
					severity = diagnostic.severity,
					message = table.concat(output, "\n\n"),
					source = diagnostic.source,
					code = diagnostic.code,
				}
			end, result.diagnostics)

			vim.diagnostic.set(namespace, buffer, diagnostics)
		end

    local builtin = require('telescope.builtin')
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-on-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, silent = true, desc = "LSP: " .. desc })
				end
				map("<leader>l", function()
					require("conform").format({ async = true, lsp_fallback = true, bufnr = event.buf })
				end, "Format buffer")
				map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
				map("gr", builtin.lsp_references, "[G]oto [R]eferences")
				map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds",builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws",builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)

				local bufnr = event.buf
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				--- @param method string
				local supports_method = function(method)
					return client.supports_method(method, { bufnr = event.buf })
				end
				function augroup(name, options)
					options = vim.F.if_nil(options, {})
					options = vim.tbl_deep_extend("force", { clear = true }, options)

					return vim.api.nvim_create_augroup(name, options)
				end

				if supports_method("textDocument/documentHighlight") then
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						group = augroup("DMunkei" .. tostring(event.buf)),
						buffer = event.buf,
						callback = function(event)
							local ok, treesitter = pcall(require, "nvim-treesitter.ts_utils")
							if not ok then
								return
							end

							local current_node = treesitter.get_node_at_cursor()

							if not current_node then
								vim.lsp.buf.clear_references()
								return
							end

							local node_text = vim.treesitter.get_node_text(current_node, event.buf)

							if CURRENT_NODE == node_text then
								return
							end

							CURRENT_NODE = node_text
							vim.lsp.buf.clear_references()

							local node_type = current_node:type()

							if node_type == "identifier" or node_type == "property_identifier" then
								vim.lsp.buf.document_highlight()
							end
						end,
					})
				end

				if client.name == "rust" then
					local rt = require("rust-tools")
					-- Hover actions
					vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
					-- Code action groups
					vim.keymap.set("n", "<Leader>A", rt.code_action_group.code_action_group, { buffer = bufnr })
				end

				-- In here you can run any setup code you want to apply to all your language servers.
				-- For server specific setups, see `on_attach` for lspconfig

				if client.name == "ruff_lsp" then
					client.server_capabilities.hoverProvider = false
				end

				if client.name == "typescript-tools" then
					client.server_capabilities.diagnosticsProvider = false
				end

				if client.name == "pyright" then
					client.server_capabilities.hoverProvider = false
					client.server_capabilities.renameProvider = false
					client.server_capabilities.completionProvider = false
				end

				if client.name == "jedi_language_server" then
					client.server_capabilities.definitionProvider = false
				end

				local caps = cmp_nvim_lsp.default_capabilities()
				mason_lspconfig.setup_handlers({
					function(server_name)
						lspconfig[server_name].setup({
							capabilities = caps,
						})
					end,
					["lua_ls"] = function()
						lspconfig["lua_ls"].setup({
							capabilities = caps,
							settings = {
								Lua = {
									completion = {
										callSnippet = "Replace",
									},
									diagnostics = {
										globals = { "vim", "use", "app", "api" },
										disable = { "lowercase-global" },
									},
								},
							},
						})
					end,
					["volar"] = function()
						lspconfig["volar"].setup({
							capabilities = caps,
							handlers = { ["textDocument/publishDiagnostics"] = diagnostics_handler },
							filetypes = { "typescript", "javascript", "typescript", "vue", "json" },
						})
					end,
					["emmet_ls"] = function()
						lspconfig["emmet_ls"].setup({
							capabilities = caps,
							filetypes = {
								"css",
								"html",
								"less",
								"sass",
								"scss",
								"htmldjango",
							},
						})
					end,
					-- lspconfig.tsserver.setup({
					-- 	handlers = { ["textDocument/publishDiagnostics"] = diagnostics_handler, },
					-- })
				})
			end,
		})
	end,
}
