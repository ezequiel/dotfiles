return {
  lazy = false,
  'xvzc/chezmoi.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    edit = {
      watch = true,
      force = true,
    },
    events = {
      on_open = {
        notification = {
          enable = false,
        },
      },
      on_watch = {
        notification = {
          enable = false,
        },
      },
      on_apply = {
        notification = {
          enable = false,
        },
      },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
      pattern = vim.env.XDG_DATA_HOME .. '/chezmoi/*',
      callback = function(event)
        vim.schedule(function()
          require('chezmoi.commands.__edit').watch(event.buf)
        end)
      end,
    })
  end,
}
