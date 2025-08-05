vim.cmd('syntax off')

vim.api.nvim_create_autocmd('VimResized', {
  callback = function()
    vim.cmd('wincmd =')
  end,
})

local commands = {
  E = 'e',
  W = 'w',
  Wq = 'wq',
  WQ = 'wq',
  Wa = 'wa',
  WA = 'wa',
  WAq = 'waq',
  WAQ = 'waq',
  Waq = 'waq',
  WQa = 'wqa',
  Wqa = 'wqa',
  WQA = 'wqa',
  Q = 'q',
  QA = 'qa',
  Qa = 'qa',
}

for cmd, action in pairs(commands) do
  vim.api.nvim_create_user_command(cmd, action .. '<bang> <args>', {
    bang = true,
    nargs = '?',
    complete = 'file',
  })
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    vim.keymap.set('n', '<C-n>', 'j^', { buffer = true })
    vim.keymap.set('n', '<C-p>', 'k^', { buffer = true })
    vim.keymap.set('n', '<Down>', 'j^', { buffer = true })
    vim.keymap.set('n', '<Up>', 'k^', { buffer = true })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'help', 'startuptime', 'qf', 'lspinfo', 'man', 'checkhealth' },
  callback = function()
    vim.keymap.set('n', '<C-c>', '<cmd>close<CR>', { buffer = true, silent = true })
    vim.bo.buflisted = false
  end,
})
