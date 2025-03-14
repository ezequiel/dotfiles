return {
  "okuuva/auto-save.nvim",
  -- keep this in sync with immediate_save
  event = {
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
      defer_save = {},
      cancel_deferred_save = {},
    },
    condition = function()
      return vim.bo.filetype ~= "qf"
    end,
    write_all_buffers = true,
  },
}
