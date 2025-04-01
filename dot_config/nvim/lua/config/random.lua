vim.diagnostic.config({
  float = {
    border = "single",
    style = "minimal",
  },
  underline = false,
  severity_sort = true,
  virtual_lines = {
    current_line = true,
  },
})

vim.filetype.add({
  pattern = {
    [".env.*"] = "sh",
  },
})
