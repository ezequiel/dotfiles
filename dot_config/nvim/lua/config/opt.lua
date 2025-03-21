vim.opt.laststatus = 3
vim.opt.wrapscan = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 9999999
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.title = true
vim.opt.clipboard = "unnamed"
vim.opt.undolevels = 9999999
vim.opt.undoreload = 9999999
vim.opt.modified = true
vim.opt.showmatch = true
vim.opt.softtabstop = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.copyindent = true
vim.opt.preserveindent = true
vim.opt.endofline = true
vim.opt.endoffile = true
vim.opt.fixendofline = true
vim.opt.autowrite = true
vim.opt.autowriteall = true
vim.opt.writeany = true
vim.opt.secure = true
vim.opt.bufhidden = "hide"
vim.opt.equalalways = true
vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.background = "dark"
vim.opt.belloff = "all"
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ruler = true
vim.opt.smarttab = true
vim.opt.ttyfast = true
vim.opt.mouse = "a"
vim.opt.mousemodel = "popup_setpos"
vim.opt.updatetime = 100
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildoptions = "pum"
vim.opt.wildignorecase = true
vim.opt.wildignore = "*/node_modules,*/vendor,.git"
vim.opt.backspace = "indent,eol,start"
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.guicursor = ""
vim.opt.relativenumber = true
vim.opt.numberwidth = 5
vim.opt.shortmess:append("I")
vim.opt.foldcolumn = "0"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldlevel = 1337
vim.opt.foldlevelstart = 1337
vim.opt.smoothscroll = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- vim.opt.backupdir=~/.vim/backup//
-- vim.opt.directory=~/.vim/swap//
-- vim.opt.undodir=~/.vim/undo//

-- local backup_dir = vim.fn.expand("/tmp/nvim/backups/")
-- vim.opt.backupdir = backup_dir
-- vim.opt.directory = backup_dir
-- if not vim.fn.isdirectory(backup_dir) then
--   vim.fn.mkdir(backup_dir, "p")
-- end
