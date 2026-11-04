vim.pack.add({
  'https://github.com/aimdevlee/herdr-nvim-nav',
})

require('herdr-nvim-nav').setup({
  with_tmux = false,
  keymaps = {
    left = { '<M-S-Left>' },
    down = { '<M-S-Down>' },
    up = { '<M-S-Up>' },
    right = { '<M-S-Right>' },
  },
})
