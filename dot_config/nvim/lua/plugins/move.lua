return {
  "hinell/move.nvim",
  keys = {
    {
      "J",
      "<cmd>MoveLine 1<CR>",
      mode = { "n" },
      noremap = true,
      silent = true,
    },
    {
      "K",
      "<cmd>MoveLine -1<CR>",
      mode = { "n" },
      noremap = true,
      silent = true,
    },
    {
      "J",
      silent = true,
      ":MoveBlock 1<CR>",
      mode = { "v" },
      noremap = true,
    },
    {
      "K",
      ":MoveBlock -1<CR>",
      mode = { "v" },
      noremap = true,
      silent = true,
    },
  },
}
