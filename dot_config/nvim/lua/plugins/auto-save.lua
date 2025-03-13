return {
  "okuuva/auto-save.nvim",
  event = { "WinLeave", "BufLeave", "FocusLost", "QuitPre", "VimSuspend" },
  opts = {
    enabled = true,
    trigger_events = {
      immediate_save = { "WinLeave", "BufLeave", "FocusLost", "QuitPre", "VimSuspend" },
      defer_save = {},
      cancel_deferred_save = {},
    },
    write_all_buffers = true
  },
}
