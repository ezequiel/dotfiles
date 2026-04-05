vim.pack.add({
  'https://github.com/okuuva/auto-save.nvim',
})

require('auto-save').setup({
  trigger_events = {
    immediate_save = {
      'BufLeave',
      'FocusLost',
      'QuitPre',
      'VimSuspend',
    },
    defer_save = {
      'CursorHold',
      'InsertLeave',
      'TextChanged',
    },
    cancel_deferred_save = { 'InsertEnter' },
  },
  write_all_buffers = true,
})
