require("config.lsp-rename-keymap")

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
vim.keymap.set({ "n", "x" }, "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
vim.keymap.set("x", "/", "<Esc>/\\%V")
vim.keymap.set("x", "r", [[:s/\%V]])
vim.keymap.set({ "n", "x" }, "*", function()
	vim.fn.setreg("/", "")
	local search_text
	if vim.fn.mode() == "v" or vim.fn.mode() == "x" then
		vim.cmd('normal! "zy')
		search_text = "\\<" .. vim.fn.getreg("z") .. "\\>"
	else
		search_text = "\\<" .. vim.fn.expand("<cword>") .. "\\>"
	end
	vim.fn.setreg("/", search_text)
	-- vim.cmd("let @/ = '" .. search_text .. "'")
	vim.opt.hlsearch = true
	vim.cmd("normal! nN")
end, { silent = true })
