return {
  event = 'VeryLazy',
  'jake-stewart/multicursor.nvim',
  -- branch = '1.0',
  commit = 'c117b3fc537cda262a06638ca88fe6de1b53ab59',
  config = function()
    local mc = require('multicursor-nvim')
    mc.setup()

    local set = vim.keymap.set

    -- Add or skip cursor above/below the main cursor.
    set({ 'n', 'x' }, '<D-Up>', function()
      mc.lineAddCursor(-1, { skipEmpty = false })
    end)
    set({ 'n', 'x' }, '<D-Down>', function()
      mc.lineAddCursor(1, { skipEmpty = false })
    end)
    set({ 'n', 'x' }, '<D-S-Up>', function()
      mc.lineSkipCursor(-1, { skipEmpty = false })
    end)
    set({ 'n', 'x' }, '<D-S-Down>', function()
      mc.lineSkipCursor(1, { skipEmpty = false })
    end)

    -- Disable and enable cursors.
    set({ 'n', 'x' }, '<c-a>', function()
      mc.toggleCursor()
    end)

    -- Append/insert for each line of visual selections.
    -- Similar to block selection insertion.
    set('x', 'I', mc.insertVisual)
    set('x', 'A', mc.appendVisual)

    -- Mappings defined in a keymap layer only apply when there are
    -- multiple cursors. This lets you have overlapping mappings.
    mc.addKeymapLayer(function(layerSet)
      -- Select a different cursor as the main one.
      layerSet({ 'n', 'x' }, '<left>', mc.prevCursor)
      layerSet({ 'n', 'x' }, '<right>', mc.nextCursor)

      -- Delete the main cursor.
      layerSet({ 'n', 'x' }, '<leader>x', mc.deleteCursor)

      -- Enable and clear cursors using escape.
      layerSet('n', '<esc>', function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)
  end,
}
