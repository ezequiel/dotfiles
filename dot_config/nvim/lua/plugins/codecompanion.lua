return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'j-hui/fidget.nvim',
  },
  keys = {
    {
      '<leader>ccc',
      '<cmd>CodeCompanionChat<cr>',
      desc = 'CodeCompanion Chat',
      mode = { 'n', 'x' },
    },
    {
      '<leader>cct',
      '<cmd>CodeCompanionChat Toggle<cr>',
      desc = 'CodeCompanion Toggle',
      mode = { 'n', 'x' },
    },
    {
      '<leader>cc',
      '<cmd>CodeCompanion<cr>',
      desc = 'CodeCompanion Inline',
      mode = { 'n', 'x' },
    },
  },
  opts = {
    display = {
      chat = {
        auto_scroll = false,
        show_token_count = false,
        separator = '─',
        intro_message = '',
        start_in_insert_mode = false,
      },
    },
    strategies = {
      chat = {
        adapter = 'copilot',
      },
      inline = {
        adapter = 'copilot',
      },
      cmd = {
        adapter = 'copilot',
      },
    },
  },
  config = function(_, opts)
    require('codecompanion').setup(opts)
  end,
  init = function()
    require('plugins.extras.codecompanion-fidget-spinner'):init()

    vim.cmd([[cab cc CodeCompanion]])
    vim.cmd([[cab ccc CodeCompanionChat]])

    vim.api.nvim_create_autocmd('User', {
      pattern = 'CodeCompanionChatOpened',
      callback = function()
        vim.defer_fn(function()
          if not vim.bo.modifiable then
            return
          end

          local row, col = unpack(vim.api.nvim_win_get_cursor(0))
          vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { '', '', '#buffer', '', '' })

          local last_row = vim.api.nvim_buf_line_count(0)
          vim.api.nvim_win_set_cursor(0, { last_row, 0 })
        end, 1)
      end,
    })
  end,
}
