require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown()
    }
  },
  defaults = {
    preview = {
      treesitter = {
        disable = {
          "css",
          "javascript",
        },
      },
    },
  }
}
require("telescope").load_extension("ui-select")
