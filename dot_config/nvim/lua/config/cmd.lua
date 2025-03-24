vim.cmd("syntax off")

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

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "VimEnter", "WinEnter", "BufWinEnter" }, {
  command = "checktime",
  pattern = "*",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<C-C>", "<cmd>q<CR>", { buffer = true, silent = true })
  end,
})
