local nnoremap = require('dmunkei.keymap').nnoremap
require("luasnip.loaders.from_vscode").lazy_load()
local ls = require('luasnip')
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
