return {
  lazy = false,
  'shortcuts/no-neck-pain.nvim',
  commit = 'c824c54d837160ac32d0f877574ccfa2ecce9947',
  opts = {
    autocmds = {
      -- enableOnTabEnter = true,
      -- enableOnVimEnter = true,
      -- skipEnteringNoNeckPainBuffer = true,
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
  },
  init = function()
    vim.api.nvim_create_autocmd({ 'VimEnter' }, {
      pattern = '*',
      once = true,
      callback = function()
        require('no-neck-pain.main').enable('')
      end,
    })
  end,
}
