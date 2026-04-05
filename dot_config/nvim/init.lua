vim.loader.enable()

vim.g.loaded_gzip = true
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
vim.g.loaded_remote_plugins = true
vim.g.loaded_tarPlugin = true
vim.g.loaded_tutor_mode_plugin = true
vim.g.loaded_zipPlugin = true
vim.g.loaded_man = true
vim.g.loaded_remote_file_loader = true
vim.g.loaded_spellfile_plugin = true
vim.g.loaded_shada_plugin = true
vim.g.editorconfig = false
vim.g.did_install_default_menus = true
vim.g.did_install_syntax_menu = true

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '●',
      [vim.diagnostic.severity.WARN] = '●',
      [vim.diagnostic.severity.HINT] = '●',
      [vim.diagnostic.severity.INFO] = '●',
    },
  },
  float = {
    source = true,
    wrap = false,
  },
  underline = false,
  severity_sort = true,
  update_in_insert = false,
})

do
  local orig = vim.diagnostic.handlers.signs
  vim.diagnostic.handlers.signs = {
    show = function(ns, bufnr, diagnostics, opts)
      local max_per_line = {} --- @type table<integer, vim.Diagnostic>
      for _, d in pairs(diagnostics) do
        local m = max_per_line[d.lnum]
        if not m or d.severity < m.severity then
          max_per_line[d.lnum] = d
        end
      end
      orig.show(ns, bufnr, vim.tbl_values(max_per_line), opts)
    end,
    hide = orig.hide,
  }
end

----------------------------------------------------
----------------------------------------------------

local augroup = vim.api.nvim_create_augroup('my-config', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = { 'help', 'checkhealth', 'qf' },
  callback = function()
    vim.keymap.set('n', '<C-c>', '<cmd>close!<CR>', { buffer = true })
  end,
})

vim.keymap.set({ 'n', 'i', 'x' }, '<C-c>', function()
  vim.schedule(function()
    vim.cmd('fclose!')
  end)
  local copilot = package.loaded['copilot.suggestion']
  if copilot then
    copilot.dismiss()
  end
  return '<C-c>'
end, { silent = true, expr = true })

----------------------------------------------------
----------------------------------------------------

local session = vim.fn.stdpath('state') .. '/session_restart.vim'

vim.keymap.set('n', '<M-r>', function()
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

----------------------------------------------------
----------------------------------------------------

vim.keymap.set('n', '+', '<C-a>')
vim.keymap.set('n', '-', '<C-x>')
vim.keymap.set({ 'n', 'i', 'x' }, '<c-q>', '<cmd>q!<cr>')
vim.keymap.set('n', '<C-j>', '<C-W>j')
vim.keymap.set('n', '<C-k>', '<C-W>k')
vim.keymap.set('n', '<C-h>', '<C-W>h')
vim.keymap.set('n', '<C-l>', '<C-W>l')
vim.keymap.set('n', 'vv', 'V')
vim.keymap.set('n', '<C-W>|', '<C-W>v')
vim.keymap.set('n', '<C-W>-', '<C-W>s')
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
  vim.ui.open(('https://google.com/search?q=%s'):format(vim.uri_encode(vim.fn.expand('<cword>'))))
end)
vim.keymap.set('x', '<leader>go', function()
  vim.ui.open(
    ('https://google.com/search?q=%s'):format(
      vim.uri_encode(
        vim.trim(table.concat(vim.fn.getregion(vim.fn.getpos('.'), vim.fn.getpos('v'), { type = vim.fn.mode() }), ' '))
      )
    )
  )
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
end)
vim.keymap.set({ 'n', 't' }, '<leader>zo', function()
  if vim.t.zoomed and vim.t.zoom_winrestcmd then
    vim.cmd(vim.t.zoom_winrestcmd)
    vim.t.zoomed = false
  else
    vim.t.zoom_winrestcmd = vim.fn.winrestcmd()
    vim.cmd('resize | vertical resize')
    vim.t.zoomed = true
  end
end)
vim.keymap.set('n', '<leader>ds', function()
  vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set('n', '<M-S-j>', "<cmd>execute 'move .+' . v:count1<cr>==")
vim.keymap.set('n', '<M-S-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==")
vim.keymap.set('i', '<M-S-j>', '<esc><cmd>m .+1<cr>==gi')
vim.keymap.set('i', '<M-S-k>', '<esc><cmd>m .-2<cr>==gi')
vim.keymap.set('x', '<M-S-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv")
vim.keymap.set('x', '<M-S-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv")
vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv')
vim.keymap.set('n', '<C-w>d', function()
  local _, win = vim.diagnostic.open_float()
  if not win then
    return
  end
  vim.api.nvim_set_current_win(win)
end)

----------------------------------------------------
----------------------------------------------------

vim.opt.linebreak = false
vim.opt.scrolloff = 1337
vim.opt.backup = true

local backup_dir = vim.fn.stdpath('state') .. '/backup//'
vim.opt.backupdir = backup_dir
vim.fn.mkdir(backup_dir:gsub('//$', ''), 'p')

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.opt.cmdheight = 0
vim.opt.ignorecase = true
vim.opt.ruler = false
vim.opt.shortmess:append('I')
vim.opt.signcolumn = 'yes:2'
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.diffopt:append('linematch:30')
vim.opt.winborder = 'single'
vim.opt.pumborder = 'single'
vim.opt.laststatus = 0
vim.opt.statusline = "%{repeat('─',winwidth('.'))}"

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/serhez/teide.nvim',
})

require('teide').setup({
  style = 'darker',
})

vim.api.nvim_create_autocmd('ColorScheme', {
  group = augroup,
  pattern = 'teide',
  callback = function()
    vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#6A6A6A', bg = '#171B20' })
    vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = '#6A6A6A', bg = '#171B20' })
    vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#6A6A6A', bg = '#171B20' })
  end,
})

vim.cmd('colorscheme teide')
