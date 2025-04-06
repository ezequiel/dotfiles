vim.keymap.set({ "n", "x" }, "<C-h>", "<C-w>h")
vim.keymap.set({ "n", "x" }, "<C-l>", "<C-w>l")
vim.keymap.set({ "n", "x" }, "<C-j>", "<C-w>j")
vim.keymap.set({ "n", "x" }, "<C-k>", "<C-w>k")
vim.keymap.set({ "n", "x" }, "<C-n>", function()
  local qf = vim.fn.getqflist({ idx = 0, size = 0 })
  if qf.idx >= qf.size then
    return
  end
  vim.cmd("cnext")
end, { silent = true })
vim.keymap.set({ "n", "x" }, "<C-p>", function()
  local qf = vim.fn.getqflist({ idx = 0, size = 0 })
  if qf.idx <= 1 then
    return
  end
  vim.cmd("cprev")
end, { silent = true })
vim.keymap.set(
  { "n", "i", "x" },
  "<Esc>",
  "<Esc><cmd>doautocmd FocusLost<CR><cmd>nohlsearch<CR><cmd>fclose!<cr>",
  { noremap = true }
)
vim.keymap.set(
  { "n", "i", "x" },
  "<C-c>",
  "<C-c><cmd>doautocmd FocusLost<CR><cmd>nohlsearch<CR><cmd>fclose!<cr>",
  { noremap = true }
)
vim.keymap.set("n", "<leader>1", "<cmd>bp<CR>")
vim.keymap.set("n", "<leader>2", "<cmd>bn<CR>")
vim.keymap.set("n", "J", "<nop>", { silent = true })
vim.keymap.set("n", "Q", "<nop>", { silent = true })
vim.keymap.set("n", "q", "<nop>", { silent = true })
vim.keymap.set("n", "vv", "V", { noremap = true, silent = true })
vim.keymap.set("x", "/", "<Esc>/\\%V")
vim.keymap.set("x", "r", [[:s/\%V]])
vim.keymap.set({ "n", "x" }, "*", function()
  vim.fn.setreg("/", "")
  local search_text
  if vim.fn.mode() == "v" or vim.fn.mode() == "x" then
    vim.cmd('normal! "zy')
    search_text = vim.fn.getreg("z")
  else
    search_text = vim.fn.expand("<cword>")
  end
  search_text = vim.fn.escape(search_text, "\\^$.*[]")

  if search_text:match("^%w+$") then
    search_text = "\\<" .. search_text .. "\\>"
  end

  vim.fn.setreg("/", search_text)
  vim.opt.hlsearch = true
  vim.cmd("normal! nN")
end, { silent = true })

vim.keymap.set("n", "<C-W>|", "<C-W>v", { noremap = true })
vim.keymap.set("n", "<C-W>-", "<C-W>s", { noremap = true })
vim.keymap.set("n", "n", "nzzzv", { desc = "Move to next match" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Move to previous match" })
vim.keymap.set("n", "<leader>ds", vim.diagnostic.setqflist, { desc = "Open diagnostics in quickfix list" })
vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { noremap = true, silent = true })

local MID = "^=======$"
vim.keymap.set("n", "[x", function()
  vim.cmd("?" .. MID)
end)
vim.keymap.set("n", "]x", function()
  vim.cmd("/" .. MID)
end)
