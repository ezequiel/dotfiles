return {
  "jake-stewart/multicursor.nvim",
  event = "VeryLazy",
  config = function()
    local multicursor = require("multicursor-nvim")
    multicursor.setup()

    vim.keymap.set({ "n" }, "<c-a>", multicursor.toggleCursor)
    vim.keymap.set("n", "<leader>A", multicursor.searchAllAddCursors)
    vim.keymap.set("x", "M", multicursor.matchCursors)

    multicursor.addKeymapLayer(function(layerSet)
      layerSet("n", "<esc>", function()
        if not multicursor.cursorsEnabled() then
          multicursor.enableCursors()
        else
          multicursor.clearCursors()
        end
      end)
    end)

    vim.api.nvim_set_hl(4, "MultiCursorCursor", { link = "Cursor" })
    vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
    vim.api.nvim_set_hl(0, "MultiCursorSign", { link = "SignColumn" })
    vim.api.nvim_set_hl(0, "MultiCursorMatchPreview", { link = "Search" })
    vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
    vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    vim.api.nvim_set_hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
