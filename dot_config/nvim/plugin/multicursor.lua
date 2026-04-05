vim.pack.add({
  'https://github.com/jake-stewart/multicursor.nvim',
})

local mc = require('multicursor-nvim')
mc.setup()
mc.addKeymapLayer(function(set)
  set({ 'n', 'x' }, '<left>', mc.prevCursor)
  set({ 'n', 'x' }, '<right>', mc.nextCursor)
  set({ 'n', 'x' }, '<BS>', mc.deleteCursor)
  set('n', '<esc>', function()
    if not mc.cursorsEnabled() then
      mc.enableCursors()
    else
      mc.clearCursors()
    end
  end)
  set('n', '<c-c>', function()
    if not mc.hasCursors() then
      return
    end
    mc.clearCursors()
  end)
end)

vim.keymap.set('n', '<M-Up>', function()
  require('multicursor-nvim').lineAddCursor(-1, { skipEmpty = false })
end)
vim.keymap.set('n', '<M-Down>', function()
  require('multicursor-nvim').lineAddCursor(1, { skipEmpty = false })
end)
vim.keymap.set('n', '<M-S-Up>', function()
  require('multicursor-nvim').lineSkipCursor(-1, { skipEmpty = false })
end)
vim.keymap.set('n', '<M-S-Down>', function()
  require('multicursor-nvim').lineSkipCursor(1, { skipEmpty = false })
end)
vim.keymap.set('n', '@@', require('multicursor-nvim').toggleCursor)
vim.keymap.set('x', 'I', require('multicursor-nvim').insertVisual)
vim.keymap.set('x', 'A', require('multicursor-nvim').appendVisual)
vim.keymap.set({ 'n', 'x' }, '<leader>ma', require('multicursor-nvim').matchAllAddCursors)
vim.keymap.set('n', '<leader>A', require('multicursor-nvim').searchAllAddCursors)
vim.keymap.set('x', 'M', require('multicursor-nvim').matchCursors)
vim.keymap.set('x', '<leader>M', function()
  local pattern = vim.fn.getreg('"')
  require('multicursor-nvim').matchCursors(pattern)
end)
vim.keymap.set('n', '<leader>gv', require('multicursor-nvim').restoreCursors)
