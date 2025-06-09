return {
  'cshuaimin/ssr.nvim',
  keys = {
    {
      '<leader>ssr',
      function()
        require('ssr').open()
      end,
      desc = 'SSR: Search and Replace',
      mode = { 'n', 'x' },
    },
  },
  opt = {
    border = 'single',
    min_width = 50,
    min_height = 5,
    max_width = 120,
    max_height = 25,
    adjust_window = true,
    keymaps = {
      close = 'q',
      next_match = '<c-n>',
      prev_match = '<c-p>',
      replace_confirm = '<cr>',
      replace_all = '<leader>rr',
    },
  },
}
