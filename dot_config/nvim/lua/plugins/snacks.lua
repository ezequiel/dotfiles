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
      mode = { "n", "x" },
    },
    {
      "<leader>f",
      function()
        Snacks.picker.files({ cwd = get_cwd() })
      end,
      mode = { "n", "x" },
    },
    {
      "<leader>b",
      function()
        Snacks.picker.buffers()
      end,
      mode = { "n", "x" },
    },
    {
      "<leader>rg",
      function()
        Snacks.picker.grep({ cwd = get_cwd() })
      end,
      mode = { "n" },
    },
    {
      "<leader>rgb",
      function()
        Snacks.picker.grep({
          dirs = { vim.fn.expand("%") },
        })
      end,
      mode = { "n" },
    },
    {
      "<leader>rgw",
      function()
        Snacks.picker.grep_word({
          cwd = get_cwd(),
          matcher = {
            fuzzy = false,
          },
        })
      end,
      mode = { "n" },
    },
    {
      "<leader>rgwb",
      function()
        Snacks.picker.grep_word({
          dirs = { vim.fn.expand("%") },
          matcher = {
            fuzzy = false,
          },
        })
      end,
      mode = { "n" },
    },
    {
      "<leader>rgv",
      function()
        Snacks.picker.grep_word({
          cwd = get_cwd(),
          matcher = {
            fuzzy = false,
          },
        })
      end,
      mode = { "x" },
    },
    {
      "<leader>rgvb",
      function()
        Snacks.picker.grep_word({
          dirs = { vim.fn.expand("%") },
          matcher = {
            fuzzy = false,
          },
        })
      end,
      mode = { "x" },
    },
    {
      "<leader>rgbl",
      function()
        Snacks.picker.lines({
          matcher = {
            fuzzy = false,
          },
        })
      end,
      mode = { "n" },
    },
    {
      "<C-x>",
      function()
        Snacks.bufdelete()
      end,
    },
    {
      "gd",
      function()
        Snacks.picker.lsp_definitions()
      end,
    },
    {
      "gr",
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
    },
    {
      "gi",
      function()
        Snacks.picker.lsp_implementations()
      end,
    },
    {
      "gt",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
    },
    {
      "<leader>:",
      function()
        Snacks.picker.command_history()
      end,
    },
  },
  opts = {
    explorer = {
      enabled = false,
    },
    picker = {
      enabled = true,
      hidden = true,
      sources = {
        files = {
          hidden = true,
        },
      },
      matcher = { cwd_bonus = true, frecency = true, sort_empty = true },
      win = {
        list = {
          wo = {
            conceallevel = 0,
          },
        },
      },
    },
    bufdelete = { enabled = true },
    rename = { enabled = true },
    indent = {
      enabled = true,
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
