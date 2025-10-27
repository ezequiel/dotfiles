vim.opt.autowrite = true
vim.opt.autowriteall = true
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
vim.opt.cmdheight = 0
vim.opt.fillchars = { fold = ' ' }
vim.opt.foldenable = false
vim.opt.foldlevel = 1337
vim.opt.foldmethod = 'expr'
vim.opt.foldtext = ''
vim.opt.ignorecase = true
vim.opt.modified = true
vim.opt.scrolloff = 1337
vim.opt.mouse = ''
vim.opt.ruler = false
vim.opt.shortmess:append('I')
vim.opt.mps:append('<:>')
vim.opt.signcolumn = 'yes:2'
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.stl = "%{repeat('─',winwidth('.'))}"
vim.opt.wrap = false
