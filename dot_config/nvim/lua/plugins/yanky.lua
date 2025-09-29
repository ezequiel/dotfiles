return {
  'gbprod/yanky.nvim',
  dependencies = {
    'folke/snacks.nvim',
  },
  opts = {},
  keys = {
    { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yank text' },
    { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after cursor' },
    { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before cursor' },
    {
      '<leader>yh',
      mode = { 'n', 'x' },
      function()
        Snacks.picker.yanky()
      end,
      desc = 'Open Yank History',
    },
  },
}
