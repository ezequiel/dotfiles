return {
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    keys = {
      {
        "<leader>r",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        desc = "Incremental Rename",
        mode = { "n", "v", "o", "x" },
        noremap = true,
        expr = true,
      },
    },
    config = true,
  },
}
