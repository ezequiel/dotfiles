vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"
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
vim.opt.wildoptions = pum
vim.opt.wildignorecase = true
vim.opt.wildignore = "*/node_modules,*/vendor,.git"
vim.opt.foldmethod = "marker"
vim.opt.backspace = "indent,eol,start"
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.foldenable = false
vim.opt.guicursor = ""

vim.diagnostic.config({
  underline = false,
  severity_sort = true,
  float = {
    border = "single",
  },
  virtual_lines = {
    only_current_line = true,
    spacing = 1,
  },
})

vim.cmd("colorscheme habamax")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
