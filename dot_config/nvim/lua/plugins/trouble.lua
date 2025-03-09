return {
  "folke/trouble.nvim",
  opts = {
    -- auto_jump = true,
    focus = true,
    auto_close = true,
  },
  keys = {
    {
      "<leader>tt",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Trouble: toggle diagnostics",
    },
  },
}
