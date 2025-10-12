vim.keymap.set({ 'n', 'i', 'x' }, '<Esc>', function()
  vim.api.nvim_exec_autocmds('User', { pattern = 'EscapeHandler' })
  vim.cmd('nohlsearch')
  return '<Esc>'
end, { expr = true })

vim.keymap.set({ 'n', 'i', 'x' }, '<C-c>', function()
  vim.api.nvim_exec_autocmds('User', { pattern = 'EscapeHandler' })
  vim.cmd('nohlsearch')
  vim.schedule(function()
    vim.cmd('fclose!')
  end)
  require('multicursor-nvim').clearCursors()
  return '<C-c>'
end, { expr = true })

vim.keymap.set('n', 'vv', 'V')

vim.keymap.set('n', '<C-W>|', '<C-W>v')
vim.keymap.set('n', '<C-W>-', '<C-W>s')

vim.keymap.set('n', '<leader>ds', function()
  vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float)

vim.keymap.set('n', '[q', '<cmd>silent! cprevious<cr>')
vim.keymap.set('n', ']q', '<cmd>silent! cnext<cr>')
vim.keymap.set('n', '[Q', '<cmd>silent! colder<cr>')
vim.keymap.set('n', ']Q', '<cmd>silent! cnewer<cr>')

vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ wrap = false, count = -1, float = true })
end)
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ wrap = false, count = 1, float = true })
end)

vim.keymap.set('n', '[z', '[z^')
vim.keymap.set('n', ']z', ']z^')

vim.keymap.set('n', '[c', function()
  pcall(function()
    vim.cmd('?' .. '^=======$')
  end)
end)
vim.keymap.set('n', ']c', function()
  pcall(function()
    vim.cmd('/' .. '^=======$')
  end)
end)

vim.keymap.set('n', '<leader>go', function()
  vim.ui.open(('https://google.com/search?q=%s'):format(vim.fn.expand('<cword>')))
end)
vim.keymap.set('x', '<leader>go', function()
  vim.ui.open(
    ('https://google.com/search?q=%s'):format(
      vim.trim(table.concat(vim.fn.getregion(vim.fn.getpos('.'), vim.fn.getpos('v'), { type = vim.fn.mode() }), ' '))
    )
  )
  return '<esc>'
end, { expr = true })
