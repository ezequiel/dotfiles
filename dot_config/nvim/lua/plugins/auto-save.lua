return {
  'okuuva/auto-save.nvim',
  lazy = false,
  opts = {
    enabled = true,
    trigger_events = {
      immediate_save = {
        'BufHidden',
        'BufLeave',
        'BufWinLeave',
        'FocusLost',
        'QuitPre',
        'TabLeave',
        'VimLeave',
        'VimSuspend',
        'WinClosed',
        'WinLeave',
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
      return (
        vim.fn.mode() ~= 'i'
        and vim.bo.filetype ~= 'qf'
        and vim.bo.filetype ~= 'opencode_terminal'
        and vim.bo.filetype ~= ''
        and vim.bo.filetype ~= 'grug-far'
        and vim.bo.buftype ~= 'nofile'
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
    vim.keymap.set({ 'n', 'i', 'x' }, '<Esc>', function()
      vim.api.nvim_exec_autocmds('User', { pattern = 'EscapeHandler' })
      return '<Esc>'
    end, { expr = true })
    vim.keymap.set({ 'n', 'i', 'x' }, '<C-c>', function()
      vim.api.nvim_exec_autocmds('User', { pattern = 'EscapeHandler' })
      vim.schedule(function()
        vim.cmd('fclose!')
      end)
      return '<C-c>'
    end, { expr = true })
  end,
}
