local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-on-attach", { clear = true }),

	callback = function(event)
		local fzflua = require("fzf-lua")
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end
		map("gD", fzflua.lsp_declarations, "[G]oto [D]eclaration")
		map("gd", fzflua.lsp_definitions, "[G]oto [D]efinition")
		map("gr", fzflua.lsp_references, "[G]oto [R]eferences")
		map("gI", fzflua.lsp_implementations, "[G]oto [I]mplementation")
		map("<leader>D", fzflua.lsp_typedefs, "Type [D]definition")
		map("<leader>ds", fzflua.lsp_document_symbols, "[D]ocument [S]symbols")
		map("<leader>Ws", fzflua.lsp_live_workspace_symbols, "[W]orkspace [S]ssymbols")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		vim.keymap.set("n", "<leader>rn", function()
			return ":IncRename " .. vim.fn.expand("<cword>")
		end, { expr = true })

		map("K", vim.lsp.buf.hover, "Hover Documentation")
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
		vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)

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
		-- if client.server_capabilities.inlayHintProvider then
		-- 	vim.lsp.inlay_hint.enable(true)
		-- end
		if supports_method("textDocument/documentSymbolProvider") then
			if
				client.name == "ruff"
				or client.name == "basedpyright"
				or client.name == "ty"
				or client.name == "pylsp"
			then
				return
			end
			require("nvim-navic").attach(client, event.buf)
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
		if client == nil then
			return
		end

		if client.name == "ruff" then
			client.server_capabilities.hoverProvider = false
			client.server_capabilities.documentSymbolsProvider = false
		end

		if client.name == "basedpyright" then
			-- client.server_capabilities.renameProvider = false
			client.server_capabilities.definitionProvider = false
			client.server_capabilities.documentSymbolsProvider = false
			client.server_capabilities.documentSymbolProvider = false
		end

		if client.name == "ty" then
			client.server_capabilities.codeActionProvider = true
			client.server_capabilities.declarationProvider = false
			client.server_capabilities.definitionProvider = false
			client.server_capabilities.completionProvider = false
			client.server_capabilities.referencesProvider = false
		end

		if client.name == "pylsp" then
			client.server_capabilities.codeActionProvider = true
			client.server_capabilities.declarationProvider = false
			client.server_capabilities.definitionProvider = false
			client.server_capabilities.completionProvider = false
			client.server_capabilities.referencesProvider = false
		end

		if client.name == "jedi-language-server" then
			client.server_capabilities.codeActionProvider = false
			client.server_capabilities.declarationProvider = false
			client.server_capabilities.definitionProvider = false
			client.server_capabilities.completionProvider = false
			client.server_capabilities.referencesProvider = false
		end
	end,
})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		-- try_lint without arguments runs the linters defined in `linters_by_ft`
		-- for the current filetype
		require("lint").try_lint()

		-- You can call `try_lint` with a linter name or a list of names to always
		-- run specific linters, independent of the `linters_by_ft` configuration
		-- require("lint").try_lint("mypy")
	end,
})
