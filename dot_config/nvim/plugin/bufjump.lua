vim.pack.add({
  'https://github.com/kwkarlwang/bufjump.nvim',
})

require('bufjump').setup({
  forward_key = '<M-]>',
  backward_key = '<M-[>',
  on_success = false,
  forward_same_buf_key = '<C-S-I>',
  backward_same_buf_key = '<C-S-O>',
})
