return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>e",
      function()
        Snacks.explorer({
          hidden = true,
          win = {
            list = {
              keys = {
                ["<ESC>"] = "",
              },
            },
          },
        })
      end,
      desc = "File Explorer",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files({
          hidden = true,
          frecency = true,
          cwd_bonus = true,
        })
      end,
      desc = "Find Files",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers({
          frecency = true,
          cwd_bonus = true,
        })
      end,
      desc = "Buffers",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep({
          hidden = true,
          frecency = true,
          cwd_bonus = true,
        })
      end,
      desc = "Grep",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent({
          frecency = true,
          cwd_bonus = true,
        })
      end,
      desc = "Recent",
    },
  },
  ---@type snacks.Config
  opts = {
    explorer = { enabled = true },
    picker = { enabled = true },
    animate = { enabled = false },
    bigfile = { enabled = false },
    bufdelete = { enabled = false },
    dashboard = { enabled = false },
    debug = { enabled = false },
    dim = { enabled = false },
    git = { enabled = false },
    gitbrowse = { enabled = false },
    image = { enabled = false },
    indent = { enabled = false },
    input = { enabled = false },
    layout = { enabled = false },
    lazygit = { enabled = false },
    notifier = { enabled = false },
    notify = { enabled = false },
    profiler = { enabled = false },
    quickfile = { enabled = false },
    rename = { enabled = false },
    scope = { enabled = false },
    scratch = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    terminal = { enabled = false },
    toggle = { enabled = false },
    util = { enabled = false },
    win = { enabled = false },
    words = { enabled = false },
    zen = { enabled = false },
  },
}
