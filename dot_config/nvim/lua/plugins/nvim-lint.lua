return {
  "mfussenegger/nvim-lint",
  -- keep this in sync with linters_by_ft
  ft = { "go" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      go = { "golangcilint" },
    }
    lint.try_lint()
    vim.api.nvim_create_autocmd("User", {
      pattern = "AutoSaveWritePost",
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
