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
        require('opencode').append_prompt('@buffer')
      end,
    },
    {
      '<leader>o+',
      mode = { 'x' },
      function()
        require('opencode').append_prompt('@selection')
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
    -- Example: keymap for custom prompt
    -- vim.keymap.set('n', '<leader>oe', function()
    --   require('opencode').prompt('Explain @cursor and its context')
    -- end, { desc = 'Explain this code' })
  end,
}
