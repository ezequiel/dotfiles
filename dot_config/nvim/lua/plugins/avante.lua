return {
  "yetone/avante.nvim",
  keys = {
    { "<leader>av", "<cmd>AvanteToggle<cr>", mode = { "n", "v" } },
  },
  version = false,
  opts = {
    provider = "copilot",
    behaviour = {
      enable_token_counting = false,
      support_paste_from_clipboard = true,
    },
    hints = { enabled = false },
    windows = {
      ask = {
        start_insert = false,
      },
      -- sidebar_header = {
      --   enabled = false,
      width = 50,
    },
  },
  build = "make",
  dependencies = {
    {
      "zbirenbaum/copilot.lua",
      event = nil,
      opts = {
        suggestion = { enabled = false },
        panel = { enabled = false },
      },
    },
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function(_, opts)
    require("avante").setup(opts)
  end,
}
