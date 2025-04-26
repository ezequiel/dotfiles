return {
  'https://git.sr.ht/~marcc/BufferBrowser',
  lazy = false,
  keys = {
    {
      ']b',
      function()
        require('buffer_browser').next()
      end,
      mode = { 'n', 'x' },
      desc = 'Next Buffer',
    },
    {
      '[b',
      function()
        require('buffer_browser').prev()
      end,
      desc = 'Previous Buffer',
      mode = { 'n', 'x' },
    },
    {
      '<c-i>',
      function()
        require('buffer_browser').next()
      end,
      desc = 'Next Buffer',
      mode = { 'n', 'x' },
    },
    {
      '<c-o>',
      function()
        require('buffer_browser').prev()
      end,
      desc = 'Previous Buffer',
      mode = { 'n', 'x' },
    },
    {
      '<BackSpace>',
      function()
        require('buffer_browser').prev()
      end,
      desc = 'Previous Buffer',
      mode = { 'n', 'x' },
    },
  },
  opts = {
    -- filetype_filters = {'gitcommit', 'TelescopePrompt'}
  },
  init = function()
    vim.g.netrw_fastbrowse = 0
  end,
}
