return  {
  "folke/zen-mode.nvim",
  opts = {
    keys = {
    vim.keymap.set("n", "<leader>8", function ()
        require("zen-mode").toggle()
    end)
    },
    plugins = {
      tmux = {enabled  = true},
      alacritty = {
        enabled = true,
        font = "14",
      }

    }
  }
}
