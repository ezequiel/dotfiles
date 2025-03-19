local function get_cwd()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")[1]
  if vim.v.shell_error ~= 0 then
    return vim.fn.getcwd()
  end
  return git_root
end

-- credit: https://github.com/MaJinjie
-- https://github.com/MaJinjie/nvim/blob/main/lua/util/keymap.lua#L8
local function buf_delete(opts)
  opts = opts or {}
  opts = type(opts) == "number" and { buf = opts } or opts
  opts = type(opts) == "function" and { filter = opts } or opts

  if type(opts.filter) == "function" then
    for _, b in ipairs(vim.tbl_filter(opts.filter, vim.api.nvim_list_bufs())) do
      if vim.bo[b].buflisted then
        buf_delete(vim.tbl_extend("force", {}, opts, { buf = b, filter = false }))
      end
    end
    return
  end

  local buf = opts.buf or 0
  buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

  vim.api.nvim_buf_call(buf, function()
    if vim.bo.modified and not opts.force then
      local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
      if choice == 0 or choice == 3 then -- 0 for <Esc>/<C-c> and 3 for Cancel
        return
      end
      if choice == 1 then -- Yes
        vim.cmd.write()
      end
    end

    for _, win in ipairs(vim.fn.win_findbuf(buf)) do
      vim.api.nvim_win_call(win, function()
        if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
          return
        end
        -- Try using alternate buffer
        local alt = vim.fn.bufnr("#")
        if alt ~= buf and vim.fn.buflisted(alt) == 1 then
          vim.api.nvim_win_set_buf(win, alt)
          return
        end

        -- Try using previous buffer
        local has_previous = pcall(vim.cmd, "bprevious")
        if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
          return
        end

        -- Create new listed buffer
        local new_buf = vim.api.nvim_create_buf(true, false)
        vim.api.nvim_win_set_buf(win, new_buf)
      end)
    end
    if vim.api.nvim_buf_is_valid(buf) then
      pcall(vim.cmd, (opts.wipe and "bwipeout! " or "bdelete! ") .. buf)
    end
  end)
end

return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  dependencies = {
    "tpope/vim-sleuth",
    "stevearc/oil.nvim",
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
      enabled = false,
    },
    picker = {
      enabled = true,
      hidden = true,
      cwd = get_cwd(),
      sources = {
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
  config = function(_, opts)
    require("snacks").setup(opts)
    local augroup = vim.api.nvim_create_augroup("oil", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilActionsPost",
      group = augroup,
      desc = "Close buffers when files are deleted in Oil",
      callback = function(args)
        if args.data.err then
          return
        end
        for _, action in ipairs(args.data.actions) do
          if action.type == "delete" then
            local _, path = require("oil.util").parse_url(action.url)
            local bufnr = vim.fn.bufnr(path)
            if bufnr ~= -1 then
              buf_delete({ buf = bufnr, wipe = true })
            end
          end
        end
      end,
    })
  end,
}
