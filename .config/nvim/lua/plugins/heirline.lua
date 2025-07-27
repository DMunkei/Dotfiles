return {
	"rebelot/heirline.nvim",
	-- You can optionally lazy-load heirline on UiEnter
	-- to make sure all required plugins and colorschemes are loaded before setup
	event = "UiEnter",
	dependencies = { "SmiteshP/nvim-navic" },
	config = function()
		local Space = { provider = " " }
		local Align = { provider = "%=" }
		local M = {}
		M.icons = {
			-- ✗   󰅖 󰅘 󰅚 󰅙 󱎘 
			close = "󰅙 ",
			dir = "󰉋 ",
			lsp = " ", --   
			vim = " ", --      
			debug = " ",
			rec = " ",
			modified = "● ",
			readonly = " ",
			terminal = "  ",

			err = "",
			warn = "",
			info = "󰋇",
			hint = "󰌵",
		}

		local function blend(color1, color2, alpha)
			color1 = type(color1) == "number" and string.format("#%06x", color1) or color1
			color2 = type(color2) == "number" and string.format("#%06x", color2) or color2
			local r1, g1, b1 = color1:match("#(%x%x)(%x%x)(%x%x)")
			local r2, g2, b2 = color2:match("#(%x%x)(%x%x)(%x%x)")
			local r = tonumber(r1, 16) * alpha + tonumber(r2, 16) * (1 - alpha)
			local g = tonumber(g1, 16) * alpha + tonumber(g2, 16) * (1 - alpha)
			local b = tonumber(b1, 16) * alpha + tonumber(b2, 16) * (1 - alpha)
			return "#"
				.. string.format("%02x", math.min(255, math.max(r, 0)))
				.. string.format("%02x", math.min(255, math.max(g, 0)))
				.. string.format("%02x", math.min(255, math.max(b, 0)))
		end

		function M.dim(color, n)
			return blend(color, "#000000", n)
		end

		M.separators = {
			rounded_left = "",
			rounded_right = "",
			rounded_left_hollow = "",
			rounded_right_hollow = "",
			powerline_left = "",
			powerline_right = "",
			powerline_right_hollow = "",
			powerline_left_hollow = "",
			slant_left = "",
			slant_right = "",
			inverted_slant_left = " ",
			inverted_slant_right = "",
			slant_ur = "",
			slant_br = "",
			vert = "│",
			vert_thick = "┃",
			block = "█",
			double_vert = "║",
			dotted_vert = "┊",
		}

		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")
		local function setup_colors()
			return {
				bright_bg = utils.get_highlight("Folded").bg,
				bright_fg = utils.get_highlight("Folded").fg,
				red = utils.get_highlight("DiagnosticError").fg,
				dark_red = utils.get_highlight("DiffDelete").bg,
				green = utils.get_highlight("String").fg,
				blue = utils.get_highlight("Function").fg,
				gray = utils.get_highlight("NonText").fg,
				orange = utils.get_highlight("Constant").fg,
				purple = utils.get_highlight("Statement").fg,
				cyan = utils.get_highlight("Special").fg,
				directory = utils.get_highlight("Directory").fg,
				diag_warn = utils.get_highlight("DiagnosticWarn").fg,
				diag_error = utils.get_highlight("DiagnosticError").fg,
				diag_hint = utils.get_highlight("DiagnosticHint").fg,
				diag_info = utils.get_highlight("DiagnosticInfo").fg,
				git_add = utils.get_highlight("DiffAdded").fg,
				git_del = utils.get_highlight("DiffDeleted").fg,
				git_change = utils.get_highlight("DiffChanged").fg,
			}
		end
		local FileNameBlock = {
			-- let's first set up some attributes needed by this component and its children
			init = function(self)
				self.filename = vim.api.nvim_buf_get_name(0)
			end,
		}
		-- We can now define some children separately and add them later

		local FileIcon = {
			init = function(self)
				local filename = self.filename
				local extension = vim.fn.fnamemodify(filename, ":e")
				self.icon, self.icon_color =
					require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
			end,
			provider = function(self)
				return self.icon and (self.icon .. " ")
			end,
			hl = function(self)
				return { fg = self.icon_color }
			end,
		}

		local FileName = {
			provider = function(self)
				-- first, trim the pattern relative to the current directory. For other
				-- options, see :h filename-modifers
				local filename = vim.fn.fnamemodify(self.filename, ":.")
				if filename == "" then
					return "[No Name]"
				end
				-- now, if the filename would occupy more than 1/4th of the available
				-- space, we trim the file path to its initials
				-- See Flexible Components section below for dynamic truncation
				if not conditions.width_percent_below(#filename, 0.25) then
					filename = vim.fn.pathshorten(filename)
				end
				return filename
			end,
			hl = { fg = utils.get_highlight("Directory").fg, bold = true },
		}

		local FileFlags = {
			{
				condition = function()
					return vim.bo.modified
				end,
				provider = "[+]",
				hl = { fg = "green" },
			},
			{
				condition = function()
					return not vim.bo.modifiable or vim.bo.readonly
				end,
				provider = "",
				hl = { fg = "orange" },
			},
		}

		-- Now, let's say that we want the filename color to change if the buffer is
		-- modified. Of course, we could do that directly using the FileName.hl field,
		-- but we'll see how easy it is to alter existing components using a "modifier"
		-- component

		local FileNameModifer = {
			hl = function()
				if vim.bo.modified then
					-- use `force` because we need to override the child's hl foreground
					return { fg = "cyan", bold = true, force = true }
				end
			end,
		}

		-- let's add the children to our FileNameBlock component
		FileNameBlock = utils.insert(
			FileNameBlock,
			utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
			FileFlags,
			{ provider = "%<" } -- this means that the statusline is cut here when there's not enough space
		)

		local ViMode = {

			-- get vim current mode, this information will be required by the provider
			-- and the highlight functions, so we compute it only once per component
			-- evaluation and store it as a component attribute
			init = function(self)
				self.mode = vim.fn.mode(1) -- :h mode()
			end,
			-- Now we define some dictionaries to map the output of mode() to the
			-- corresponding string and color. We can put these into `static` to compute
			-- them at initialisation time.
			static = {
				mode_names = { -- change the strings if you like it vvvvverbose!
					n = "N",
					no = "N?",
					nov = "N?",
					noV = "N?",
					["no\22"] = "N?",
					niI = "Ni",
					niR = "Nr",
					niV = "Nv",
					nt = "Nt",
					v = "V",
					vs = "Vs",
					V = "V_",
					Vs = "Vs",
					["\22"] = "^V",
					["\22s"] = "^V",
					s = "S",
					S = "S_",
					["\19"] = "^S",
					i = "I",
					ic = "Ic",
					ix = "Ix",
					R = "R",
					Rc = "Rc",
					Rx = "Rx",
					Rv = "Rv",
					Rvc = "Rv",
					Rvx = "Rv",
					c = "C",
					cv = "Ex",
					r = "...",
					rm = "M",
					["r?"] = "?",
					["!"] = "!",
					t = "T",
				},
				mode_colors = {
					n = "pink",
					i = "green",
					v = "cyan",
					V = "cyan",
					["\22"] = "cyan",
					c = "orange",
					s = "purple",
					S = "purple",
					["\19"] = "purple",
					R = "orange",
					r = "orange",
					["!"] = "red",
					t = "red",
				},
				mode_color = function(self)
					local mode = conditions.is_active() and vim.fn.mode() or "n"
					return self.mode_colors[mode]
				end,
			},
			-- We can now access the value of mode() that, by now, would have been
			-- computed by `init()` and use it to index our strings dictionary.
			-- note how `static` fields become just regular attributes once the
			-- component is instantiated.
			-- To be extra meticulous, we can also add some vim statusline syntax to
			-- control the padding and make sure our string is always at least 2
			-- characters long. Plus a nice Icon.
			provider = function(self)
				return " %2(" .. self.mode_names[self.mode] .. "%)"
			end,
			-- Same goes for the highlight. Now the foreground will change according to the current mode.
			hl = function(self)
				local mode = self.mode:sub(1, 1) -- get only the first mode character
				return { fg = self.mode_colors[mode], bold = true }
			end,
			-- Re-evaluate the component only on ModeChanged event!
			-- Also allows the statusline to be re-evaluated when entering operator-pending mode
			update = {
				"ModeChanged",
				pattern = "*:*",
				callback = vim.schedule_wrap(function()
					vim.cmd("redrawstatus")
				end),
			},
		}
		local FileType = {
			provider = function()
				return string.upper(vim.bo.filetype)
			end,
			hl = { fg = utils.get_highlight("Type").fg, bold = true },
		}
		local FileEncoding = {
			provider = function()
				local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
				return enc ~= "utf-8" and enc:upper()
			end,
		}
		local FileFormat = {
			provider = function()
				local fmt = vim.bo.fileformat
				return fmt ~= "unix" and fmt:upper()
			end,
		}
		-- We're getting minimalist here!
		local Ruler = {
			-- %l = current line number
			-- %L = number of lines in the buffer
			-- %c = column number
			-- %P = percentage through file of displayed window
			provider = "%7(%l/%3L%):%2c %P",
		}

		local LSPActive = {
			condition = conditions.lsp_attached,
			update = { "LspAttach", "LspDetach" },

			-- You can keep it simple,
			-- provider = " [LSP]",

			-- Or complicate things a bit and get the servers names
			provider = function()
				local names = {}
				for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
					table.insert(names, server.name)
				end
				return " [" .. table.concat(names, " ") .. "]"
			end,
			hl = { fg = "green", bold = true },
		}
		local Navic = {
			condition = function()
				return require("nvim-navic").is_available()
			end,
			static = {
				type_hl = {
					File = M.dim(utils.get_highlight("Directory").fg, 0.90),
					Module = M.dim(utils.get_highlight("@module").fg, 0.90),
					Namespace = M.dim(utils.get_highlight("@module").fg, 0.90),
					Package = M.dim(utils.get_highlight("@module").fg, 0.90),
					Class = M.dim(utils.get_highlight("@type").fg, 0.90),
					Method = M.dim(utils.get_highlight("@function.method").fg, 0.90),
					Property = M.dim(utils.get_highlight("@property").fg, 0.90),
					Field = M.dim(utils.get_highlight("@variable.member").fg, 0.90),
					Constructor = M.dim(utils.get_highlight("@constructor").fg, 0.90),
					Enum = M.dim(utils.get_highlight("@type").fg, 0.90),
					Interface = M.dim(utils.get_highlight("@type").fg, 0.90),
					Function = M.dim(utils.get_highlight("@function").fg, 0.90),
					Variable = M.dim(utils.get_highlight("@variable").fg, 0.90),
					Constant = M.dim(utils.get_highlight("@constant").fg, 0.90),
					String = M.dim(utils.get_highlight("@string").fg, 0.90),
					Number = M.dim(utils.get_highlight("@number").fg, 0.90),
					Boolean = M.dim(utils.get_highlight("@boolean").fg, 0.90),
					Array = M.dim(utils.get_highlight("@variable.member").fg, 0.90),
					Object = M.dim(utils.get_highlight("@type").fg, 0.90),
					Key = M.dim(utils.get_highlight("@keyword").fg, 0.90),
					Null = M.dim(utils.get_highlight("@comment").fg, 0.90),
					EnumMember = M.dim(utils.get_highlight("@constant").fg, 0.90),
					Struct = M.dim(utils.get_highlight("@type").fg, 0.90),
					Event = M.dim(utils.get_highlight("@type").fg, 0.90),
					Operator = M.dim(utils.get_highlight("@operator").fg, 0.90),
					TypeParameter = M.dim(utils.get_highlight("@type").fg, 0.90),
				},
				-- line: 16 bit (65536); col: 10 bit (1024); winnr: 6 bit (64)
				-- local encdec = function(a,b,c) return dec(enc(a,b,c)) end; vim.pretty_print(encdec(2^16 - 1, 2^10 - 1, 2^6 - 1))
				enc = function(line, col, winnr)
					return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
				end,
				dec = function(c)
					local line = bit.rshift(c, 16)
					local col = bit.band(bit.rshift(c, 6), 1023)
					local winnr = bit.band(c, 63)
					return line, col, winnr
				end,
			},
			init = function(self)
				local data = require("nvim-navic").get_data() or {}
				local children = {}
				for i, d in ipairs(data) do
					local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
					local child = {
						{
							provider = d.icon,
							hl = { fg = self.type_hl[d.type] },
						},
						{
							provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ""),
							hl = { fg = self.type_hl[d.type] },
							-- hl = self.type_hl[d.type],
							on_click = {
								callback = function(_, minwid)
									local line, col, winnr = self.dec(minwid)
									vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
								end,
								minwid = pos,
								name = "heirline_navic",
							},
						},
					}
					if i < #data then
						table.insert(child, {
							provider = " → ",
							hl = { fg = "bright_fg" },
						})
					end
					table.insert(children, child)
				end
				self[1] = self:new(children, 1)
			end,
			update = "CursorMoved",
			hl = { fg = "gray" },
		}

		local Diagnostics = {
			condition = conditions.has_diagnostics,
			update = { "DiagnosticChanged", "BufEnter" },
			on_click = {
				callback = function()
					require("trouble").toggle("diagnostics")
				end,
				name = "heirline_diagnostics",
			},
			init = function(self)
				self.diagnostics = vim.diagnostic.count()
			end,
			{
				provider = function(self)
					return self.diagnostics[1] and (M.icons.err .. self.diagnostics[1] .. " ")
				end,
				hl = "DiagnosticError",
			},
			{
				provider = function(self)
					return self.diagnostics[2] and (M.icons.warn .. self.diagnostics[2] .. " ")
				end,
				hl = "DiagnosticWarn",
			},
			{
				provider = function(self)
					return self.diagnostics[3] and (M.icons.info .. self.diagnostics[3] .. " ")
				end,
				hl = "DiagnosticInfo",
			},
			{
				provider = function(self)
					return self.diagnostics[4] and (M.icons.hint .. self.diagnostics[4] .. " ")
				end,
				hl = "DiagnosticHint",
			},
		}

		local Git = {
			condition = conditions.is_git_repo,

			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
				self.has_changes = self.status_dict.added ~= 0
					or self.status_dict.removed ~= 0
					or self.status_dict.changed ~= 0
			end,

			hl = { fg = "orange" },

			{ -- git branch name
				provider = function(self)
					return " " .. self.status_dict.head
				end,
				hl = { bold = true },
			},
			-- You could handle delimiters, M.icons.and counts similar to Diagnostics
			{
				condition = function(self)
					return self.has_changes
				end,
				provider = "(",
			},
			{
				provider = function(self)
					local count = self.status_dict.added or 0
					return count > 0 and ("+" .. count)
				end,
				hl = { fg = "git_add" },
			},
			{
				provider = function(self)
					local count = self.status_dict.removed or 0
					return count > 0 and ("-" .. count)
				end,
				hl = { fg = "git_del" },
			},
			{
				provider = function(self)
					local count = self.status_dict.changed or 0
					return count > 0 and ("~" .. count)
				end,
				hl = { fg = "git_change" },
			},
			{
				condition = function(self)
					return self.has_changes
				end,
				provider = ")",
			},
		}
		ViMode = utils.surround({ "", "" }, "bright_bg", { ViMode })

		-- I take no credits for this! 🦁
		local ScrollBar = {
			static = {
				sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
				-- Another variant, because the more choice the better.
				-- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
			},
			provider = function(self)
				local curr_line = vim.api.nvim_win_get_cursor(0)[1]
				local lines = vim.api.nvim_buf_line_count(0)
				local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
				return string.rep(self.sbar[i], 2)
			end,
			hl = { fg = "blue", bg = "bright_bg" },
		}

		local Spell = {
			condition = function()
				return vim.wo.spell
			end,
			provider = function()
				return "󰓆 " .. vim.o.spelllang .. " "
			end,
			hl = { bold = true, fg = "green" },
		}

		-- local SearchCount = {
		-- 	-- condition = function()
		-- 	-- 	return vim.v.hlsearch ~= 0
		-- 	-- end,
		-- 	init = function(self)
		-- 		local ok, search = pcall(vim.fn.searchcount)
		-- 		if ok and search.total then
		-- 			self.search = search
		-- 		end
		-- 	end,
		-- 	provider = function(self)
		-- 		local search = self.search
		-- 		return string.format(" %d/%d", search.current, math.min(search.total, search.maxcount))
		-- 	end,
		-- 	hl = { fg = "purple", bold = true },
		-- }
		-- local MacroRec = {
		-- 	condition = function()
		-- 		return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
		-- 	end,
		-- 	provider = M.icons.rec,
		-- 	hl = { fg = "orange", bold = true },
		-- 	utils.surround({ "[", "]" }, nil, {
		-- 		provider = function()
		-- 			return vim.fn.reg_recording()
		-- 		end,
		-- 		hl = { fg = "green", bold = true },
		-- 	}),
		-- 	update = {
		-- 		"RecordingEnter",
		-- 		"RecordingLeave",
		-- 	},
		-- 	{ provider = " " },
		-- }
		-- local Snippets = {
		-- 	condition = function()
		-- 		return vim.tbl_contains({ "s", "i" }, vim.fn.mode())
		-- 	end,
		-- 	provider = function()
		-- 		local forward = vim.snippet.active({ direction = 1 }) and " " or ""
		-- 		local backward = vim.snippet.active({ direction = -1 }) and " " or ""
		-- 		return backward .. forward
		-- 	end,
		-- 	hl = { fg = "red", bold = true },
		-- }
		local ShowCmd = {
			condition = function()
				return vim.o.cmdheight == 0
			end,
			provider = ":%3.5(%S%)",
			hl = function(self)
				return { bold = true, fg = self:mode_color() }
			end,
		}
		ViMode = utils.surround(
			{ M.separators.rounded_left, M.separators.rounded_right },
			"bright_bg",
			-- { MacroRec, ViMode, Snippets, ShowCmd }
			{ ViMode, ShowCmd }
		)
		-- local DefaultStatusline = {
		-- 	ViMode,
		-- 	Space,
		-- 	FileNameBlock,
		-- 	Space,
		-- 	Git,
		-- 	Space,
		-- 	Diagnostics,
		-- 	Align,
		-- 	SearchCount,
		-- 	LSPActive,
		-- 	Space,
		-- 	FileType,
		-- 	Space,
		-- 	Ruler,
		-- 	Space,
		-- 	ScrollBar,
		-- }

		local DefaultStatusline = {
			ViMode,
			Space,
			Spell,
			-- WorkDir,
			FileNameBlock,
			{ provider = "%<" },
			Space,
			Git,
			Space,
			Diagnostics,
			Align,
			{ flexible = 2, { Navic, Space }, { provider = "" } },
			Align,
			-- DAPMessages,
			LSPActive,
			-- VirtualEnv,
			Space,
			FileType,
			{ flexible = 3, { FileEncoding, Space }, { provider = "" } },
			Space,
			Ruler,
			-- SearchCount,
			Space,
			ScrollBar,
		}
		local winbar = {
			FileNameBlock,
			Space,
			Space,
			Navic,
			Align,
			-- SearchCount,
		}
		local h = require("heirline")
		h.setup({
			statusline = { DefaultStatusline },
			-- winbar = { winbar },
			-- tabline = { Git },
			-- statuscolumn = { Git },
		})
		h.load_colors(setup_colors)
	end,
}
