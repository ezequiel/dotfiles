return {
  'ezequiel/viedit',
  opts = {},
  keys = {
    {
      '<leader>ie',
      function()
        require('viedit').toggle_all()
      end,
      mode = { 'n', 'v' },
      desc = 'Toggle all with viedit',
    },
    {
      '<leader>V',
      function()
        require('viedit').restrict_to_visual_selection()
        require('viedit').step({ back = true })
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'x', false)
      end,
      mode = 'x',
      desc = 'Restrict viedit to visual selection',
    },
    {
      '<leader>F',
      function()
        require('viedit').restrict_to_function()
        require('viedit').step({ back = true })
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'x', false)
      end,
      mode = 'n',
      desc = 'Restrict viedit to function',
    },
  },
}
