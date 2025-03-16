return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night",
      lualine_bold = true,
      plugins = {
        auto = true,
      },
    })
    vim.cmd("colorscheme tokyonight-night")
  end,
}
