return {
  "mfussenegger/nvim-lint",
  event = "BufReadPre",
  config = function()
    vim.env.ESLINT_D_MISS = "fail"
    vim.env.ESLINT_D_PPID = vim.fn.getpid()
    vim.env.ESLINT_D_IDLE = "1337"
    require("lint").linters_by_ft = {
      css = { "eslint_d" },
      html = { "eslint_d" },
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      json = { "eslint_d" },
      jsonc = { "eslint_d" },
      scss = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    }
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
