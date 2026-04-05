vim.pack.add({
  'https://github.com/MagicDuck/grug-far.nvim',
})

require('grug-far').setup({
  folding = { enabled = false },
  helpLine = { enabled = false },
  icons = { enabled = false },
  resultLocation = { showNumberLabel = false },
  showInputsTopPadding = false,
  wrap = false,
  keymaps = {
    close = false,
    qflist = { n = '<C-q>' },
    refresh = { n = 'R' },
  },
})

local function grug_far_open(opts)
  local grug_far = require('grug-far')
  if grug_far.has_instance('1337') then
    grug_far.kill_instance('1337')
  end
  grug_far.open(vim.tbl_extend('force', { instanceName = '1337' }, opts or {}))
end

vim.keymap.set('n', '<leader>gb', function()
  grug_far_open({ prefills = { paths = vim.fn.expand('%') } })
end)

vim.keymap.set('n', '<leader>gf', function()
  grug_far_open()
end)

vim.keymap.set('n', '<leader>gr', function()
  require('grug-far').toggle_instance({ instanceName = '1337' })
end)

vim.keymap.set('n', '<leader>gw', function()
  grug_far_open({
    prefills = {
      flags = '--case-sensitive --fixed-strings --word-regexp',
      search = vim.fn.expand('<cword>'),
    },
  })
end)

vim.keymap.set('x', '<leader>gv', function()
  grug_far_open({
    prefills = {
      search = vim.fn.getreg('/'),
      flags = '--case-sensitive --fixed-strings',
    },
  })
end)

vim.api.nvim_create_autocmd('FileType', {
  group = 'my-config',
  pattern = 'grug-far',
  callback = function()
    vim.opt_local.signcolumn = 'no'
    vim.keymap.set('n', '<c-c>', function()
      require('grug-far').hide_instance('1337')
    end, { buffer = true })
  end,
})
