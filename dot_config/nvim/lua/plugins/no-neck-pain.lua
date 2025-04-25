return {
  lazy = false,
  'shortcuts/no-neck-pain.nvim',
  opts = {
    autocmds = {
      skipEnteringNoNeckPainBuffer = true,
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
