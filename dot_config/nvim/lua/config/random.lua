vim.diagnostic.config({
  underline = false,
  severity_sort = true,
  float = {
    border = "single",
    focusable = false,
    wrap = true,
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
