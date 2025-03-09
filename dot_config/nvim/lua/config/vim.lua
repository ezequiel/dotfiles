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
vim.opt.wildoptions = "pum"
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
vim.opt.relativenumber = true

vim.opt.backup = true
local backup_dir = vim.fn.expand("/tmp/nvim/backups/")
vim.opt.backupdir = backup_dir
vim.opt.directory = backup_dir
if not vim.fn.isdirectory(backup_dir) then
  vim.fn.mkdir(backup_dir, "p")
end

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

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set({ "n", "i" }, "<C-s>", "<Esc>:w<CR>")
vim.keymap.set("n", "<leader>1", ":bp<CR>")
vim.keymap.set("n", "<leader>2", ":bn<CR>")
vim.keymap.set("n", "Q", "<nop>", { silent = true })
vim.keymap.set("n", "q", "<nop>", { silent = true })
vim.keymap.set("n", "<leader>x", ":nohlsearch<cr>", { silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.cmd("syntax off")
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "Avante" },
  callback = function()
    vim.opt.conceallevel = 3
  end,
})
vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  command = "wincmd =",
})

local commands = {
  E = "e",
  W = "w",
  Wq = "wq",
  WQ = "wq",
  Wa = "wa",
  WA = "wa",
  WAq = "waq",
  WAQ = "waq",
  Waq = "waq",
  WQa = "wqa",
  Wqa = "wqa",
  WQA = "wqa",
  Q = "q",
  QA = "qa",
  Qa = "qa",
}

for cmd, action in pairs(commands) do
  vim.api.nvim_create_user_command(cmd, action .. "<bang> <args>", {
    bang = true,
    nargs = "?",
    complete = "file",
  })
end

vim.api.nvim_set_hl(0, "HighlightedyankRegion", { bg = "#404040" })
vim.keymap.set("n", "gf", ":GFI<CR>")
