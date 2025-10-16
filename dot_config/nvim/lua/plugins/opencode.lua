return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    'folke/snacks.nvim',
  },
  keys = {
    {
      '<leader>oa',
      mode = { 'n', 'x' },
      function()
        require('opencode').ask('@this: ', { submit = true })
      end,
      desc = 'Ask about this',
    },
    {
      '<leader>oA',
      function()
        require('opencode').ask('@buffer: ', { submit = true })
      end,
    },
    {
      '<leader>o+',
      mode = { 'n', 'x' },
      function()
        require('opencode').prompt('@this')
      end,
      desc = 'Add this',
    },
    {
      '<leader>oe',
      mode = { 'n', 'x' },
      function()
        require('opencode').prompt('Explain @this and its context', { submit = true })
      end,
      desc = 'Explain this',
    },
    {
      '<leader>os',
      mode = { 'n', 'x' },
      function()
        require('opencode').select()
      end,
      desc = 'Select prompt',
    },
    {
      '<leader>ot',
      mode = { 'n', 't' },
      function()
        require('opencode').toggle()
      end,
      desc = 'Toggle embedded',
    },
    {
      '<leader>on',
      mode = { 'n', 't' },
      function()
        require('opencode').command('session_new')
      end,
      desc = 'New session',
    },
    {
      '<leader>oi',
      mode = { 'n', 't' },
      function()
        require('opencode').command('session_interrupt')
      end,
      desc = 'Interrupt session',
    },
  },
  config = function()
    vim.g.opencode_opts = {
      terminal = {
        win = {
          enter = true,
          width = 0.5,
        },
      },
    }
  end,
}
