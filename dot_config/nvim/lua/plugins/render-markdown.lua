return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter",
      config = function()
        vim.api.nvim_create_autocmd("FileType", {
          pattern = { "markdown", "Avante" },
          callback = function()
            vim.opt.conceallevel = 3
          end,
        })
        require("nvim-treesitter.configs").setup({
          highlight = { enable = true },
        })
      end,
    },
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "markdown", "Avante" },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    file_types = { "markdown", "Avante" },
  },
}
