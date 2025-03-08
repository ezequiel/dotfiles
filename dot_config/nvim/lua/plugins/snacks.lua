return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "File Explorer",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Recent",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    -- LSP
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
      "gy",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Goto T[y]pe Definition",
    },
  },
  ---@type snacks.Config
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
    indent = {
      enabled = true,
      only_current = true,
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
    rename = { enabled = false },
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
