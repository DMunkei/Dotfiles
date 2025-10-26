-- return {}
return {
	"nvim-lualine/lualine.nvim",
	enabled = true,
	order = 600,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		vim.g.kanagawa_lualine_bold = true
		-- local spinners = { "", "󰪞", "󰪟", "󰪠", "󰪡", "󰪢", "󰪣", "󰪤", "󰪥", "" }
		-- local lsp = (vim.o.columns > 100 and "   LSP ~ " .. client.name .. " ") or "   LSP "
		-- local file_icon = "󰈚"
		-- local cursor = "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon# %#St_pos_text# %l/%v "
		-- local folder_icon = "%#St_cwd_icon#" .. "󰉋 "
		local function diff_source()
			local gitsigns = vim.b.gitsigns_status_dict
			if gitsigns then
				return {
					added = gitsigns.added,
					modified = gitsigns.changed,
					removed = gitsigns.removed,
				}
			end
		end

		local theme = require("kanagawa.colors").setup().theme
		local kanagawa = {
			normal = {
				a = { bg = theme.syn.fun, fg = theme.ui.bg_p2, gui = "bold" },
				b = { bg = theme.ui.bg_p2, fg = theme.syn.fun },
				c = { bg = theme.ui.bg_p2, fg = theme.ui.fg },
			},
			insert = {
				a = { bg = theme.diag.ok, fg = theme.ui.bg_p2, gui = "bold" },
				b = { bg = theme.ui.bg_p2, fg = theme.diag.ok },
			},
			command = {
				a = { bg = theme.syn.operator, fg = theme.ui.bg_p2, gui = "bold" },
				b = { bg = theme.ui.bg_p2, fg = theme.syn.operator },
			},
			visual = {
				a = { bg = theme.syn.keyword, fg = theme.ui.bg_p2, gui = "bold" },
				b = { bg = theme.ui.bg_p2, fg = theme.syn.keyword },
			},
			replace = {
				a = { bg = theme.syn.constant, fg = theme.ui.bg_p2, gui = "bold" },
				b = { bg = theme.ui.bg_p2, fg = theme.syn.constant },
			},
			inactive = {
				a = { bg = theme.ui.bg_p2, fg = theme.ui.fg },
				b = { bg = theme.ui.bg_p2, fg = theme.ui.fg },
				c = { bg = theme.ui.bg_p2, fg = theme.ui.fg },
			},
		}

		local empty = require("lualine.component"):extend()
		function empty:draw(default_highlight)
			self.status = ""
			self.applied_separator = ""
			self:apply_highlights(default_highlight)
			self:apply_section_separators()
			return self.status
		end

		-- Put proper separators and gaps between components in sections
		local function process_sections(sections)
			for name, section in pairs(sections) do
				local left = name:sub(9, 10) < "x"

				local insert_color = { fg = theme.ui.bg, bg = theme.ui.bg }
				local limit = (name ~= "lualine_z") and #section or (#section - 1)

				local insert_pos = 2
				for idx, item in ipairs(section) do
					if idx > limit then
						break
					end
					if not item.ignore_separator then
						table.insert(section, insert_pos, { empty, color = insert_color })
						insert_pos = insert_pos + 2
					else
						insert_pos = insert_pos + 1
					end
				end
				for id, comp in ipairs(section) do
					if type(comp) ~= "table" then
						comp = { comp }
						section[id] = comp
					end
					if not comp.ignore_separator then
						comp.separator = left and { right = "" } or { left = "" }
					end
				end
			end
			return sections
		end
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = kanagawa,
				component_separators = {},
				section_separators = {},
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = false,
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 100,
					refresh_time = 16, -- ~60fps
					events = {
						"WinEnter",
						"BufEnter",
						"BufWritePost",
						"SessionLoadPost",
						"FileChangedShellPost",
						"VimResized",
						"Filetype",
						"CursorMoved",
						"CursorMovedI",
						"ModeChanged",
					},
				},
			},
			sections = process_sections({
				lualine_a = {
					{
						"mode",
					},
				},
				lualine_b = {

					{
						"filetype",
						icon_only = true,
						padding = { left = 1, right = 0 },
						ignore_separator = true,
					},
					{
						"filename",
						padding = { left = 0, right = 1 },
						symbols = {
							modified = "[+]", -- Text to show when the file is modified.
							readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
							unnamed = " [ ]", -- Text to show for unnamed buffers.
							newfile = "[N]", -- Text to show for newly created file before first write
						},
					},
					{
						"branch",
						icon = "",
					},
					{
						"diff",
						diff_color = {
							added = { bg = theme.ui.bg_p2, fg = theme.diag.ok },
							modified = { bg = theme.ui.bg_p2, fg = theme.syn.constant },
							removed = { bg = theme.ui.bg_p2, fg = theme.vcs.removed },
						},
						source = diff_source,
						symbols = { added = "+", modified = "~", removed = "-" },
					},
					{
						"diagnostics",
						update_in_insert = false,
						sections = { "error" },
						diagnostics_color = { error = { bg = theme.vcs.removed, fg = theme.ui.bg_p2, gui = "bold" } },
						symbols = { error = " " },
					},
					{
						"diagnostics",
						update_in_insert = false,
						sections = { "warn" },
						diagnostics_color = { warn = { bg = theme.diag.warning, fg = theme.ui.bg_p2, gui = "bold" } },
						symbols = { warn = " " },
					},
					{
						"diagnostics",
						update_in_insert = false,
						sections = { "hint" },
						diagnostics_color = { hint = { bg = theme.diag.hint, fg = theme.ui.bg_p2, gui = "bold" } },
						symbols = { hint = "󰛩 " },
					},
					{
						"diagnostics",
						update_in_insert = false,
						sections = { "info" },
						diagnostics_color = { info = { bg = theme.diag.info, fg = theme.ui.bg_p2, gui = "bold" } },
						symbols = { info = "󰋼 " },
					},
				},
				lualine_c = {},
				lualine_x = {
					{
						"fileformat",
						cond = function()
							return false
						end,
					},
				},
				lualine_y = {
					{
						"selectioncount",
					},
					{
						"searchcount",
						maxcount = 999,
						timeout = 500,
					},
					{
						"lsp_status",
						icon = "", -- f013
						symbols = {
							-- Standard unicode symbols to cycle through for LSP progress:
							spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
							-- Standard unicode symbol for when LSP is done:
							done = "",
							-- Delimiter inserted between LSP names:
							separator = " ",
						},
						padding = { left = 0, right = 1 },
						-- List of LSP names to ignore (e.g., `null-ls`):
						ignore_lsp = {},
					},
					{
						"progress",
					},
				},
				lualine_z = { "location" },
			}),
			inactive_sections = process_sections({
				lualine_a = {
					{
						"filetype",
						icon_only = true,
						padding = { left = 1, right = 0 },
						ignore_separator = true,
					},
					{
						"filename",
						padding = { left = 0, right = 1 },
						symbols = {
							modified = "[+]", -- Text to show when the file is modified.
							readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
							unnamed = " [ ]", -- Text to show for unnamed buffers.
							newfile = "[N]", -- Text to show for newly created file before first write
						},
					},
				},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {
					{
						"fileformat",
						cond = function()
							return false
						end,
					},
				},
				lualine_y = {},
				lualine_z = { "location" },
			}),
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
