return {
  event = 'CursorMoved',
  'unblevable/quick-scope',
  init = function()
    vim.g.qs_lazy_highlight = 1
    vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
    vim.cmd("highlight QuickScopePrimary guifg='#00ffff' gui=bold,underline ctermfg=14 cterm=bold,underline")
    -- vim.cmd.highlight("QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline")
  end,
}
