return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    file_types = { "norg", "markdown", "Avante", "qf" },
  },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown", "Avante", "norg" },
      callback = function()
        vim.opt.conceallevel = 3
      end,
    })
  end,
}
