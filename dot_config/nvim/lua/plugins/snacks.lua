local function get_cwd()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")[1]
  if vim.v.shell_error ~= 0 then
    return vim.fn.getcwd()
  end
  return git_root
end

return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  dependencies = {
    "tpope/vim-sleuth",
  },
  keys = {
    {
      "<leader>gs",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Git Status",
    },
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
      mode = { "x" },
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
    {
      "<leader>:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader>lg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
  },
  opts = {
    explorer = {
      enabled = true,
      replace_netrw = false,
    },
    picker = {
      enabled = true,
      hidden = true,
      cwd = get_cwd(),
      sources = {
        explorer = {
          win = {
            list = {
              keys = {
                ["R"] = "explorer_update",
                ["<ESC>"] = "",
                ["<c-c>"] = "close",
                ["q"] = "",
              },
            },
          },
        },
        files = {
          hidden = true,
        },
      },
      matcher = { cwd_bonus = true, frecency = true, sort_empty = true },
      -- formatters = {
      --   file = {
      --     filename_first = true,
      --   },
      -- },
      win = {
        list = {
          wo = {
            conceallevel = 0,
            -- concealcursor = "",
          },
        },
      },
    },
    bufdelete = { enabled = true },
    rename = { enabled = true },
    indent = {
      enabled = true,
      -- only_current = true,
      animate = {
        enabled = false,
      },
    },
    terminal = {
      enabled = false,
    },
    lazygit = { enabled = false },
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
    notifier = { enabled = false },
    notify = { enabled = false },
    profiler = { enabled = false },
    quickfile = { enabled = false },
    scratch = { enabled = false },
    scroll = { enabled = false },
    toggle = { enabled = false },
    util = { enabled = false },
    win = { enabled = false },
    words = { enabled = false },
    zen = { enabled = false },
    statuscolumn = { enabled = false },
  },
}
