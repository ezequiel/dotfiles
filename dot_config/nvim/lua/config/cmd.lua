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

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = { "*:[vV\x16]*" },
  callback = function()
    vim.api.nvim_exec_autocmds("User", { pattern = "VisualEnter" })
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = { "[vV\x16]*:*" },
  callback = function()
    vim.api.nvim_exec_autocmds("User", { pattern = "VisualLeave" })
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local angularLsClients = vim.lsp.get_clients({ bufnr = event.buf, name = "angularls" })
    if client and client.name == "vtsls" and #angularLsClients > 0 then
      client.server_capabilities.referencesProvider = false
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    vim.keymap.set("n", "H", function()
      vim.lsp.buf.hover()
    end, { buffer = event.buf })
  end,
})
