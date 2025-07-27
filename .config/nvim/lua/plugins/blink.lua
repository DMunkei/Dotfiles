return {
	{
		"saghen/blink.compat",
		version = "*",
		lazy = true,
		opts = {},
	},
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets", "onsails/lspkind.nvim", "moyiz/blink-emoji.nvim" },
		version = "1.*",
		opts = {
			cmdline = {
				keymap = {
					preset = "enter",
					["<Tab>"] = { "snippet_forward", "fallback" },
					["<CR>"] = { "accept_and_enter", "fallback" },
					menu = {
						completion = { auto_show = true },
					},
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "emoji", "sql" },
				min_keyword_length = function(ctx)
					-- only applies when typing a command, doesn't apply to arguments
					if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
						return 2
					end
					return 0
				end,
				providers = {
					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						score_offset = 15, -- Tune by preference
						opts = { insert = true }, -- Insert emoji (default) or complete its name
						should_show_items = function()
							return vim.tbl_contains(
								-- Enable emoji completion only for git commits and markdown.
								-- By default, enabled for all file-types.
								{ "gitcommit", "markdown" },
								vim.o.filetype
							)
						end,
					},
					sql = {
						module = "blink.compat.source",
						name = "sql",
						score_offset = -3, -- Tune by preference
						opts = {}, -- Insert emoji (default) or complete its name
						should_show_items = function()
							return vim.tbl_contains(
								-- Enable emoji completion only for git commits and markdown.
								-- By default, enabled for all file-types.
								{ "sql" },
								vim.o.filetype
							)
						end,
					},
				},
			},

			keymap = {
				preset = "default",
				["<C-l>"] = { "snippet_forward", "fallback" },
				["<C-j>"] = { "snippet_backward", "fallback" },
				["<Tab>"] = {},
				["<S-Tab>"] = {},
			},
			completion = {
				menu = {
					draw = {
						components = {

							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
							kind_icon = {
								text = function(ctx)
									local lspkind = require("lspkind")
									local icon = ctx.kind_icon
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											icon = dev_icon
										end
									else
										icon = lspkind.symbolic(ctx.kind, {
											mode = "symbol",
										})
									end

									return icon .. ctx.icon_gap
								end,

								-- Optionally, use the highlight groups from nvim-web-devicons
								-- You can also add the same function for `kind.highlight` if you want to
								-- keep the highlight groups in sync with the icons.
								highlight = function(ctx)
									local hl = ctx.kind_hl
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											hl = dev_hl
										end
									end
									return hl
								end,
							},
						},
					},
				},
				list = { selection = { auto_insert = true } },
			},
			fuzzy = {
				sorts = {
					"exact",
					-- defaults
					"score",
					"sort_text",
				},
			},
			signature = { enabled = true, window = { border = "rounded" } },
		},
	},
}
