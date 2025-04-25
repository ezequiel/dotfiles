return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('tokyonight').setup({
      style = 'night',
      lualine_bold = true,
      plugins = {
        auto = true,
      },
    })
  end,
  init = function()
    vim.cmd('colorscheme tokyonight-night')
    vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#1a1b26' })
    vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#16161e', bg = '#1a1b26' })
    vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = '#16161e', bg = '#1a1b26' })
  end,
}
