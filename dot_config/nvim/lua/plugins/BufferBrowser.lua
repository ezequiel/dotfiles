return {
  'https://git.sr.ht/~marcc/BufferBrowser',
  lazy = false,
  keys = {
    {
      ']b',
      function()
        require('buffer_browser').next()
      end,
      desc = 'Next Buffer',
    },
    {
      '[b',
      function()
        require('buffer_browser').prev()
      end,
      desc = 'Previous Buffer',
    },
  },
  opts = {
    -- filetype_filters = {'gitcommit', 'TelescopePrompt'}
  },
  init = function()
    vim.g.netrw_fastbrowse = 0
  end,
}
