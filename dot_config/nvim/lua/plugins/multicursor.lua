return {
  event = 'VeryLazy',
  'jake-stewart/multicursor.nvim',
  branch = '1.0',
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

    -- Add or skip adding a new cursor by matching word/selection
    set({ 'n', 'x' }, '<leader>ma', function()
      mc.matchAddCursor(1)
    end)
    set({ 'n', 'x' }, '<leader>ms', function()
      mc.matchSkipCursor(1)
    end)
    set({ 'n', 'x' }, '<leader>mA', function()
      mc.matchAddCursor(-1)
    end)
    set({ 'n', 'x' }, '<leader>mS', function()
      mc.matchSkipCursor(-1)
    end)
    set({ 'n', 'x' }, '<leader>A', function()
      mc.searchAllAddCursors()
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

    -- mc.onModeChanged(function(cursor, oldMode, newMode)
    --   if oldMode and string.find('iR', oldMode) and newMode == 'n' then
    --     cursor:feedkeys('`^')
    --   end
    -- end)

    -- local hl = vim.api.nvim_set_hl
    -- hl(0, 'MultiCursorCursor', { reverse = true })
    -- hl(0, 'MultiCursorVisual', { link = 'Visual' })
    -- hl(0, 'MultiCursorSign', { link = 'SignColumn' })
    -- hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
    -- hl(0, 'MultiCursorDisabledCursor', { reverse = true })
    -- hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
    -- hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
  end,
}
-- return {
--   'jake-stewart/multicursor.nvim',
--   branch = '1.0',
--   keys = {
--     {
--       '<c-a>',
--       function()
--         require('multicursor-nvim').toggleCursor()
--       end,
--       mode = { 'n' },
--     },
--     {
--       '<leader>A',
--       function()
--         require('multicursor-nvim').searchAllAddCursors()
--       end,
--       mode = { 'n' },
--     },
--   },
--   config = function()
--     local multicursor = require('multicursor-nvim')
--     multicursor.setup()
--
--     multicursor.addKeymapLayer(function(layerSet)
--       layerSet('n', '<c-c>', function()
--         multicursor.clearCursors()
--       end)
--       layerSet('n', '<esc>', function()
--         if not multicursor.cursorsEnabled() then
--           multicursor.enableCursors()
--         elseif multicursor.hasCursors() then
--           multicursor.clearCursors()
--         end
--       end)
--     end)
--
--     -- multicursor.onSafeState(function(event)
--     --   if event.wasMode == "i" or event.wasMode == "R" then
--     --     multicursor.clearCursors()
--     --   end
--     -- end)
--   end,
-- }
