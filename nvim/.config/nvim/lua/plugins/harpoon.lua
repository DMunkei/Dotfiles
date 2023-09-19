return {
	"ThePrimeagen/harpoon",

    config = function()
        require("harpoon").setup({
            menu = { width = 100 },
        })
    end,
    vim.keymap.set("n", "<leader>a", function() require("harpoon.mark").add_file() end),
    vim.keymap.set("n", "<leader>ht", function() require("harpoon.ui").toggle_quick_menu() end),
    vim.keymap.set("n", "<leader>1", function() require("harpoon.ui").nav_file(1) end),
    vim.keymap.set("n", "<leader>2", function() require("harpoon.ui").nav_file(2) end),
    vim.keymap.set("n", "<leader>3", function() require("harpoon.ui").nav_file(3) end),
    vim.keymap.set("n", "<leader>4", function() require("harpoon.ui").nav_file(4) end),
}
	-- "tpope/vim-rhubarb",
