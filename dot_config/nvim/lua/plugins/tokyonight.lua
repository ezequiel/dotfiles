return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      plugins = {
        "gitsigns",
        "blink",
        "snacks",
        "render-markdown",
        "trouble",
        "yanky",
        "illuminate",
        "grug-far",
        "noice",
      },
    })
    vim.cmd("colorscheme tokyonight-night")
  end,
}
