return {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
  configure = function()
    require("illuminate").configure({
      delay = 0,
      disable_keymaps = true,
    })
  end,
}
