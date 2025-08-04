return {
  'aliqyan-21/wit.nvim',
  opts = {},
  keys = {
    { 'go', ":'<,'>WitSearchVisual<cr>", mode = 'x', desc = 'Browser Search' },
    {
      'go',
      function()
        local term = vim.fn.expand('<cword>')
        vim.cmd('WitSearch ' .. term)
      end,
      mode = 'n',
      desc = 'Browser Search (cword)',
    },
  },
}
