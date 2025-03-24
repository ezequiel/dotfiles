return {
  "okuuva/auto-save.nvim",
  opts = {
    enabled = true,
    trigger_events = {
      immediate_save = {
        "BufLeave",
        "BufWinLeave",
        "QuitPre",
        "VimLeave",
        "VimSuspend",
        "WinLeave",
      },
      defer_save = {
        "FocusLost",
        "TextChanged",
        "TextChangedP",
        "InsertLeave",
        { "User", pattern = "VisualLeave" },
      },
      cancel_deferred_save = {
        "InsertEnter",
        { "User", pattern = "VisualEnter" },
      },
    },
    condition = function()
      local mode = vim.fn.mode()
      if mode == "i" then
        return false
      end
      return vim.bo.filetype ~= "qf"
    end,
    write_all_buffers = true,
  },
  init = function()
    vim.api.nvim_create_autocmd("ModeChanged", {
      pattern = { "*:[vV\x16]*" },
      callback = function()
        vim.api.nvim_exec_autocmds("User", { pattern = "VisualEnter" })
      end,
    })
    vim.api.nvim_create_autocmd("ModeChanged", {
      pattern = { "[vV\x16]*:*" },
      callback = function()
        vim.api.nvim_exec_autocmds("User", { pattern = "VisualLeave" })
      end,
    })
  end,
}
