vim.pack.add({ { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.*') } })

require('blink.cmp').setup({
  enabled = function()
    return not vim.tbl_contains({ 'nofile', 'prompt' }, vim.bo.buftype) and vim.b.completion ~= false
  end,
  sources = {
    default = { 'lsp', 'path' },
  },
  fuzzy = { implementation = 'rust' },
  keymap = {
    preset = 'none',
    ['<C-space>'] = { 'show', 'hide' },
    ['K'] = { 'show_documentation', 'hide_documentation', 'fallback' },
    ['<C-n>'] = { 'select_next' },
    ['<C-p>'] = { 'select_prev' },
    ['<Down>'] = { 'select_next', 'fallback' },
    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
  },
  signature = {
    enabled = true,
    window = {
      show_documentation = false,
      scrollbar = true,
    },
  },
  completion = {
    list = {
      selection = {
        auto_insert = false,
        preselect = false,
      },
    },
    menu = {
      auto_show = true,
      draw = {
        columns = {
          { 'label' },
          { 'kind', 'label_description', gap = 1 },
        },
        components = {
          label = { ellipsis = true, width = { max = 38, fill = false } },
          kind = { width = { fill = true } },
          label_description = { ellipsis = true, width = { max = 38, fill = false } },
        },
      },
    },
    accept = { auto_brackets = { enabled = false } },
  },
})
