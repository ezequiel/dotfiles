return {
  lazy = false,
  'shortcuts/no-neck-pain.nvim',
  opts = {
    autocmds = {
      enableOnTabEnter = true,
      enableOnVimEnter = true,
      skipEnteringNoNeckPainBuffer = true,
    },
    mappings = {
      enabled = false,
    },
    buffers = {
      left = {
        enabled = true,
      },
      right = {
        enabled = false,
      },
    },
    integrations = {
      outline = {
        position = 'left',
        reopen = true,
      },
    },
  },
  init = function()
    vim.keymap.set('n', '<leader>np', function()
      require('no-neck-pain').toggle()
    end, { desc = 'Toggle No Neck Pain' })
  end,
}
