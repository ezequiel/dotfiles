return {
  'jim-at-jibba/nvim-redraft',
  dependencies = {
    'folke/snacks.nvim',
  },
  build = 'cd ts && npm ci && npm run build',
  opts = {
    llm = {
      provider = 'copilot',
    },
  },
  keys = {
    {
      '<leader>aa',
      function()
        require('nvim-redraft').edit()
      end,
      mode = 'x',
    },
    {
      '<leader>aa',
      function()
        vim.cmd('normal! V')
        require('nvim-redraft').edit()
      end,
    },
  },
}
