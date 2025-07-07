local keys = { 'f', 'F', 't', 'T' }
return {
  'unblevable/quick-scope',
  keys = keys,
  init = function()
    vim.g.qs_lazy_highlight = 1
    vim.g.qs_highlight_on_keys = keys
    vim.cmd("highlight QuickScopePrimary guifg='#00ffff' gui=bold,underline ctermfg=14 cterm=bold,underline")
  end,
}
