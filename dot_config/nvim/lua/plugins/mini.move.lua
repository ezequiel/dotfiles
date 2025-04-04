return {
  "echasnovski/mini.move",
  version = "*",
  keys = {
    -- { "<S-j>", "<cmd>lua MiniMove.move_line('down')<cr>", mode = { "n" } },
    -- { "<S-k>", "<cmd>lua MiniMove.move_line('up')<cr>", mode = { "n" } },
    { "J", "<cmd>lua MiniMove.move_selection('down')<cr>", mode = { "x" } },
    { "K", "<cmd>lua MiniMove.move_selection('up')<cr>", mode = { "x" } },
  },
  opts = {
    mappings = {
      left = "",
      right = "",
      down = "",
      up = "",
      line_left = "",
      line_right = "",
      line_down = "",
      line_up = "",
    },
  },
  config = function(_, opts)
    require("mini.move").setup(opts)
  end,
}
