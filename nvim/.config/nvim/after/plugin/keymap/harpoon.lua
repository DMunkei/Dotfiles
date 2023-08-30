local nnoremap = require("dmunkei.keymap").nnoremap

local silent = { silent = true }

nnoremap("<leader>a", function() require("harpoon.mark").add_file() end, silent)
nnoremap("<leader>ht", function() require("harpoon.ui").toggle_quick_menu() end, silent)

nnoremap("<M-1>", function() require("harpoon.ui").nav_file(1) end, silent)
nnoremap("<M-2>", function() require("harpoon.ui").nav_file(2) end, silent)
nnoremap("<M-3>", function() require("harpoon.ui").nav_file(3) end, silent)
nnoremap("<M-4>", function() require("harpoon.ui").nav_file(4) end, silent)
