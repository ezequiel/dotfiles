return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    'folke/snacks.nvim',
  },
  keys = {
    {
      '<leader>ot',
      function()
        require('opencode').toggle()
      end,
    },
    {
      '<leader>oA',
      function()
        require('opencode').ask()
      end,
    },
    {
      '<leader>oa',
      function()
        require('opencode').ask('@cursor: ')
      end,
    },
    {
      '<leader>oa',
      mode = { 'x' },
      function()
        require('opencode').ask('@selection: ')
      end,
    },
    {
      '<leader>on',
      function()
        require('opencode').command('session_new')
      end,
    },
    {
      '<leader>oy',
      function()
        require('opencode').command('messages_copy')
      end,
    },
    {
      '<leader>o+',
      function()
        require('opencode').prompt('@buffer', { append = true })
      end,
    },
    {
      '<leader>o+',
      mode = { 'x' },
      function()
        require('opencode').prompt('@selection', { append = true })
      end,
    },
    {
      '<leader>os',
      mode = { 'n', 'x' },
      function()
        require('opencode').select()
      end,
    },
  },
  config = function()
    vim.g.opencode_opts = {
      terminal = {
        win = {
          enter = true,
        },
      },
    }
  end,
}
