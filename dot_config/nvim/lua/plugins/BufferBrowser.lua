return {
  'https://git.sr.ht/~marcc/BufferBrowser',
  lazy = false,
  keys = {
    {
      '<D-Right>',
      function()
        require('buffer_browser').next()
      end,
      desc = 'Next Buffer',
    },
    {
      '<D-Left>',
      function()
        require('buffer_browser').prev()
      end,
      desc = 'Previous Buffer',
    },
    {
      '<D-]>',
      function()
        require('buffer_browser').next()
      end,
      desc = 'Next Buffer',
    },
    {
      '<D-[>',
      function()
        require('buffer_browser').prev()
      end,
      desc = 'Previous Buffer',
    },
  },
  opts = {
    filetype_filters = {
      'netrw',
      'help',
      'qf',
      'grug-far',
      'snacks_picker_input',
      'no-neck-pain',
      'yazi',
      '',
    },
  },
}
