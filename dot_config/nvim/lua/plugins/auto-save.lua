return {
  "okuuva/auto-save.nvim",
  event = { "BufLeave", "BufWinLeave", "CmdlineLeave", "CmdwinLeave", "FocusLost", "QuitPre", "VimLeave", "VimSuspend", "WinLeave" },
  opts ={
    enabled = true,
    trigger_events = {
      immediate_save = { "BufLeave", "BufWinLeave", "CmdlineLeave", "CmdwinLeave", "FocusLost", "QuitPre", "VimLeave", "VimSuspend", "WinLeave" },
      defer_save = {},
      cancel_deferred_save = {},
    },
    write_all_buffers = true,
    debounce_delay=  0,
  }
}
