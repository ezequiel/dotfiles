vim.pack.add({
  'https://github.com/rachartier/tiny-glimmer.nvim',
})

require('tiny-glimmer').setup({
  overwrite = {
    search = {
      enabled = false,
    },
    undo = {
      enabled = true,
    },
    redo = {
      enabled = true,
    },
  },
})
