vim.diagnostic.config({
  underline = false,
  severity_sort = true,
  float = {
    border = "single",
    focusable = false,
    wrap = false,
  },
  virtual_lines = {
    only_current_line = true,
    spacing = 1,
  },
})

vim.filetype.add({
  pattern = {
    [".env.*"] = "sh",
  },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { silent = true, wrap = false, title = "", focusable = false, border = "single" }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { silent = true, wrap = false, title = "", focusable = false, border = "single" }
)
