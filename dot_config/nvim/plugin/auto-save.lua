vim.pack.add({
  'https://github.com/okuuva/auto-save.nvim',
})

require('auto-save').setup({
  trigger_events = {
    immediate_save = {
      'FocusLost',
      'QuitPre',
      'VimSuspend',
    },
    defer_save = {
      'BufLeave',
      'CursorHold',
      'InsertLeave',
      'TextChanged',
    },
    cancel_deferred_save = { 'InsertEnter' },
  },
  write_all_buffers = true,
})
