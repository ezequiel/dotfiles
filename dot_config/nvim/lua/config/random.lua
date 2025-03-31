vim.diagnostic.config({
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
