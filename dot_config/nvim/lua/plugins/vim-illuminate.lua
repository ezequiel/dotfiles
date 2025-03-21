return {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
  config = function()
    require("illuminate").configure({
      providers = {
        "lsp",
        "treesitter",
      },
      disable_keymaps = true,
      -- filetypes_denylist = {},
    })
  end,
}
