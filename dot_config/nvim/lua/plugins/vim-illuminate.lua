return {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
  configure = function()
    require("illuminate").configure({
      providers = {
        "lsp",
        "treesitter",
      },
      disable_keymaps = true,
    })
  end,
}
