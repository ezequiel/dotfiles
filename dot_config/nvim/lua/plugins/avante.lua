return {
  "yetone/avante.nvim",
  keys = {
    { "<leader>aa", "<cmd>AvanteAsk<cr>", mode = { "n", "x" } },
    { "<leader>ae", "<cmd>AvanteEdit<cr>", mode = { "n", "x" } },
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
      --   }
      width = 50,
    },
    mappings = { sidebar = { close = "<c-c>", close_from_input = { normal = "<c-c>" } } },
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
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function(_, opts)
    require("avante").setup(opts)
  end,
}
