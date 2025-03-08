return {
  "saecki/live-rename.nvim",
  event = "VeryLazy",
  config = function()
    vim.keymap.set("n", "<leader>r", function()
      require("live-rename").rename({ insert = true })
    end, { desc = "LSP rename" })
  end,
}
