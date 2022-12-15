vim.opt.laststatus = 3
vim.opt.fillchars:append({
    horiz = '━',
    horizup = '┻',
    horizdown = '┳',
    vert = '┃',
    vertleft = '┨',
    vertright = '┣',
    verthoriz = '╋',
})



local default_colors = require("kanagawa.colors").setup()
local overrides = {
    LineNr = { fg = "#C0A36E", bg = "NONE"},
    -- LineNr = { fg = "gold", bg = "NONE"},
    CursorLineNr = { fg = default_colors.sakuraPink, bg = "NONE"},
}

require('kanagawa').setup({
    undercurl = true,           -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = {},
    variablebuiltinStyle = { italic = true},
    specialReturn = true,       -- special highlight for the return keyword
    specialException = true,    -- special highlight for exception handling keywords
    transparent = false,        -- do not set background color
    dimInactive = true,        -- dim inactive window `:h hl-NormalNC`
    globalStatus = true,       -- adjust window separators highlight for laststatus=3
    terminalColors = true,      -- define vim.g.terminal_color_{0,17}
    colors = {},
    overrides = overrides,
    theme = "default"           -- Load "default" theme or the experimental "light" theme
})
vim.cmd("colorscheme kanagawa")
-- vim.api.nvim_set_hl(1, "Linenr", {bg = "none", fg = "#C0A36E"})
vim.cmd [[highlight IndentBlanklineContextStart guisp=#FF0000 gui=underline]]
