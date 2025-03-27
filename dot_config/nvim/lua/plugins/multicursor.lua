return {
  "jake-stewart/multicursor.nvim",
  keys = {
    {
      "<c-a>",
      function()
        require("multicursor-nvim").toggleCursor()
      end,
      mode = { "n" },
    },
    {
      "<leader>A",
      function()
        require("multicursor-nvim").searchAllAddCursors()
      end,
      mode = { "n" },
    },
  },
  config = function()
    local multicursor = require("multicursor-nvim")
    multicursor.setup()

    multicursor.addKeymapLayer(function(layerSet)
      layerSet("n", "<c-c>", function()
        multicursor.clearCursors()
      end)
      layerSet("n", "<esc>", function()
        if not multicursor.cursorsEnabled() then
          multicursor.enableCursors()
        elseif multicursor.hasCursors() then
          multicursor.clearCursors()
        end
      end)
    end)

    -- multicursor.onSafeState(function(event)
    --   if event.wasMode == "i" or event.wasMode == "R" then
    --     multicursor.clearCursors()
    --   end
    -- end)

    vim.api.nvim_set_hl(4, "MultiCursorCursor", { link = "Visual" })
    vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
    vim.api.nvim_set_hl(0, "MultiCursorSign", { link = "SignColumn" })
    vim.api.nvim_set_hl(0, "MultiCursorMatchPreview", { link = "Search" })
    vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
    vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    vim.api.nvim_set_hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
