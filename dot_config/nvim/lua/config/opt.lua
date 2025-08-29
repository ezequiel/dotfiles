vim.opt.autowrite = true
vim.opt.autowriteall = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.bufhidden = 'hide'
vim.opt.clipboard = 'unnamed'
vim.opt.cmdheight = 0
vim.opt.endoffile = true
vim.opt.fillchars:append({ diff = ' ' })
vim.opt.foldexpr = nil
vim.opt.foldlevel = 999
vim.opt.ignorecase = true
vim.opt.isfname:append('@-@')
vim.opt.jumpoptions = 'stack,view'
vim.opt.modified = true
vim.opt.mouse = ''
vim.opt.numberwidth = 5
vim.opt.secure = true
vim.opt.shortmess:append('F')
vim.opt.shortmess:append('I')
vim.opt.shortmess:append('T')
vim.opt.showmatch = true
vim.opt.signcolumn = 'yes:2'
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.stl = "%{repeat('─',winwidth('.'))}"
vim.opt.termguicolors = true
vim.opt.timeoutlen = 800
vim.opt.ttyfast = true
vim.opt.undolevels = 9999999
vim.opt.undoreload = 9999999
vim.opt.updatetime = 100
vim.opt.wildignore = '*/node_modules,*/vendor,.git'
vim.opt.wildignorecase = true
vim.opt.wildmode = 'longest:full,full'
vim.opt.wildoptions = 'pum'
vim.opt.wrap = false
vim.opt.writeany = true
vim.opt.ruler = false
