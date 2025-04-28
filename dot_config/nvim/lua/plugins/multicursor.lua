return {
  'jake-stewart/multicursor.nvim',
  keys = {
    {
      '<c-a>',
      function()
        require('multicursor-nvim').toggleCursor()
      end,
      mode = { 'n' },
    },
    {
      '<leader>A',
      function()
        require('multicursor-nvim').searchAllAddCursors()
      end,
      mode = { 'n' },
    },
  },
  config = function()
    local multicursor = require('multicursor-nvim')
    multicursor.setup()

    multicursor.addKeymapLayer(function(layerSet)
      layerSet('n', '<c-c>', function()
        multicursor.clearCursors()
      end)
      layerSet('n', '<esc>', function()
        if not multicursor.cursorsEnabled() then
          multicursor.enableCursors()
        elseif multicursor.hasCursors() then
          multicursor.clearCursors()
        end
      end)
    end)

    multicursor.onModeChanged(function(cursor, oldMode, newMode)
      if oldMode and string.find('iR', oldMode) and newMode == 'n' then
        cursor:feedkeys('`^')
      end
    end)
    -- multicursor.onSafeState(function(event)
    --   if event.wasMode == "i" or event.wasMode == "R" then
    --     multicursor.clearCursors()
    --   end
    -- end)
  end,
}
