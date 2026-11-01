vim.pack.add({
  'https://github.com/aimdevlee/herdr-nvim-nav',
})

require('herdr-nvim-nav').setup({
  with_tmux = false,
  keymaps = {
    left = { '<C-h>' },
    down = { '<C-j>' },
    up = { '<C-k>' },
    right = { '<C-l>' },
  },
})
