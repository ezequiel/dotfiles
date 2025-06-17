return {
  'kevinhwang91/nvim-ufo',
  event = 'VeryLazy',
  dependencies = {
    'kevinhwang91/promise-async',
  },
  keys = {
    {
      'zR',
      function()
        require('ufo').openAllFolds()
      end,
      desc = 'Open all folds',
    },
    {
      'zM',
      function()
        require('ufo').closeAllFolds()
      end,
      desc = 'Close all folds',
    },
  },
  config = function(_, opts)
    require('ufo').setup(opts)
  end,
}
