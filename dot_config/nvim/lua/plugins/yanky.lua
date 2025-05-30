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
      function()
        Snacks.picker.yanky()
      end,
      mode = { 'n', 'x' },
      desc = 'Open Yank History',
    },
  },
}
