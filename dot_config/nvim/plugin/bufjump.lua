vim.pack.add({
  'https://github.com/kwkarlwang/bufjump.nvim',
})

require('bufjump').setup({
  forward_key = '<D-]>',
  backward_key = '<D-[>',
  on_success = false,
  forward_same_buf_key = '<C-S-I>',
  backward_same_buf_key = '<C-S-O>',
})
