return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    style = 'night',
    plugins = {
      auto = true,
    },
  },
  init = function()
    vim.cmd('colorscheme tokyonight')
    vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#16161e', bg = '#1a1b26' })
    vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = '#16161e', bg = '#1a1b26' })
  end,
}
