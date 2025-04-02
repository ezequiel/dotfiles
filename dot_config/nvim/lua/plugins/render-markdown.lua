local file_types = { "norg", "markdown", "qf", "codecompanion" }
return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    file_types = file_types,
  },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = file_types,
      callback = function()
        vim.opt.conceallevel = 3
      end,
    })
  end,
}
