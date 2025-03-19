return {
  event = "VeryLazy",
  "farmergreg/vim-lastplace",
  config = function()
    vim.g.lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit,svn,xxd"
    vim.g.lastplace_ignore_buftype = "quickfix,nofile,help,prompt"
    vim.g.lastplace_open_folds = 1
  end,
}
