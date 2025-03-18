return {
  "okuuva/auto-save.nvim",
  opts = {
    enabled = true,
    trigger_events = {
      immediate_save = {
        "BufLeave",
        "BufWinLeave",
        "CmdlineLeave",
        "CmdwinLeave",
        "FocusLost",
        "QuitPre",
        "VimLeave",
        "VimSuspend",
        "WinLeave",
      },
      defer_save = {
        "TextChanged",
        "TextChangedP",
      },
      cancel_deferred_save = {},
    },
    condition = function()
      return vim.bo.filetype ~= "qf" and vim.bo.filetype ~= "oil"
    end,
    write_all_buffers = true,
  },
}
