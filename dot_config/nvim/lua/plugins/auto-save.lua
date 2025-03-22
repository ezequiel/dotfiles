return {
  "okuuva/auto-save.nvim",
  opts = {
    enabled = true,
    trigger_events = {
      immediate_save = {
        "BufLeave",
        "BufWinLeave",
        "FocusLost",
        "QuitPre",
        "VimLeave",
        "VimSuspend",
        "WinLeave",
      },
      defer_save = {
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
}
