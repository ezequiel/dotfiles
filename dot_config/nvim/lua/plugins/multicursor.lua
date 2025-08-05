return {
  'jake-stewart/multicursor.nvim',
  branch = 'with-revert',
  keys = {
    {
      '<D-Up>',
      function()
        require('multicursor-nvim').lineAddCursor(-1, { skipEmpty = false })
      end,
    },
    {
      '<D-Down>',
      function()
        require('multicursor-nvim').lineAddCursor(1, { skipEmpty = false })
      end,
    },
    {
      '<D-S-Up>',
      function()
        require('multicursor-nvim').lineSkipCursor(-1, { skipEmpty = false })
      end,
    },
    {
      '<D-S-Down>',
      function()
        require('multicursor-nvim').lineSkipCursor(1, { skipEmpty = false })
      end,
    },
    {
      '<leader>tc',
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
    {
      '<leader>ma',
      mode = { 'n', 'x' },
      function()
        require('multicursor-nvim').matchAllAddCursors()
      end,
    },
    {
      '<leader>A',
      function()
        require('multicursor-nvim').searchAllAddCursors()
      end,
    },
    {
      'M',
      mode = 'x',
      function()
        require('multicursor-nvim').matchCursors()
      end,
    },
    {
      '<leader>M',
      mode = 'x',
      function()
        local pattern = vim.fn.getreg('"')
        require('multicursor-nvim').matchCursors(pattern)
      end,
    },
    {
      '<leader>gv',
      function()
        require('multicursor-nvim').restoreCursors()
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
