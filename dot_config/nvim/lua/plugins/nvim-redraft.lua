return {
  'jim-at-jibba/nvim-redraft',
  dependencies = {
    'folke/snacks.nvim',
  },
  build = 'cd ts && npm ci && npm run build',
  opts = {
    llm = {
      provider = 'copilot',
      model = 'gpt-4o',
    },
  },
  keys = {
    {
      '<leader>oe',
      function()
        require('nvim-redraft').edit()
      end,
      mode = 'x',
    },
    {
      '<leader>oe',
      function()
        vim.cmd('normal! V')
        require('nvim-redraft').edit()
      end,
    },
  },
}
