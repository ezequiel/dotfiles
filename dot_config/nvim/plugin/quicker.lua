vim.pack.add({
  'https://github.com/stevearc/quicker.nvim',
})

require('quicker').setup({
  edit = {
    enabled = false,
  },
  trim_leading_whitespace = false,
  keys = {
    {
      'R',
      function()
        require('quicker').refresh()
      end,
    },
    {
      '>',
      function()
        require('quicker').expand({ before = 2, after = 2, add_to_existing = true })
      end,
    },
    {
      '<',
      function()
        require('quicker').collapse()
      end,
    },
    {
      'q',
      function()
        require('quicker').close()
      end,
    },
  },
})

vim.keymap.set('n', '<leader>qf', function()
  require('quicker').toggle({ focus = true, open_cmd_mods = { split = 'botright' } })
end)
