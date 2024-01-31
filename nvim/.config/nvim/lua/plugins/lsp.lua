return {
	"neovim/nvim-lspconfig",
	config = function()
		require("neodev").setup({})

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

		local lspconfig = require("lspconfig")

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

		-- lspconfig.tsserver.setup({
		-- 	handlers = { ["textDocument/publishDiagnostics"] = diagnostics_handler, },
		-- })
		lspconfig.bashls.setup({})

		lspconfig.lua_ls.setup({
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

		lspconfig.volar.setup({
			handlers = { ["textDocument/publishDiagnostics"] = diagnostics_handler, },
			filetypes = { "typescript", "javascript", "typescript", "vue", "json" },
		})



		-- Python
		lspconfig.ruff_lsp.setup({})
		lspconfig.pyright.setup({})
		lspconfig.jedi_language_server.setup({})

		lspconfig.clangd.setup({})

		lspconfig.gopls.setup({})
		lspconfig.dockerls.setup({})
		lspconfig.docker_compose_language_service.setup({})
		lspconfig.yamlls.setup({})
		lspconfig.emmet_ls.setup({
			filetypes = {
				"css",
				"html",
				"less",
				"sass",
				"scss",
				"htmldjango",
			},
		})
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-on-attach", { clear = true }),
			callback = function(args)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
				vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition)
				vim.keymap.set("n", "rN", vim.lsp.buf.rename)
				vim.keymap.set("n", "K", vim.lsp.buf.hover)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
				vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)

				vim.keymap.set({ "i", "n" }, "<leader>ca", vim.lsp.buf.code_action)
				vim.keymap.set("n", "gr",
                    function()
                        require("telescope.builtin").lsp_references()
                   end,
                    { desc = "[G]oto [R]eferences" })
				vim.keymap.set("n", "<leader>l", vim.lsp.buf.format)

				local bufnr = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				--- @param method string
				local supports_method = function(method)
					return client.supports_method(method, { bufnr = args.buf })
				end
				function augroup(name, options)
					options = vim.F.if_nil(options, {})
					options = vim.tbl_deep_extend("force", { clear = true }, options)

					return vim.api.nvim_create_augroup(name, options)
				end

				if supports_method("textDocument/documentHighlight") then
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						group = augroup("DMunkei" .. tostring(args.buf)),
						buffer = args.buf,
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

				if client.name == "pyright" then
					client.server_capabilities.hoverProvider = false
					client.server_capabilities.renameProvider = false
					client.server_capabilities.completionProvider = false
				end

				if client.name == "jedi_language_server" then
					client.server_capabilities.definitionProvider = false
				end
			end,
		})
	end,
}
