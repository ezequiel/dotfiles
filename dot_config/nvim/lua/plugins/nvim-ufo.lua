return {
  'kevinhwang91/nvim-ufo',
  lazy = false,
  dependencies = {
    'kevinhwang91/promise-async',
  },
  keys = {
    {
      'zm',
      function()
        require('ufo').closeFoldsWith(1)
      end,
      desc = 'Close folds with',
    },
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
  opts = {
    provider_selector = function()
      return { 'treesitter', 'indent' }
    end,
    close_fold_kinds_for_ft = { default = { 'import_statement' } },
  },
  config = function(_, opts)
    require('ufo').setup(opts)
  end,
}
