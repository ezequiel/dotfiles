return {
  'kwkarlwang/bufjump.nvim',
  opts = {
    forward_key = nil,
    backward_key = nil,
    on_success = nil,
  },
  keys = {
    {
      '<D-[>',
      function()
        require('bufjump').backward()
      end,
      desc = 'Jump to previous buffer position',
      silent = true,
      noremap = true,
    },
    {
      '<D-]>',
      function()
        require('bufjump').forward()
      end,
      desc = 'Jump to next buffer position',
      silent = true,
      noremap = true,
    },
    {
      '<C-S-O>',
      function()
        require('bufjump').backward_same_buf()
      end,
      desc = 'Jump to previous position in the same buffer',
      silent = true,
      noremap = true,
    },
    {
      '<C-S-I>',
      function()
        require('bufjump').forward_same_buf()
      end,
      desc = 'Jump to next position in the same buffer',
      silent = true,
      noremap = true,
    },
  },
}
