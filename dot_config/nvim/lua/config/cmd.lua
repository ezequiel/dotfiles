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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "j", "j^", { noremap = true, buffer = true })
    vim.keymap.set("n", "k", "k^", { noremap = true, buffer = true })
    vim.keymap.set("n", "<C-n>", "j^", { buffer = true })
    vim.keymap.set("n", "<C-p>", "k^", { buffer = true })
    vim.keymap.set("n", "<Down>", "j^", { buffer = true })
    vim.keymap.set("n", "<Up>", "k^", { buffer = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "help",
    "startuptime",
    "qf",
    "lspinfo",
    "man",
    "checkhealth",
  },
  command = [[
            nnoremap <buffer><silent> <C-c> :close<CR>
            set nobuflisted
        ]],
})
