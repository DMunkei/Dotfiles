local ls_ok, ls = pcall(require, "luasnip")
local cmp_ok, cmp = pcall(require, "cmp")

local types = pcall(require 'luasnip.util.types')

if not (ls_ok and cmp_ok) then return end

ls.setup({
    history = true,
})

vim.g.icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "ﰠ",
	Variable = "",
	Class = "ﴯ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "塞",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "פּ",
	Event = "",
	Operator = "",
	TypeParameter = ""
}

local snip = ls.snippet
local i = ls.insert_node
--local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets(
    "typescript", {
	snip("imp", fmt([[import {{ {1} }} from "{2}";]], { i(1, ""), i(2, "") })),
	snip("fn", fmt([[ {6}const {1} = {4}({2}): {3} => {{ {5} }} ]], {
		i(1, "myFunction"),
		i(2, "args: any"),
		i(3, "void"),
		i(4, ""),
		i(5, ""),
		i(6, "")
	}))
})

ls.add_snippets( "python",
{
    snip("def", fmt([[
    def {1}(self, {2}: {3}) -> {4}:
        {5}
        return {}
    ]],
    {
        i(1, "myfunc"),
        i(2, "arg"),
        i(3, "type"),
        i(4, "return_type"),
        i(5, ""),
        rep(4),
    })),
})

cmp.setup {
	snippet = {
		expand = function(args)
			ls.lsp_expand(args.body)
		end
	},
	mapping = cmp.mapping.preset.insert {
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<c-k>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif ls.expandable() then
				ls.expand()
			elseif ls.expand_or_jumpable() then
				ls.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<c-j>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif ls.jumpable(-1) then
				ls.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	formatting = {
		format = function(_entry, vim_item)
			vim_item.kind = (vim.g.icons[vim_item.kind] or "")
			return vim_item
		end

	},
	sources = {
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		-- { name = "nvim_lsp_signature_help" },
		{ name = "path" }
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	}
}
