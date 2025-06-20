return {
  'nvim-treesitter/nvim-treesitter-context',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'VeryLazy',
  config = true,
  init = function()
    vim.keymap.set('n', '<leader>gc', function()
      require('treesitter-context').go_to_context()
    end, { silent = true })
  end,
}
