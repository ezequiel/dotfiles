return {
  'https://git.sr.ht/~marcc/BufferBrowser',
  event = 'VeryLazy',
  keys = {
    {
      '<D-Right>',
      function()
        require('buffer_browser').next()
      end,
      desc = 'Next Buffer',
      mode = { 'n', 'x' },
    },
    {
      '<D-Left>',
      function()
        require('buffer_browser').prev()
      end,
      desc = 'Previous Buffer',
      mode = { 'n', 'x' },
    },
    {
      '<D-]>',
      function()
        require('buffer_browser').next()
      end,
      desc = 'Next Buffer',
      mode = { 'n', 'x' },
    },
    {
      '<D-[>',
      function()
        require('buffer_browser').prev()
      end,
      desc = 'Previous Buffer',
      mode = { 'n', 'x' },
    },
  },
  opts = {
    filetype_filters = {
      'netrw',
      'help',
      'qf',
      'grug-far',
      'norg',
      'snacks_picker_input',
      'no-neck-pain',
      'yazi',
      'norg',
      '',
    },
  },
  init = function()
    vim.g.netrw_fastbrowse = 0
  end,
}
