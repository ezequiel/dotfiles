return {
  'jake-stewart/multicursor.nvim',
  commit = 'c117b3fc537cda262a06638ca88fe6de1b53ab59',
  keys = {
    {
      '<D-Up>',
      mode = { 'n', 'x' },
      function()
        require('multicursor-nvim').lineAddCursor(-1, { skipEmpty = false })
      end,
    },
    {
      '<D-Down>',
      mode = { 'n', 'x' },
      function()
        require('multicursor-nvim').lineAddCursor(1, { skipEmpty = false })
      end,
    },
    {
      '<D-S-Up>',
      mode = { 'n', 'x' },
      function()
        require('multicursor-nvim').lineSkipCursor(-1, { skipEmpty = false })
      end,
    },
    {
      '<D-S-Down>',
      mode = { 'n', 'x' },
      function()
        require('multicursor-nvim').lineSkipCursor(1, { skipEmpty = false })
      end,
    },
    {
      '<leader>tc',
      mode = { 'n', 'x' },
      function()
        require('multicursor-nvim').toggleCursor()
      end,
    },
    {
      'I',
      mode = 'x',
      function()
        require('multicursor-nvim').insertVisual()
      end,
    },
    {
      'A',
      mode = 'x',
      function()
        require('multicursor-nvim').appendVisual()
      end,
    },
  },
  opts = {},
  config = function(_, opts)
    local mc = require('multicursor-nvim')
    mc.setup(opts)
    mc.addKeymapLayer(function(set)
      set({ 'n', 'x' }, '<left>', mc.prevCursor)
      set({ 'n', 'x' }, '<right>', mc.nextCursor)
      set({ 'n', 'x' }, '<leader>x', mc.deleteCursor)
      set('n', '<esc>', function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)
  end,
}
