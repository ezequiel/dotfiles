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
vim.opt.backspace = "indent,eol,start"
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.guicursor = ""
vim.opt.relativenumber = true
vim.opt.numberwidth = 5
vim.opt.shortmess:append("I")
vim.opt.backup = true
vim.opt.foldcolumn = "0"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldlevel = 1337
vim.opt.foldlevelstart = 1337

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

vim.keymap.set({ "n", "x" }, "<C-h>", "<C-w>h")
vim.keymap.set({ "n", "x" }, "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

vim.keymap.set({ "n", "i", "x" }, "<C-s>", "<Esc><cmd>doautocmd FocusLost<CR>", { noremap = true })
vim.keymap.set({ "n", "i", "x" }, "<Esc>", "<Esc><cmd>doautocmd FocusLost<CR>", { noremap = true })
vim.keymap.set({ "n", "i", "x" }, "<C-c>", "<C-c><cmd>doautocmd FocusLost<CR>", { noremap = true })
vim.keymap.set("n", "<leader>1", "<cmd>bp<CR>")
vim.keymap.set("n", "<leader>2", "<cmd>bn<CR>")
vim.keymap.set("n", "Q", "<nop>", { silent = true })
vim.keymap.set("n", "q", "<nop>", { silent = true })
vim.keymap.set("n", "<leader>x", "<cmd>nohlsearch<cr><cmd>Noice dismiss<cr>", { silent = true })
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "vv", "^vg_", { noremap = true, silent = true })

vim.cmd("syntax off")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "Avante", "trouble" },
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

vim.keymap.set({ "n", "x" }, "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")

vim.keymap.set("x", "/", "<Esc>/\\%V")
-- vim.keymap.set("x", "r", [[:s/\%V]])
-- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
