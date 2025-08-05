vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')

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

vim.keymap.set('n', 'J', '<nop>')
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', 'q', '<nop>')

vim.keymap.set('n', 'vv', 'V')

vim.keymap.set({ 'n', 'x' }, '*', function()
  vim.fn.setreg('/', '')
  local search_text
  if vim.fn.mode() == 'v' or vim.fn.mode() == 'x' then
    vim.cmd('normal! "zy')
    search_text = vim.fn.getreg('z')
  else
    search_text = vim.fn.expand('<cword>')
  end
  search_text = vim.fn.escape(search_text, '\\^$.*[]')

  if search_text:match('^%w+$') then
    search_text = '\\<' .. search_text .. '\\>'
  end

  vim.fn.setreg('/', search_text)
  vim.opt.hlsearch = true
  vim.cmd('normal! nN')
end)

vim.keymap.set('n', '<C-W>|', '<C-W>v')
vim.keymap.set('n', '<C-W>-', '<C-W>s')

vim.keymap.set('n', '<leader>ds', function()
  vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float)

vim.keymap.set('n', '[q', '<cmd>cprevious<cr>')
vim.keymap.set('n', ']q', '<cmd>cnext<cr>')

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

vim.keymap.set('i', '<CR>', function()
  local line = vim.api.nvim_get_current_line()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))

  local before_cursor = line:sub(1, col)
  local after_cursor = line:sub(col + 1)

  local open_tag = before_cursor:match('<([%w:-]+)>%s*$')
  local close_tag = after_cursor:match('^%s*</([%w:-]+)>')

  if open_tag and close_tag and open_tag == close_tag then
    return '<CR><Esc>O'
  else
    return '<CR>'
  end
end, { expr = true })

vim.keymap.set('n', '^', '0')
vim.keymap.set('n', '0', '^')
