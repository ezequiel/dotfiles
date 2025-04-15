vim.keymap.set({ 'n', 'x' }, '<C-h>', '<C-w>h')
vim.keymap.set({ 'n', 'x' }, '<C-l>', '<C-w>l')
vim.keymap.set({ 'n', 'x' }, '<C-j>', '<C-w>j')
vim.keymap.set({ 'n', 'x' }, '<C-k>', '<C-w>k')
vim.keymap.set({ 'n', 'x' }, '<C-n>', function()
  local qf = vim.fn.getqflist({ idx = 0, size = 0, items = 1 })
  local item = qf.items[qf.idx]

  if not item then
    return
  end

  local current_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':p')
  local qf_path = vim.fn.fnamemodify(vim.fn.bufname(item.bufnr), ':p')
  local current_line = vim.api.nvim_win_get_cursor(0)[1]

  local same_file = current_path == qf_path
  local same_line = current_line == item.lnum

  if same_file and same_line then
    if qf.idx < qf.size then
      vim.cmd('cnext')
    end
  else
    vim.api.nvim_set_current_buf(item.bufnr)
    vim.api.nvim_win_set_cursor(0, { item.lnum, item.col > 0 and item.col - 1 or 0 })
  end
end, { silent = true })
vim.keymap.set({ 'n', 'x' }, '<C-p>', function()
  local qf = vim.fn.getqflist({ idx = 0, size = 0 })
  if qf.idx <= 1 then
    return
  end
  vim.cmd('cprev')
end, { silent = true })
vim.keymap.set({ 'n', 'x' }, '<C-p>', function()
  local qf = vim.fn.getqflist({ idx = 0, size = 0, items = 1 })
  local item = qf.items[qf.idx]

  if not item then
    return
  end

  local current_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':p')
  local qf_path = vim.fn.fnamemodify(vim.fn.bufname(item.bufnr), ':p')
  local current_line = vim.api.nvim_win_get_cursor(0)[1]

  local same_file = current_path == qf_path
  local same_line = current_line == item.lnum

  if same_file and same_line then
    if qf.idx > 1 then
      vim.cmd('cprev')
    end
  else
    vim.api.nvim_set_current_buf(item.bufnr)
    vim.api.nvim_win_set_cursor(0, { item.lnum, item.col > 0 and item.col - 1 or 0 })
  end
end, { silent = true })
local function escape_handler(key)
  vim.api.nvim_exec_autocmds('User', { pattern = 'EscapeHandler' })
  vim.cmd('nohlsearch')
  vim.schedule(function()
    vim.cmd('fclose!')
  end)
  return key
end
vim.keymap.set({ 'n', 'i', 'x' }, '<Esc>', function()
  return escape_handler('<Esc>')
end, { noremap = true, expr = true })
vim.keymap.set({ 'n', 'i', 'x' }, '<C-c>', function()
  return escape_handler('<c-c>')
end, { noremap = true, expr = true })
vim.keymap.set('n', '<s-tab>', '<cmd>bp<CR>')
vim.keymap.set('n', '<tab>', '<cmd>bn<CR>')
vim.keymap.set('n', 'J', '<nop>', { silent = true })
vim.keymap.set('n', 'Q', '<nop>', { silent = true })
vim.keymap.set('n', 'q', '<nop>', { silent = true })
vim.keymap.set('n', 'vv', '^vg_', { noremap = true, silent = true })
vim.keymap.set('x', '/', '<Esc>/\\%V')
vim.keymap.set('x', 'r', [[:s/\%V]])
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
end, { silent = true })

vim.keymap.set('n', '<C-W>|', '<C-W>v', { noremap = true })
vim.keymap.set('n', '<C-W>-', '<C-W>s', { noremap = true })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Move to next match' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Move to previous match' })
vim.keymap.set('n', '<leader>ds', function()
  vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
end, { desc = 'Open error diagnostics in quickfix list' })
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { noremap = true, silent = true })
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_prev)

local MID = '^=======$'
vim.keymap.set('n', '[x', function()
  pcall(function()
    vim.cmd('?' .. MID)
  end)
end, { silent = true })
vim.keymap.set('n', ']x', function()
  pcall(function()
    vim.cmd('/' .. MID)
  end)
end, { silent = true })

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
end, { expr = true, silent = true })
