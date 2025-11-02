vim.cmd('syntax off')

vim.api.nvim_create_autocmd('ExitPre', {
  pattern = '*',
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_get_option(buf, 'buftype') == 'terminal' then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end,
})

vim.api.nvim_create_autocmd('TermClose', {
  pattern = '*',
  callback = function(event)
    vim.api.nvim_buf_delete(event.buf, { force = true })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'help', 'checkhealth', 'qf' },
  callback = function()
    vim.keymap.set('n', '<C-c>', '<cmd>close!<CR>', { buffer = true })
  end,
})

vim.api.nvim_create_user_command('Q', 'q', {})
vim.api.nvim_create_user_command('Qa', 'qa', {})
vim.api.nvim_create_user_command('QA', 'qa', {})
vim.api.nvim_create_user_command('E', 'e', {})
