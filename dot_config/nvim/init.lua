vim.keymap.set({ 'n', 'i', 'x' }, '<c-q>', '<cmd>q!<cr>')
vim.keymap.set('n', 'vv', 'V')
vim.keymap.set('n', '<C-j>', '<C-W>j')
vim.keymap.set('n', '<C-k>', '<C-W>k')
vim.keymap.set('n', '<C-h>', '<C-W>h')
vim.keymap.set('n', '<C-l>', '<C-W>l')
vim.keymap.set('n', '<C-W>|', '<C-W>v')
vim.keymap.set('n', '<C-W>-', '<C-W>s')

vim.opt.laststatus = 0
vim.opt.statusline = "%{repeat('─',winwidth('.'))}"
vim.opt.ruler = false
vim.opt.showcmd = false
vim.opt.wrap = false

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
vim.opt.shortmess:append('I')
vim.opt.autoread = true 
vim.opt.splitbelow = true
vim.opt.splitright = true

local augroup = vim.api.nvim_create_augroup('my-config', { clear = true })
local mc_ns = vim.api.nvim_create_namespace('nvim.multicursor')

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = { 'help', 'checkhealth', 'qf' },
  callback = function()
    vim.keymap.set('n', '<C-c>', '<cmd>close!<CR>', { buffer = true })
  end,
})

vim.keymap.set({ 'n', 'i', 'x' }, '<C-c>', function()
  vim.schedule(function()
    vim.api.nvim_buf_clear_namespace(0, mc_ns, 0, -1) 
    vim.cmd('fclose!')
  end)
  return '<C-c>'
end, { silent = true, expr = true })

local session = vim.fn.stdpath('state') .. '/session_restart.vim'

vim.keymap.set('n', '<D-r>', function()
  vim.cmd.mksession({ session, bang = true })
  vim.cmd.restart()
end)

vim.api.nvim_create_autocmd('VimEnter', {
  group = augroup,
  callback = vim.schedule_wrap(function()
    if not vim.uv.fs_stat(session) then
      return
    end
    vim.cmd.source(session)
    vim.fs.rm(session)
  end),
})
