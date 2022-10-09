vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
require("indent_blankline").setup{
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
