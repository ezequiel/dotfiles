vim.cmd('syntax off')

vim.api.nvim_create_autocmd('VimResized', {
  pattern = '*',
  command = 'wincmd =',
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

    local line_count = vim.fn.line('$')
    local height = math.max(math.min(line_count, 10), 0)
    vim.cmd(height .. 'wincmd _')
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'help',
    'startuptime',
    'qf',
    'lspinfo',
    'man',
    'checkhealth',
  },
  command = [[
            nnoremap <buffer><silent> <C-c> :close<CR>
            set nobuflisted
        ]],
})

local function is_floating_win(win)
  return vim.api.nvim_win_get_config(win).relative ~= ''
end

vim.api.nvim_create_autocmd('WinEnter', {
  callback = function()
    local win = vim.api.nvim_get_current_win()
    if not is_floating_win(win) then
      return
    end

    local buffer = vim.api.nvim_win_get_buf(win)
    vim.keymap.set('n', '<left>', 'hzh', { buffer = buffer })
    vim.keymap.set('n', '<right>', 'lzl', { buffer = buffer })
    vim.keymap.set('n', '<up>', '<c-y>k', { buffer = buffer })
    vim.keymap.set('n', '<down>', '<c-e>', { buffer = buffer })
    vim.keymap.set('n', '<s-left>', 'zHg0', { buffer = buffer })
    vim.keymap.set('n', '<s-right>', 'zL', { buffer = buffer })
  end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    require('lazy').update({ show = false })
  end,
})
