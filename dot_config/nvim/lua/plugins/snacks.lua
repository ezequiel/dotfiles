return {
  "folke/snacks.nvim",
  priority = 1000,
  keys = {
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "File Explorer",
    },
    {
      "<leader>f",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>b",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>rg",
      function()
        Snacks.picker.grep()
      end,
      mode = { "n" },
      desc = "Grep",
    },
    {
      "<leader>rg",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Visual selection or word",
      mode = { "x", "v" },
    },
    {
      "<C-x>",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "gd",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "Goto Definition",
    },
    {
      "gr",
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = "References",
    },
    {
      "gi",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "Goto Implementation",
    },
    {
      "gt",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Goto Type Definition",
    },
    {
      "<leader>m",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },
  },
  opts = {
    explorer = {
      enabled = true,
      hidden = true,
      win = {
        list = {
          keys = {
            ["<ESC>"] = "",
          },
        },
      },
    },
    picker = { enabled = true, hidden = true, frecency = true, cwd_bonus = true },
    bufdelete = { enabled = true },
    rename = { enabled = true },
    indent = {
      enabled = true,
      -- only_current = true,
    },
    animate = { enabled = false },
    bigfile = { enabled = false },
    dashboard = { enabled = false },
    debug = { enabled = false },
    scope = { enabled = false },
    dim = { enabled = false },
    git = { enabled = false },
    gitbrowse = { enabled = false },
    image = { enabled = false },
    input = { enabled = false },
    layout = { enabled = false },
    lazygit = { enabled = false },
    notifier = { enabled = false },
    notify = { enabled = false },
    profiler = { enabled = false },
    quickfile = { enabled = false },
    scratch = { enabled = false },
    scroll = { enabled = false },
    terminal = { enabled = false },
    toggle = { enabled = false },
    util = { enabled = false },
    win = { enabled = false },
    words = { enabled = false },
    zen = { enabled = false },
    statuscolumn = { enabled = false },
  },
}
