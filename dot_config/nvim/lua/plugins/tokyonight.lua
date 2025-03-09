return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      plugins = {
        "gitsigns",
        "blink",
      },
    })
    vim.cmd("colorscheme tokyonight-night")
  end,
}
