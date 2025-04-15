vim.diagnostic.config({
  signs = {
    active = true,
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.HINT] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
    },
  },
  float = {
    border = 'single',
    source = 'always',
    header = '',
    prefix = '',
    wrap = false,
  },
  underline = false,
  severity_sort = true,
  update_in_insert = false,
})

vim.filetype.add({
  pattern = {
    ['.env.*'] = 'sh',
  },
})
