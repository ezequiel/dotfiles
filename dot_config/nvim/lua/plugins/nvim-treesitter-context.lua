return {
  'nvim-treesitter/nvim-treesitter-context',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  lazy = false,
  config = true,
  init = function()
    vim.keymap.set('n', '<leader>gc', function()
      require('treesitter-context').go_to_context()
      vim.cmd('normal! ^')
    end, { silent = true })
  end,
}
