return {
  "folke/trouble.nvim",
  opts = {
    -- auto_jump = true,
    focus = true,
    auto_close = true,
    -- filter = { severity = vim.diagnostic.severity.ERROR },
    win = {
      wo = {
        wrap = true,
      },
    },
    keys = { q = "close", ["<esc>"] = false, ["<c-c>"] = "close", R = "refresh" },
  },
  keys = {
    {
      "<leader>tt",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Trouble: toggle diagnostics",
    },
  },
}
