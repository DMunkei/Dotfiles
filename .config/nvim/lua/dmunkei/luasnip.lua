require("luasnip.loaders.from_vscode").lazy_load()
local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep

ls.setup{
    history = true
}
ls.filetype_extend("python", {"django"})
ls.filetype_extend("javascript", {"vue"})
-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-l>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

ls.add_snippets("rust", {
    s({trig= "prd", dscr= "Named debug print {:?}"}, {
        t("println!(\""), i(1, "var"), t(" = {:?}\", "), rep(1), t(");")
    })
})
