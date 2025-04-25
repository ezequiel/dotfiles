return {
  'okuuva/auto-save.nvim',
  opts = {
    enabled = true,
    trigger_events = {
      immediate_save = {
        'BufLeave',
        'BufWinLeave',
        'QuitPre',
        'VimLeave',
        'VimSuspend',
        'WinLeave',
      },
      defer_save = {
        'FocusLost',
        'TextChanged',
        'TextChangedP',
        'InsertLeave',
        { 'User', pattern = 'VisualLeave' },
        { 'User', pattern = 'EscapeHandler' },
      },
      cancel_deferred_save = {
        'InsertEnter',
        { 'User', pattern = 'VisualEnter' },
      },
    },
    condition = function(buf)
      return not (
        vim.fn.mode() == 'i'
        or vim.bo.filetype == 'qf'
        or vim.bo.buftype == 'nofile'
        or vim.bo.filetype == 'harpoon'
      )
    end,
    write_all_buffers = true,
  },
  init = function()
    vim.api.nvim_create_autocmd('ModeChanged', {
      pattern = { '*:[vV\x16]*' },
      callback = function()
        vim.api.nvim_exec_autocmds('User', { pattern = 'VisualEnter' })
      end,
    })
    vim.api.nvim_create_autocmd('ModeChanged', {
      pattern = { '[vV\x16]*:*' },
      callback = function()
        vim.api.nvim_exec_autocmds('User', { pattern = 'VisualLeave' })
      end,
    })
  end,
}
