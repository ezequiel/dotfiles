return {
  "gbprod/yanky.nvim",
  dependencies = {
    { "kkharji/sqlite.lua" },
  },
  opts = {
    ring = { storage = "sqlite" },
  },
  keys = {
    { "y", "<Plug>(YankyYank)", mode = { "n", "v" }, desc = "Yank text" },
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "v" }, desc = "Put yanked text after cursor" },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "v" }, desc = "Put yanked text before cursor" },
  },
}
