return {
  "yetone/avante.nvim",
  cmd = "AvanteStart",
  version = false,
  opts = {
    provider = "copilot",
    behaviour = {
      enable_token_counting = false,
      support_paste_from_clipboard = true,
    },
    hints = { enabled = false },
    windows = {
      sidebar_header = {
        enabled = false,
      },
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
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
}
