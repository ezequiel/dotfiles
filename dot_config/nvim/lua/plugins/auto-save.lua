return {
  'okuuva/auto-save.nvim',
  lazy = false,
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
        'FocusLost',
      },
      defer_save = {
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
    condition = function()
      return (vim.fn.mode() ~= 'i' and vim.bo.filetype ~= 'qf' and vim.bo.filetype ~= '' and vim.bo.buftype ~= 'nofile')
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
