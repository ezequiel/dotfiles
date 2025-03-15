return {
  "smjonas/inc-rename.nvim",
  cmd = "IncRename",
  keys = {
    {
      "<leader>rn",
      function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end,
      desc = "Incremental Rename",
      mode = { "n", "x" },
      noremap = true,
      expr = true,
    },
  },
  config = true,
}
